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
		phase.raise_objection(this);
		// test_case selector choice 
	//	v_seq.testcase1 = 1;	
	//	v_seq.testcase1 = 1;
	//	v_seq.testcase2 = 1;
	//	v_seq.testcase3 = 1;
	//	v_seq.testcase4 = 1;
	//	v_seq.testcase5 = 1;
	//	v_seq.testcase6 = 1;
	//	v_seq.testcase7 = 1;
	//	v_seq.testcase8 = 1;
	//	v_seq.testcase9 = 1;
		v_seq.run_all_test = 1 ;
		v_seq.start(env.v_seqr);
		phase.drop_objection(this);
	endtask
endclass


