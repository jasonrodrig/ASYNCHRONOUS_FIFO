class async_fifo_write_sequence_item extends uvm_sequence_item;

	rand logic write_rst;
	rand logic write_en;
	rand logic [ `DATA_WIDTH - 1 : 0 ] write_data;
	     logic write_full;

	`uvm_object_utils_begin(async_fifo_write_sequence_item)
	`uvm_field_int(write_rst   , UVM_ALL_ON)
	`uvm_field_int(write_en     , UVM_ALL_ON)
	`uvm_field_int(write_data  , UVM_ALL_ON)
	`uvm_field_int(write_full  , UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "async_fifo_write_sequence_item");
		super.new(name);
	endfunction

endclass
