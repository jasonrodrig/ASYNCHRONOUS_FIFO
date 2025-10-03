class async_fifo_write_sequence extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(async_fifo_write_sequence)

	function new(string name = "aync_fifo_write_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(`N) begin
			req = async_fifo_write_sequence_item::type_id::create("write_seq");
			wait_for_grant();
			void'(req.randomize());
			send_request(req);
			wait_for_item_done();
		end
	endtask

endclass

//testcases -> 
class write_sequence1 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence1)

	function new(string name = "write_sequence1");
		super.new(name);
	endfunction

	task body();
		$display("<----------------------------- write_reset_seq1 started ---------------------------------->\n");
		repeat(`N)begin	 
		  `uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0; req.write_data inside {[0:255]}; })
		end
		$display("<-----------------------------  write_reset_seq1 ended  ---------------------------------->\n");
	endtask

endclass

class write_sequence2 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence2)

	function new(string name = "write_sequence2");
		super.new(name);
	endfunction

	task body();
	$display("<----------------------------- write_reset_seq2 when wr_en = 1 started ----------------------->\n");
		repeat(`N) begin
			`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
	$display("<-----------------------------  write_reset_seq2 when wr_en = 1 ended  ----------------------->\n");
	endtask

endclass

class write_sequence3 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence3)

	function new(string name = "write_sequence3");
		super.new(name);
	endfunction

	task body();
		$display("<----------------------------- write_latch_seq3 started ----------------------->\n");
		repeat(`N) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		end
  	$display("<-----------------------------  write_latch_seq3 ended  ----------------------->\n");
	endtask

endclass

class write_sequence4 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence4)

	function new(string name = "write_sequence4");
		super.new(name);
	endfunction

	task body();
	  $display("<----------------------------- write_normal_op_seq4 started ----------------------->\n");
		repeat(`N) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
	  $display("<-----------------------------  write_normal_op_seq4 ended  ----------------------->\n");
	endtask

endclass


//regression test ->
/*
class async_fifo_write_regression extends uvm_sequence#(async_fifo_write_sequence_item);
	`uvm_object_utils(async_fifo_write_regression)

	write_rst_sequence wr_rst;
	write_sequence wr_seq;
	//async_fifo_write_sequence write_seq;

	function new(string name = "async_fifo_write_regression");
		super.new(name);
	endfunction

	task body();
		`uvm_do(wr_rst);
		//`uvm_do(write_seq);
		`uvm_do(wr_seq);
	endtask
endclass

*/
