/*
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


	function void end_of_elaboration();
			//    super.end_of_elaboration();
	    		uvm_top.print_topology();
	endfunction
	
  task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			// test_case selector choice 
	//  v_seq.testcase1 = 1;   // reset test when en=0	
	//	v_seq.testcase2 = 1;   // reset test when en=1
  //	v_seq.testcase3 = 1;   // latch test 
	//  v_seq.testcase4 = 1;   // full write operation
  // 	v_seq.testcase5 = 1;   // full read operation
	//  v_seq.testcase6 = 1;   // write_read_operation
  // 	v_seq.testcase7 = 1;   // mid reset writeoperation
  //	v_seq.testcase8 = 1;   // mid reset read operation
	// 	v_seq.testcase9 = 1;   // wrap around test
    v_seq.run_all_test = 1 ; // run all testcases
  //  v_seq.p_sequencer = env.v_seqr;
	  	v_seq.start(env.v_seqr);
	  	phase.drop_objection(this);
	endtask
endclass

*/

class async_fifo_test extends uvm_test;
  `uvm_component_utils(async_fifo_test)

  async_fifo_environment        env;
  async_fifo_virtual_sequence  v_seq;

  function new(string name = "async_fifo_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env  = async_fifo_environment::type_id::create("env", this);
    v_seq = async_fifo_virtual_sequence::type_id::create("v_seq");
  endfunction

  function void end_of_elaboration();
    super.end_of_elaboration();
    uvm_top.print_topology();
  endfunction


  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

endclass


class async_fifo_test1 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test1)
  function new(string name = "async_fifo_test1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
    if (v_seq == null) begin
      `uvm_fatal("TEST1", "v_seq is null — build_phase likely failed")
    end
     v_seq.p_sequencer = env.v_seqr;
     v_seq.run_testcase1();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test2 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test2)

  function new(string name = "async_fifo_test2", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST2", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase2();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test3 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test3)

  function new(string name = "async_fifo_test3", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST3", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase3();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test4 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test4)

  function new(string name = "async_fifo_test4", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST4", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase4();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test5 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test5)

  function new(string name = "async_fifo_test5", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST5", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase5();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test6 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test6)

  function new(string name = "async_fifo_test6", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST6", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase6();
    phase.drop_objection(this);
  endtask
endclass
/*
class async_fifo_test7 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test7)

  function new(string name = "async_fifo_test7", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST7", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase7();
    phase.drop_objection(this);
  endtask
endclass

class async_fifo_test8 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test8)

  function new(string name = "async_fifo_test8", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST8", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase8();
    phase.drop_objection(this);
  endtask
endclass
*/
class async_fifo_test7 extends async_fifo_test;
  `uvm_component_utils(async_fifo_test7)

  function new(string name = "async_fifo_test7", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if (v_seq == null) `uvm_fatal("TEST7", "v_seq is null — build_phase failed")
    v_seq.p_sequencer = env.v_seqr;
    v_seq.run_testcase7();
    phase.drop_objection(this);
  endtask
endclass


