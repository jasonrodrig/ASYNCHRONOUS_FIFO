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
		repeat(1)begin	 
//		$display("<----------------------------- read_reset_seq1 started ---------------------------------->\n");
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0; })
//		$display("<-----------------------------  read_reset_seq1 ended  ---------------------------------->\n");
	  end
	endtask

endclass

class read_sequence2 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence2)

	function new(string name = "read_sequence2");
		super.new(name);
	endfunction

	task body();
	//	$display("<----------------------------- read_reset_seq2 when rd_en = 1 started ----------------------->\n");
		repeat(1) begin
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 1; })
		end
	//  $display("<-----------------------------  read_reset_seq2 when rd_en = 1 ended  ----------------------->");
	endtask

endclass

class read_sequence3 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence3)

	function new(string name = "read_sequence3");
		super.new(name);
	endfunction

	task body();
		//$display("<----------------------------- read_latch_seq3 started ----------------------->\n");	
		repeat(1) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
 	  //$display("<-----------------------------  read_latch_seq3 ended  ----------------------->");
	endtask

endclass


class read_sequence4 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence4)

	function new(string name = "read_sequence4");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq4 started ----------------------->\n");
		repeat( `N ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
   // $display("<-----------------------------  read_seq4 ended  ----------------------->");
	endtask

endclass

class read_sequence5 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence5)

	function new(string name = "read_sequence5");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq5 started ----------------------->\n");
	  repeat( `N ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
		repeat( `N + 1 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
   // $display("<-----------------------------  read_seq5 ended  ----------------------->");
	
	endtask

endclass

class read_sequence6 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence6)

	function new(string name = "read_sequence6");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq6 started ----------------------->\n");
	  //`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0 ; })
		repeat( `N ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
   // $display("<-----------------------------  read_seq6 ended  ----------------------->");
	endtask

endclass
/*
class read_sequence7 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence7)

	function new(string name = "read_sequence7");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq7 started ----------------------->\n");
	`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0; })

		repeat( `N - 4 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0 ; })
		repeat( `N  ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
   // $display("<-----------------------------  read_seq7 ended  ----------------------->");
	endtask
endclass

class read_sequence8 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence8)

	function new(string name = "read_sequence8");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq8 started ----------------------->\n");
		repeat( 8 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
		repeat( 4 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
		`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0 ; })
		repeat( 8  ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
   // $display("<-----------------------------  read_seq8 ended  ----------------------->");
	endtask
endclass
*/
class read_sequence7 extends uvm_sequence#(async_fifo_read_sequence_item);

	`uvm_object_utils(read_sequence7)

	function new(string name = "read_sequence7");
		super.new(name);
	endfunction

	task body();
	 // $display("<----------------------------- read_seq9 started ----------------------->\n");
	 	`uvm_do_with(req,{ req.read_rst == 0 ; req.read_en == 0 ; })
		repeat( `N - 8 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
		
		repeat( `N - 8 ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end
  	
		repeat( `N  ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 0 ; })
		end
		
		repeat( `N  ) begin
			`uvm_do_with(req,{ req.read_rst == 1 ; req.read_en == 1 ; })
		end

	//  $display("<-----------------------------  read_seq9 ended  ----------------------->");
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

