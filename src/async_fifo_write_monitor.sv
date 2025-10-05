class async_fifo_write_monitor extends uvm_monitor;

	`uvm_component_utils(async_fifo_write_monitor)
	virtual async_fifo_interface vif;
	async_fifo_write_sequence_item write_seq;
	uvm_analysis_port#(async_fifo_write_sequence_item) write_mon_port;	

	function new(string name = "async_fifo_write_monitor",uvm_component parent);
		super.new(name,parent);
		write_mon_port = new("write_mon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		write_seq = async_fifo_write_sequence_item::type_id::create("write_seq");
		if(!uvm_config_db#(virtual async_fifo_interface)::get(this,"","vif",vif))
		`uvm_fatal("NO_VIF",{"virtual interface must be set for: ASYNC_FIFO_WRITE_MONITOR ",get_full_name(),".vif"});
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.async_fifo_write_monitor_cb);
		forever begin
			write_monitor();
		end
	endtask

	task write_monitor();
		// write monitor logic
		@(vif.async_fifo_write_monitor_cb);
		write_seq.write_rst  = vif.async_fifo_write_monitor_cb.write_rst;
		write_seq.write_en   = vif.async_fifo_write_monitor_cb.write_en;
   	write_seq.write_data = vif.async_fifo_write_monitor_cb.write_data;
		write_seq.write_full = vif.async_fifo_write_monitor_cb.write_full;
		//$display(" WRITE MONITOR WRITE_RST = %B ,WRITE_EN =%B ,WRITE_DATA = %D ,WRITE_FULL = %B",vif.write_rst,vif.write_en,vif.write_data,vif.write_full);
		write_mon_port.write(write_seq);
	endtask

endclass
