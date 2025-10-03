class async_fifo_test extends uvm_test;

	`uvm_component_utils(async_fifo_test)
	async_fifo_environment env;
	async_fifo_write_sequence wr_seq;
	async_fifo_read_sequence rd_seq;

	function new(string name = "async_fifo_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env    = async_fifo_environment::type_id::create( "env" , this );
		wr_seq = async_fifo_write_sequence::type_id::create("wr_seq");
		rd_seq = async_fifo_read_sequence::type_id::create("rd_seq");
	endfunction

	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		fork
			wr_seq.start(env.wr_agt.write_seqr);
			rd_seq.start(env.rd_agt.read_seqr);
		join
		phase.drop_objection(this);
	endtask

endclass
