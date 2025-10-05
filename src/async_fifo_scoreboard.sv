`uvm_analysis_imp_decl(_write_mon_scb)
`uvm_analysis_imp_decl(_read_mon_scb)

class async_fifo_scoreboard extends uvm_scoreboard;
	// handle decleration for async_fifo_write_sequnce item and async_fifo_read_sequnce item using queues
	async_fifo_write_sequence_item write_mon_queue[$];
	async_fifo_read_sequence_item read_mon_queue[$];

	// write/read monitor and write/read reference results declaration for comparsion only
	logic [(`DATA_WIDTH - 1 ) + 3:0] monitor_write_results;
	logic [(`DATA_WIDTH - 1 ) + 3:0] reference_write_results;
	logic [(`DATA_WIDTH - 1 ) + 3:0] monitor_read_results;
	logic [(`DATA_WIDTH - 1 ) + 3:0] reference_read_results;

	// mimicing the memory funactionlaity using register 	
	reg [ `DATA_WIDTH - 1 : 0 ] fifo [ `FIFO_DEPTH - 1 : 0 ];
	reg [ ADDR_WIDTH  : 0 ] write_ptr = 'b0;
	reg [ ADDR_WIDTH  : 0 ] read_ptr = 'b0;

	// declration for temporary reference outputs
	logic [ `DATA_WIDTH - 1 : 0 ] ref_read_data ;
	logic  ref_write_full , ref_read_empty ;

	// declaration for PASS and FAIL count in each testcases
	int WRITE_PASS = 0;
	int WRITE_FAIL = 0;
	int READ_PASS = 0;
	int READ_FAIL = 0;

	bit read_flag = 0;
	bit write_flag = 0;

	// registering the alu_scoareboard to the factory	
	`uvm_component_utils(async_fifo_scoreboard)

	// analysis import declaration for both write_monitor and read_monitor	
	uvm_analysis_imp_write_mon_scb#(async_fifo_write_sequence_item, async_fifo_scoreboard) write_scb_port;
	uvm_analysis_imp_read_mon_scb#(async_fifo_read_sequence_item, async_fifo_scoreboard) read_scb_port;

	//------------------------------------------------------//
	//     Creating New constructor for alu_scoreboard      //   
	//------------------------------------------------------//

	function new(string name = "async_fifo_scoreboard", uvm_component parent);
		super.new(name, parent);
		write_scb_port  = new("write_scb_port" , this);
		read_scb_port   = new("read_scb_port", this); 
	endfunction

	//------------------------------------------------------//
	//      Captures the read monitor transaction and       //
	// temporary storing the signals in the read_mon queue  //   
	//------------------------------------------------------//

	function void write_read_mon_scb(async_fifo_read_sequence_item rd_seq);
		read_mon_queue.push_back(rd_seq);
	endfunction

	//------------------------------------------------------//
	//      Captures the write monitor transaction and      //
	// temporary storing the signals in the write_mon queue //   
	//------------------------------------------------------//

	function void write_write_mon_scb(async_fifo_write_sequence_item wr_seq);
		write_mon_queue.push_back(wr_seq);
	endfunction

	//---------------------------------------------------------//
	// Displaying success and failure using reporting function //   
	//---------------------------------------------------------//

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		$display("\n WRITE_Passes = %0d | WRITE_Fails = %0d | READ_Passes = %0d | READ_Fails = %0d\n", 
			WRITE_PASS, WRITE_FAIL, READ_PASS , READ_FAIL);
	endfunction

	//--------------------------------------------------------------//
	// Running the async_fifo_reference model and comparison report //
	//--------------------------------------------------------------//

	task run_phase(uvm_phase phase);
		forever begin
			fork
				begin
					// waiting when the read_mon_queue has the transaction stored in the
					// queue and perform the extraction of signals from the read monitor
					wait(read_mon_queue.size() > 0);
					extract_signals_from_read_monitor();
				end
				begin
					// waiting when the write_mon_queue has the transaction stored in the
					// queue and perform the extraction of signals from the write monitor 
					wait(write_mon_queue.size() > 0);
					extract_signals_from_write_monitor();
				end
			join_any
			// generate the comparsion report by comparing reference results 
			// and monitor results and displaying the test pass or fail
			comparision_report();
		end
	endtask

	//------------------------------------------------------//
	//           performs extraction of all signals         //
	//               from the read monitor                  //
	//------------------------------------------------------//

	task extract_signals_from_read_monitor();

		async_fifo_read_sequence_item read_seq;
		read_seq = read_mon_queue.pop_front();

		$display(" Monitor READ : @ %0t \n READ_RST = %b | READ_EN = %b | READ_DATA = %d | READ_EMPTY = %b | ",
			$time, read_seq.read_rst , read_seq.read_en , read_seq.read_data , read_seq.read_empty );
		monitor_read_results = { read_seq.read_rst , read_seq.read_en , read_seq.read_data , read_seq.read_empty };
		$display(" time : %t | monitor_read_results_stored = %b", $time, monitor_read_results); 

		async_fifo_read_reference_model(read_seq);

	endtask

	//------------------------------------------------------//
	//           performs extraction of all signals         //
	//               from the write monitor                 //
	//------------------------------------------------------//

	task extract_signals_from_write_monitor();

		async_fifo_write_sequence_item write_seq;
		write_seq = write_mon_queue.pop_front();

		$display(" Monitor WRITE : @ %0t \n WRITE_RST = %b | WRITE_EN = %b | WRITE_DATA = %d | WRITE_FULL = %b | ",
			$time, write_seq.write_rst , write_seq.write_en , write_seq.write_data , write_seq.write_full );
		monitor_write_results = { write_seq.write_rst , write_seq.write_en , write_seq.write_data , write_seq.write_full };
		$display(" time : %t | monitor_write_results_stored = %b", $time, monitor_write_results); 

		async_fifo_write_reference_model(write_seq);

	endtask

	//------------------------------------------------------//
	//   performs the async_fifo_write_reference model by   //
	//             mimicing its functionlaity               //
	//------------------------------------------------------//

	task async_fifo_write_reference_model(input async_fifo_write_sequence_item write_seq);
		// reset condition
		//
		if(write_seq.write_rst == 0 && write_seq.write_en == 0)begin
			write_ptr = 'b0;
			ref_write_full = 'b0;
			write_flag = 1;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);
		end

		// write enable condition
		else if(write_seq.write_en == 1 && write_seq.write_rst == 1 )begin
			write_flag = 1;
			ref_write_full = 'bx;
			fifo[ write_ptr[ ADDR_WIDTH - 1 : 0 ] ] = write_seq.write_data; 
			write_ptr = write_ptr + 1 ;
			if(write_ptr > 16) write_ptr = 1;
			ref_write_full = ( ( ~write_ptr[4] == read_ptr[4] ) && ( write_ptr[3:0] == read_ptr[3:0] ) ) ? 1 : 0 ;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);
		end

		else begin
			write_flag = 1;
			ref_write_full = 'bx;
			write_ptr = write_ptr;	
			if(write_ptr > 16) write_ptr = 1;
			ref_write_full = ( ( ~write_ptr[4] == read_ptr[4] ) && ( write_ptr[3:0] == read_ptr[3:0] ) ) ? 1 : 0 ;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);	
		end

		$display(" Reference WRITE : @ %0t \n WRITE_RST = %b | WRITE_EN = %b | WRITE_DATA = %d | WRITE_FULL = %b |",
			$time, write_seq.write_rst , write_seq.write_en , write_seq.write_data , ref_write_full );
		reference_write_results = { write_seq.write_rst , write_seq.write_en , write_seq.write_data , ref_write_full };
		$display(" time : %t | reference_write_results_stored = %b", $time, reference_write_results); 

	endtask

	//------------------------------------------------------//
	//   performs the async_fifo_read_reference model by    //
	//             mimicing its functionlaity               //
	//------------------------------------------------------//

	task async_fifo_read_reference_model(input async_fifo_read_sequence_item read_seq);
		// reset condition
		if(read_seq.read_rst == 0 && read_seq.read_en == 0 )begin
			read_flag = 1;
			read_ptr = 'b0;
			ref_read_data = 'b0;
			ref_read_empty = 'b1;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);
		end

		// read enable condition
		else if(read_seq.read_en ==1 && read_seq.read_rst == 1 )begin
			read_flag = 1;
			ref_read_empty = 'bx;
			ref_read_data  = 'bx;
			ref_read_data = fifo[ read_ptr[ ADDR_WIDTH - 1 : 0 ] ]; 
			read_ptr = read_ptr + 1 ;
			if(read_ptr > 16 ) read_ptr = 1;	
			ref_read_empty = ( read_ptr[3:0] == write_ptr[3:0] ) ? 1 : 0 ;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);
		end

		else begin
			read_flag = 1;
			ref_read_empty = 'bx;
			ref_read_data  = 'bx;
			ref_read_data  =  fifo[ read_ptr[ ADDR_WIDTH - 1 : 0 ] ];
			read_ptr = read_ptr ;
			if(read_ptr > 16 ) read_ptr = 1; 
			ref_read_empty = ( read_ptr[3:0] == write_ptr[3:0] ) ? 1 : 0 ;
			$display(" REF : wptr = %b , rptr = %b", write_ptr,read_ptr);	
		end

		$display(" Reference READ : @ %0t \n READ_RST = %b | READ_EN = %b | READ_DATA = %d | READ_EMPTY = %b |",
			$time, read_seq.read_rst , read_seq.read_en , read_seq.read_data , ref_read_empty );
		reference_read_results = { read_seq.read_rst , read_seq.read_en , read_seq.read_data , ref_read_empty };
		$display(" time : %t | reference_read_results_stored = %b", $time, reference_read_results); 

	endtask

	//------------------------------------------------------//
	// performs the comparsion report by checking bit by    //
	// bit between the reference result and monitor results //   
	//------------------------------------------------------//

	task comparision_report();

		if(write_flag == 1) begin
			if( monitor_write_results === reference_write_results ) begin
				$display("<----------------------------- WRITE PASS ----------------------------->" );
				WRITE_PASS++;
				write_flag = 0;
			end
			else begin
				$display("<----------------------------- WRITE FAIL ----------------------------->" );
				WRITE_FAIL++;
				write_flag = 0;
			end
		end

		if(read_flag == 1)begin
			if( monitor_read_results === reference_read_results )begin
				$display("<----------------------------- READ PASS ----------------------------->" );
				READ_PASS++;
				read_flag = 0;
			end

			else begin
				$display("<----------------------------- READ FAIL ----------------------------->" );
				READ_FAIL++;
				read_flag = 0;
			end
		end
	endtask

endclass
