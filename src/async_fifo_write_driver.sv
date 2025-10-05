class async_fifo_write_driver extends uvm_driver#(async_fifo_write_sequence_item);

	`uvm_component_utils(async_fifo_write_driver)
	virtual async_fifo_interface vif;
	async_fifo_write_sequence_item req;

	function new(string name = "async_fifo_write_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual async_fifo_interface)::get(this,"","vif",vif))
			`uvm_fatal("NO_VIF",{"virtual interface must be set for: ASYNC_FIFO_WRITE_DRIVER ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.async_fifo_write_driver_cb);
		forever begin
			seq_item_port.get_next_item(req);
			write_drive();
			seq_item_port.item_done();
		end
	endtask

	task write_drive();
		// write driver logic
		vif.async_fifo_write_driver_cb.write_rst  <= req.write_rst;
		vif.async_fifo_write_driver_cb.write_en   <= req.write_en;
		vif.async_fifo_write_driver_cb.write_data <= req.write_data;
		@(vif.async_fifo_write_driver_cb);
	endtask

endclass
