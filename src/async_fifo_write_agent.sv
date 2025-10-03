class async_fifo_write_agent extends uvm_agent;

	`uvm_component_utils(async_fifo_write_agent)
	async_fifo_write_sequencer write_seqr;
	async_fifo_write_driver write_driv;
	async_fifo_write_monitor write_mon;

	function new(string name = "async_fifo_write_agent",uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(UVM_ACTIVE == get_is_active()) begin
			write_seqr = async_fifo_write_sequencer::type_id::create("write_seqr",this);
			write_driv = async_fifo_write_driver::type_id::create("write_driv",this);
		end
		write_mon  = async_fifo_write_monitor::type_id::create("write_mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(UVM_ACTIVE == get_is_active())  
			write_driv.seq_item_port.connect(write_seqr.seq_item_export);
	endfunction

endclass
