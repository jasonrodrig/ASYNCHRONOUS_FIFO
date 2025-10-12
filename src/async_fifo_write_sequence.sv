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
		repeat(1)begin	 
//		$display("<----------------------------- write_reset_seq1 started ---------------------------------->\n");
		  `uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0; req.write_data inside {[0:255]}; })
//		$display("<-----------------------------  write_reset_seq1 ended  ---------------------------------->\n");
	  end
	endtask

endclass

class write_sequence2 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence2)

	function new(string name = "write_sequence2");
		super.new(name);
	endfunction

	task body();
//	$display("<----------------------------- write_reset_seq2 when wr_en = 1 started ----------------------->\n");
		repeat(1) begin
			`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
//	$display("<-----------------------------  write_reset_seq2 when wr_en = 1 ended  ----------------------->");
	endtask

endclass

class write_sequence3 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence3)

	function new(string name = "write_sequence3");
		super.new(name);
	endfunction

	task body();
	//	$display("<----------------------------- write_latch_seq3 started ----------------------->\n");
		repeat(1) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		end
  //	$display("<-----------------------------  write_latch_seq3 ended  ----------------------->");
	endtask

endclass

class write_sequence4 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence4)

	function new(string name = "write_sequence4");
		super.new(name);
	endfunction

	task body();
	//	$display("<----------------------------- write_seq4 started ----------------------->\n");
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
  //	$display("<-----------------------------  write_seq4 ended  ----------------------->");
	endtask

endclass

class write_sequence5 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence5)

	function new(string name = "write_sequence5");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- write_seq5 started ----------------------->\n");
		repeat(`N)begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
    end
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		end
	 // $display("<-----------------------------  write_seq5 ended  ----------------------->");
	endtask

endclass

class write_sequence6 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence6)

	function new(string name = "write_sequence6");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- write_seq6 started ----------------------->\n");
		//`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
	 // $display("<-----------------------------  write_seq6 ended  ----------------------->");
	endtask

endclass
/*
class write_sequence7 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence7)

	function new(string name = "write_sequence7");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- write_seq7 started ----------------------->\n");
		`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0; req.write_data inside {[0:255]}; })
		repeat( `N - 12 ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
		`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
	 // $display("<-----------------------------  write_seq7 ended  ----------------------->");
	endtask

endclass

class write_sequence8 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence8)

	function new(string name = "write_sequence8");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- write_seq8 started ----------------------->\n");
		repeat( 8  ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
		// `uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		 repeat( 12 ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		 end
	 // $display("<-----------------------------  write_seq8 ended  ----------------------->");
	endtask

endclass
*/
class write_sequence7 extends uvm_sequence#(async_fifo_write_sequence_item);

	`uvm_object_utils(write_sequence7)

	function new(string name = "write_sequence7");
		super.new(name);
	endfunction

	task body();
	  //$display("<----------------------------- write_seq9 started ----------------------->\n");
		`uvm_do_with(req,{ req.write_rst == 0 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		repeat( `N - 8 ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
		
		repeat( `N - 8 ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		end
  	
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 1 ; req.write_data inside {[0:255]}; })
		end
		
		repeat( `N ) begin
			`uvm_do_with(req,{ req.write_rst == 1 ; req.write_en == 0 ; req.write_data inside {[0:255]}; })
		end

	 // $display("<-----------------------------  write_seq9 ended  ----------------------->");
	endtask

endclass


//regression test ->

class async_fifo_write_regression extends uvm_sequence#(async_fifo_write_sequence_item);
	`uvm_object_utils(async_fifo_write_regression)

	write_sequence1 wr_seq1;
	write_sequence2 wr_seq2;
	write_sequence3 wr_seq3;
	write_sequence4 wr_seq4;
	write_sequence5 wr_seq5;
	write_sequence6 wr_seq6;
	write_sequence7 wr_seq7;

	function new(string name = "async_fifo_write_regression");
		super.new(name);
	endfunction

	task body();
		`uvm_do(wr_seq1);
		`uvm_do(wr_seq2);
		`uvm_do(wr_seq3);
   	`uvm_do(wr_seq4);
		`uvm_do(wr_seq5);
		`uvm_do(wr_seq6);
    `uvm_do(wr_seq7);
	endtask
endclass


