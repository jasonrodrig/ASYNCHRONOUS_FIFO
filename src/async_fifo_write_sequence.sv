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

//regression test ->
