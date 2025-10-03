class async_fifo_read_monitor extends uvm_monitor;

	`uvm_component_utils(async_fifo_read_monitor)
	virtual async_fifo_interface vif;
	async_fifo_read_sequence_item read_seq;
	uvm_analysis_port#(async_fifo_read_sequence_item) read_mon_port;

	function new(string name = "async_fifo_read_monitor",uvm_component parent);
		super.new(name,parent);
		read_mon_port = new("read_mon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		read_seq = async_fifo_read_sequence_item::type_id::create("read_seq");
		if(!uvm_config_db#(virtual async_fifo_interface)::get(this,"","vif",vif))
		`uvm_fatal("NO_VIF",{"virtual interface must be set for: ASYNC_FIFO_READ_MONITOR ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
	@(vif.async_fifo_read_monitor_cb);
	forever begin
			read_monitor();
		end
	endtask

	task read_monitor();
		// read monitor logic
		@(vif.async_fifo_read_monitor_cb);
     read_seq.read_rst   = vif.async_fifo_read_monitor_cb.read_rst;
     read_seq.read_en    = vif.async_fifo_read_monitor_cb.read_en;
     read_seq.read_data  = vif.async_fifo_read_monitor_cb.read_data;
     read_seq.read_empty = vif.async_fifo_read_monitor_cb.read_empty;
     read_mon_port.write(read_seq);
	endtask

endclass
