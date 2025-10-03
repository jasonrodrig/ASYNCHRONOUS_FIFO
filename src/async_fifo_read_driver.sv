class async_fifo_read_driver extends uvm_driver#(async_fifo_read_sequence_item);
	
	`uvm_component_utils(async_fifo_read_driver)
	virtual async_fifo_interface vif;
	async_fifo_read_sequence_item req;

	function new(string name = "async_fifo_read_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual async_fifo_interface)::get(this,"","vif",vif))
			`uvm_fatal("NO_VIF",{"virtual interface must be set for: ASYNC_FIFO_READ_DRIVER ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			read_drive();
			seq_item_port.item_done();
		end
	endtask

	task read_drive();
		// read driver logic

		vif.async_fifo_read_driver_cb.read_rst  <= req.read_rst;
		vif.async_fifo_read_driver_cb.read_en   <= req.read_en;
		@(vif.async_fifo_read_driver_cb);

	endtask

endclass



