`uvm_analysis_imp_decl(_write_mon_scb)
`uvm_analysis_imp_decl(_read_mon_scb)

class async_fifo_scoreboard extends uvm_scoreboard;

	// Queues for write/read transactions
	async_fifo_write_sequence_item write_mon_queue[$];
	async_fifo_read_sequence_item  read_mon_queue[$];

	// FIFO memory model (reference)
	reg [`DATA_WIDTH-1:0] fifo_model[$];

	// Analysis imports from monitors
	uvm_analysis_imp_write_mon_scb#(async_fifo_write_sequence_item, async_fifo_scoreboard) write_scb_port;
	uvm_analysis_imp_read_mon_scb#(async_fifo_read_sequence_item,  async_fifo_scoreboard) read_scb_port;

	// Pass/fail counters
	int WRITE_PASS = 0;
	int WRITE_FAIL = 0;
	int READ_PASS  = 0;
	int READ_FAIL  = 0;

	// Factory registration
	`uvm_component_utils(async_fifo_scoreboard)

	//------------------------------------------------------//
	//                New Constructor                       //
	//------------------------------------------------------//

	function new(string name = "async_fifo_scoreboard", uvm_component parent = null);
		super.new(name, parent);
		write_scb_port = new("write_scb_port", this);
		read_scb_port  = new("read_scb_port", this);
	endfunction

	//------------------------------------------------------//
	// Capture transactions from write and read monitors    //
	//------------------------------------------------------//
	
	function void write_write_mon_scb(async_fifo_write_sequence_item wr_seq);
		write_mon_queue.push_back(wr_seq);
	endfunction

	function void write_read_mon_scb(async_fifo_read_sequence_item rd_seq);
		read_mon_queue.push_back(rd_seq);
	endfunction

	//------------------------------------------------------//
	//                  Main Run Phase                      //
	//------------------------------------------------------//
	
	task run_phase(uvm_phase phase);
		forever begin
			fork
				begin
					wait(write_mon_queue.size() > 0);
					extract_signals_from_write_monitor();
				end
				begin
					wait(read_mon_queue.size() > 0);
					extract_signals_from_read_monitor();
				end
			join_any

			comparision_report();
		end
	endtask

	//------------------------------------------------------//
	//  Extract signals from WRITE monitor & update model   //
	//------------------------------------------------------//
	
	task extract_signals_from_write_monitor();
		
		bit write_full;
		async_fifo_write_sequence_item write_seq;
		write_seq = write_mon_queue.pop_front();

		write_full = (fifo_model.size() == (`FIFO_DEPTH ));
		$display("<-------------------------------------------------------------------------------------------->");
		$display("\nWRITE_MON: %0t | RST=%b | EN=%b | DATA=%0d | FULL=%b", $time, write_seq.write_rst, write_seq.write_en,write_seq.write_data, write_full);
		//$display("monitor_write : FULL = %b", write_seq.write_full);

		if (!write_seq.write_rst) begin
			fifo_model.delete();
			WRITE_PASS++;
			$display("<============================ WRITE PASS ===========================>");
			$display("<-------------------------------------------------------------------------------------------->\n");
		end
		
		else if (write_seq.write_en) begin
			if( write_full ) begin
				if( write_seq.write_full ) begin
					WRITE_PASS++;
				end
			
				else
				begin
					$display("<============================ WRITE FAIL ===========================>");  
					WRITE_FAIL++;
					`uvm_error("SCOREBOARD",$sformatf("monitor_write : FULL = %b", write_seq.write_full));
				end
			end
			
			else begin
				fifo_model.push_back(write_seq.write_data);
				WRITE_PASS++;
				$display("<============================ WRITE PASS ===========================>");
				$display("<-------------------------------------------------------------------------------------------->\n");
			end
		end
	endtask

	//------------------------------------------------------//
	//  Extract signals from READ monitor & compare outputs //
	//------------------------------------------------------//

	task extract_signals_from_read_monitor();
		
		bit read_empty;
		async_fifo_read_sequence_item read_seq;
		static bit first_read = 1;  // flag to skip first read
		read_seq = read_mon_queue.pop_front();

		read_empty = (fifo_model.size() == 0);

		$display("<------------------------------------------------------------------------------------------>");
		$display("\n READ_MON: %0t | RST=%b | EN=%b | READ_DATA=%0d | EMPTY=%b",
			$time, read_seq.read_rst, read_seq.read_en, read_seq.read_data, read_empty);

		if (!read_seq.read_rst) begin
		//	fifo_model.delete();
			$display("<============================ READ PASS ===========================>");
			READ_PASS++;
			$display("<------------------------------------------------------------------------------------------>\n");
		end
	
		else if (read_seq.read_en) begin

			// Skip the first read transaction
			if (first_read) begin
				`uvm_info("SCOREBOARD","Skipping first read transaction to align latency",UVM_LOW);
				first_read = 0; // Disable skipping 
			end
			else begin
				// Proceed with normal comparison after skipping first read

				logic [`DATA_WIDTH-1:0] expected_data;
				if (fifo_model.size() > 0)
					expected_data = fifo_model.pop_front();
				else
					expected_data = 'hx;

				if (read_empty) begin
					if (read_seq.read_empty) begin
						READ_PASS++;
					end
					
					else begin
						READ_FAIL++;
						`uvm_error("SCOREBOARD", $sformatf("monitor_read : EMPTY = %B", read_seq.read_empty));
						$display("<============================ READ FAIL: EMPTY mismatch ===========================>");
					end
				end
				else begin
					
					if (read_seq.read_data == expected_data) begin
						$display("<============================ READ PASS ===========================>");
						READ_PASS++;
						`uvm_info("SCOREBOARD", $sformatf("READ PASS: Expected=%0d | Received=%0d",
							expected_data, read_seq.read_data), UVM_LOW)
						$display("<----------------------------------------------------------------------------------------->\n");
					end
					
					else begin
						$display("<============================ READ FAIL ===========================>");
						READ_FAIL++;
						`uvm_error("SCOREBOARD", $sformatf("READ FAIL: Expected=%0d | Received=%0d",
							expected_data, read_seq.read_data))
						$display("<-------------------------------------------------------------------------------------->\n");
					end
				
				end
			end
		end
	endtask

	//------------------------------------------------------//
	//      Comparison report summary after simulation      //
	//------------------------------------------------------//

	function void comparision_report();
		$display("\n--- SCOREBOARD STATUS ---");
		$display("WRITE_PASS=%0d | WRITE_FAIL=%0d | READ_PASS=%0d | READ_FAIL=%0d | FIFO_SIZE=%0d\n",
			WRITE_PASS, WRITE_FAIL, READ_PASS, READ_FAIL, fifo_model.size());
	endfunction

	//------------------------------------------------------//
	//           Final summary in report_phase              //
	//------------------------------------------------------//
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		$display("\n========= FINAL SCOREBOARD REPORT =========");
		$display("\nWRITE_PASS=%0d | WRITE_FAIL=%0d | READ_PASS=%0d | READ_FAIL=%0d", 
			WRITE_PASS, WRITE_FAIL, READ_PASS, READ_FAIL);
		$display("==========================================\n");
	endfunction

endclass

