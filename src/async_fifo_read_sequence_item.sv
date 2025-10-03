class async_fifo_read_sequence_item extends uvm_sequence_item;

	rand logic read_rst;
	rand logic read_en;
	logic [ `DATA_WIDTH - 1 : 0 ] read_data;
	logic read_empty;

	`uvm_object_utils_begin(async_fifo_read_sequence_item)
	`uvm_field_int(read_rst   , UVM_ALL_ON)
	`uvm_field_int(read_en    , UVM_ALL_ON)
	`uvm_field_int(read_data  , UVM_ALL_ON)
	`uvm_field_int(read_empty , UVM_ALL_ON)
	`uvm_object_utils_end	

	function new(string name = "async_fifo_read_sequence_item");
		super.new(name);
	endfunction

endclass
