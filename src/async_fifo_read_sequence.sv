class async_fifo_read_sequence extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(async_fifo_read_sequence)

	function new(string name = "aync_fifo_read_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(`N) begin
			req = async_fifo_read_sequence_item::type_id::create("read_seq");
			wait_for_grant();
			void'(req.randomize());
			send_request(req);
			wait_for_item_done();
		end
	endtask

endclass

//testcases ->
class read_sequence1 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence1)

	function new(string name = "read_sequence1");
		super.new(name);
	endfunction

	task body();
		$display("<----------------------------- read_reset_seq1 started ---------------------------------->\n");
		repeat(`N) begin
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0; })
		end
		$display("<-----------------------------  read_reset_seq1 ended  ---------------------------------->\n");
	endtask

endclass

class read_sequence2 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence2)

	function new(string name = "read_sequence2");
		super.new(name);
	endfunction

	task body();
		$display("<----------------------------- read_reset_seq2 when rd_en = 1 started ----------------------->\n");
		repeat(`N) begin
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 1; })
		end
	  $display("<-----------------------------  read_reset_seq2 when rd_en = 1 ended  ----------------------->\n");
	endtask

endclass

class read_sequence3 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence3)

	function new(string name = "read_sequence3");
		super.new(name);
	endfunction

	task body();
		$display("<----------------------------- read_latch_seq3 started ----------------------->\n");	
		repeat(`N) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
 	  $display("<-----------------------------  read_latch_seq3 ended  ----------------------->\n");
	endtask

endclass


class read_sequence4 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence4)

	function new(string name = "read_sequence4");
		super.new(name);
	endfunction

	task body();
	  $display("<----------------------------- read_normal_op_seq4 started ----------------------->\n");
		repeat(`N) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
    $display("<-----------------------------  read_normal_op_seq4 ended  ----------------------->\n");
	endtask

endclass


//regression test ->

/*
class async_fifo_read_regression extends uvm_sequence#(async_fifo_read_sequence_item);
	`uvm_object_utils(async_fifo_read_regression)

	read_rst_sequence rd_rst;
	//async_fifo_read_sequence read_seq;
  read_sequence rd_seq;

	function new(string name = "async_fifo_read_regression");
		super.new(name);
	endfunction

	task body();
		`uvm_do(rd_rst);
	 //`uvm_do(read_seq);
		`uvm_do(rd_seq);
	endtask
endclass
*/

