class async_fifo_read_agent extends uvm_agent;

	`uvm_component_utils(async_fifo_read_agent)
	async_fifo_read_sequencer read_seqr;
	async_fifo_read_driver read_driv;
	async_fifo_read_monitor read_mon;

	function new(string name = "async_fifo_read_agent",uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(UVM_ACTIVE == get_is_active()) begin
			read_seqr = async_fifo_read_sequencer::type_id::create("read_seqr",this);
			read_driv = async_fifo_read_driver::type_id::create("read_driv",this);
		end
		read_mon  = async_fifo_read_monitor::type_id::create("read_mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(UVM_ACTIVE == get_is_active())
			read_driv.seq_item_port.connect(read_seqr.seq_item_export);
	endfunction

endclass
