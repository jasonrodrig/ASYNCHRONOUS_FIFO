class async_fifo_test extends uvm_test;
	  
	  `uvm_component_utils(async_fifo_test)
	  
	  async_fifo_environment env;
	  async_fifo_virtual_sequence v_seq;
	  
	  function new(string name = "async_fifo_test", uvm_component parent);
	    super.new(name,parent);
	  endfunction 
	  
	  virtual function void build_phase(uvm_phase phase);
	    super.build_phase(phase);
	    env = async_fifo_environment::type_id::create("env",this);
	    v_seq = async_fifo_virtual_sequence::type_id::create("v_seq");
	  endfunction
	  
	  virtual task run_phase(uvm_phase phase);
	    //super.run_phase(phase);
	    phase.raise_objection(this);
	    v_seq.start(env.v_seqr);
	    phase.drop_objection(this);
	  endtask
endclass

/*class async_fifo_write_test extends uvm_test;

	`uvm_component_utils(async_fifo_write_test)
	async_fifo_environment env;
	async_fifo_write_sequence wr_seq;

	function new(string name = "async_fifo_write_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env    = async_fifo_environment::type_id::create( "env" , this );
		wr_seq = async_fifo_write_sequence::type_id::create("wr_seq");
	endfunction

	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			wr_seq.start(env.wr_agt.write_seqr);
		phase.drop_objection(this);
	endtask

endclass

class async_fifo_read_test extends uvm_test;

	`uvm_component_utils(async_fifo_read_test)
	async_fifo_environment env;
	async_fifo_read_sequence rd_seq;

	function new(string name = "async_fifo_read_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env    = async_fifo_environment::type_id::create( "env" , this );
		rd_seq = async_fifo_read_sequence::type_id::create("rd_seq");
	endfunction

	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			  rd_seq.start(env.rd_agt.read_seqr);
		phase.drop_objection(this);
	endtask

endclass

class write_rst_seq_test extends async_fifo_write_test;

	`uvm_component_utils(write_rst_seq_test)
	async_fifo_environment env;
	write_rst_sequence wr_seq;

	function new(string name = "write_rst_seq_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env    = async_fifo_environment::type_id::create( "env" , this );
		wr_seq = write_rst_sequence::type_id::create("wr_rst_seq");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		wr_seq.start(env.wr_agt.write_seqr);
		phase.drop_objection(this);
	endtask

endclass

class read_rst_seq_test extends async_fifo_read_test;

	`uvm_component_utils(read_rst_seq_test)
	async_fifo_environment env;
	read_rst_sequence rd_seq;

	function new(string name = "read_rst_seq_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env    = async_fifo_environment::type_id::create( "env" , this );
		rd_seq = read_rst_sequence::type_id::create("rd_rst_seq");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		rd_seq.start(env.rd_agt.read_seqr);
		phase.drop_objection(this);
	endtask

endclass

class async_fifo_write_regression_test extends async_fifo_write_test;

	`uvm_component_utils(async_fifo_write_regression_test)
	async_fifo_write_regression write_reg_test;

	function new(string name = "async_fifo_write_regression_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		write_reg_test = async_fifo_write_regression::type_id::create("write_reg_test");
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		write_reg_test.start(env.wr_agt.write_seqr);
		phase.drop_objection(this);
	endtask

endclass

class async_fifo_read_regression_test extends async_fifo_read_test;

	`uvm_component_utils(async_fifo_read_regression_test)
	async_fifo_read_regression read_reg_test;

	function new(string name = "async_fifo_read_regression_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		read_reg_test = async_fifo_read_regression::type_id::create("read_reg_test");
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		read_reg_test.start(env.rd_agt.read_seqr);
		phase.drop_objection(this);
	endtask
endclass
*/




