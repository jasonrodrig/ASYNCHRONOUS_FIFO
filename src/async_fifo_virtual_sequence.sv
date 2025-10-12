/*
class async_fifo_virtual_sequence extends uvm_sequence;

	`uvm_object_utils(async_fifo_virtual_sequence)
	`uvm_declare_p_sequencer(async_fifo_virtual_sequencer)

  bit testcase1 = 0;
  bit testcase2 = 0;
  bit testcase3 = 0;
  bit testcase4 = 0;
  bit testcase5 = 0;
  bit testcase6 = 0;
  bit testcase7 = 0;
  bit testcase8 = 0;
  bit testcase9 = 0;
  bit run_all_test = 0;
 
	write_sequence1 wr_seq1;
	read_sequence1 rd_seq1;
	write_sequence2 wr_seq2;
	read_sequence2 rd_seq2;
	write_sequence3 wr_seq3;
	read_sequence3 rd_seq3;
	write_sequence4 wr_seq4;
	read_sequence4 rd_seq4;
	write_sequence5 wr_seq5;
	read_sequence5 rd_seq5;
	write_sequence6 wr_seq6;
	read_sequence6 rd_seq6;
	write_sequence7 wr_seq7;
	read_sequence7 rd_seq7;
	write_sequence8 wr_seq8;
	read_sequence8 rd_seq8;
	write_sequence9 wr_seq9;
	read_sequence9 rd_seq9;

	function new(string name = "async_fifo_virtual_sequence");
		super.new(name);
		wr_seq1 =	write_sequence1::type_id::create("wr_seq1");
		rd_seq1 =	read_sequence1::type_id::create("rd_seq1");
		wr_seq2 =	write_sequence2::type_id::create("wr_seq2");
		rd_seq2 =	read_sequence2::type_id::create("rd_seq2");
		wr_seq3 =	write_sequence3::type_id::create("wr_seq3");
		rd_seq3 =	read_sequence3::type_id::create("rd_seq3");
		wr_seq4 =	write_sequence4::type_id::create("wr_seq4");
		rd_seq4 =	read_sequence4::type_id::create("rd_seq4");
		wr_seq5 =	write_sequence5::type_id::create("wr_seq5");
		rd_seq5 =	read_sequence5::type_id::create("rd_seq5");
		wr_seq6 =	write_sequence6::type_id::create("wr_seq6");
		rd_seq6 =	read_sequence6::type_id::create("rd_seq6");
		wr_seq7 =	write_sequence7::type_id::create("wr_seq7");
		rd_seq7 =	read_sequence7::type_id::create("rd_seq7");
		wr_seq8 =	write_sequence8::type_id::create("wr_seq8");
		rd_seq8 =	read_sequence8::type_id::create("rd_seq8");
		wr_seq9 =	write_sequence9::type_id::create("wr_seq9");
		rd_seq9 =	read_sequence9::type_id::create("rd_seq9");
	endfunction 

	task body();

		//write_rst = 0 when write_en = 0 & read_rst = 0 when read_en = 0
		if( testcase1 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq1.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq1.start(p_sequencer.read_seqr);
			end
		join
    end
		//write_rst = 0 when write_en = 1 & read_rst = 0 when read_en = 1  
		if (testcase2 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq2.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq2.start(p_sequencer.read_seqr);
			end
		join
		end

		// write_rst = 1 and write_en = 0 & read_rst = 1 when read_en =0
	  if (testcase3 == 1 || run_all_test == 1) begin		
		fork
			begin
				wr_seq3.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq3.start(p_sequencer.read_seqr);
			end
		join
  	end
		// write_rst = 1 & write_en = 1 when read_rst = 1 & read_en =0
  	if (testcase4 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq4.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq4.start(p_sequencer.read_seqr);
			end
		join
		end
		// read_rst = 1 & read_en = 1 when write_rst = 1 & write_en =0
    if (testcase5 == 1 || run_all_test == 1) begin
		fork
			begin
				rd_seq5.start(p_sequencer.read_seqr);
			end
			begin
				wr_seq5.start(p_sequencer.write_seqr);
			end
		join
		end
		// 1st reset the write and read pointers and then perform 
		// read_rst = 1 & read_en = 1 when write_rst = 1 & write_en = 1
    if (testcase6 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq6.start(p_sequencer.write_seqr);
				wr_seq1.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq6.start(p_sequencer.read_seqr);
				rd_seq1.start(p_sequencer.read_seqr);
			end
		join
		end
	// mid break write operation sequence
	  if (testcase7 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq7.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq7.start(p_sequencer.read_seqr);
			end
		join
		end

		// mid break read operation sequence
		
	  if (testcase8 == 1 || run_all_test == 1) begin
		fork
			begin
				wr_seq8.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq8.start(p_sequencer.read_seqr);
			end
		join
		end

		// wrap around condition sequence
	  if (testcase9 == 1 || run_all_test == 1) begin
		fork
			begin
				rd_seq9.start(p_sequencer.read_seqr);
			end
			begin
				wr_seq9.start(p_sequencer.write_seqr);
			end
		join
    end

	endtask

endclass
*/

class async_fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(async_fifo_virtual_sequence)
  `uvm_declare_p_sequencer(async_fifo_virtual_sequencer)
   write_sequence1 wr_seq1;
   write_sequence2 wr_seq2; 
	 write_sequence3 wr_seq3;
	 write_sequence4 wr_seq4;
   write_sequence5 wr_seq5; 
	 write_sequence6 wr_seq6;
   write_sequence7 wr_seq7;
   //write_sequence8 wr_seq8; 
	 //write_sequence9 wr_seq9;
   
	 read_sequence1 rd_seq1;
   read_sequence2 rd_seq2; 
	 read_sequence3 rd_seq3;
	 read_sequence4 rd_seq4;
   read_sequence5 rd_seq5; 
	 read_sequence6 rd_seq6;
	 read_sequence7 rd_seq7;
   //read_sequence8 rd_seq8; 
	 //read_sequence9 rd_seq9;
	

  function new(string name = "async_fifo_virtual_sequence");
    super.new(name);
  endfunction

  task run_testcase1();
    wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

    `uvm_info(get_type_name(), ">>> Running Testcase 1 <<<", UVM_MEDIUM)
    fork
      wr_seq1.start(p_sequencer.write_seqr);
      rd_seq1.start(p_sequencer.read_seqr);
    join
  endtask

  task run_testcase2();
    wr_seq2 = write_sequence2::type_id::create("wr_seq2");
    rd_seq2 = read_sequence2::type_id::create("rd_seq2");

    `uvm_info(get_type_name(), ">>> Running Testcase 2 <<<", UVM_MEDIUM)
    fork
      wr_seq2.start(p_sequencer.write_seqr);
      rd_seq2.start(p_sequencer.read_seqr);
    join
  endtask

  task run_testcase3();
    wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

    wr_seq3 = write_sequence3::type_id::create("wr_seq3");
    rd_seq3 = read_sequence3::type_id::create("rd_seq3");

    `uvm_info(get_type_name(), ">>> Running Testcase 3 <<<", UVM_MEDIUM)
    fork
			begin
      wr_seq1.start(p_sequencer.write_seqr);	
      wr_seq3.start(p_sequencer.write_seqr);
			end
			begin
		  rd_seq3.start(p_sequencer.read_seqr);			
      rd_seq3.start(p_sequencer.read_seqr);
			end
    join
  endtask

	task run_testcase4();
    wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");
		wr_seq4 = write_sequence4::type_id::create("wr_seq4");
    rd_seq4 = read_sequence4::type_id::create("rd_seq4");

    `uvm_info(get_type_name(), ">>> Running Testcase 4 <<<", UVM_MEDIUM)
    fork
			begin
      wr_seq1.start(p_sequencer.write_seqr);
      wr_seq4.start(p_sequencer.write_seqr);
			end
			begin
        rd_seq1.start(p_sequencer.read_seqr);
				rd_seq4.start(p_sequencer.read_seqr);
			end
    join
  endtask

  task run_testcase5();

    wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

    wr_seq5 = write_sequence5::type_id::create("wr_seq5");
    rd_seq5 = read_sequence5::type_id::create("rd_seq5");

    `uvm_info(get_type_name(), ">>> Running Testcase 5 <<<", UVM_MEDIUM)
    fork
			begin
        wr_seq1.start(p_sequencer.write_seqr);
				wr_seq5.start(p_sequencer.write_seqr);
			end
			begin
        rd_seq1.start(p_sequencer.read_seqr);
		  	rd_seq5.start(p_sequencer.read_seqr);
			end
    join
  endtask

  task run_testcase6();
    
		wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

		wr_seq6 = write_sequence6::type_id::create("wr_seq6");
    rd_seq6 = read_sequence6::type_id::create("rd_seq6");

    `uvm_info(get_type_name(), ">>> Running Testcase 6 <<<", UVM_MEDIUM)
    fork
			begin
      wr_seq1.start(p_sequencer.write_seqr);
      wr_seq6.start(p_sequencer.write_seqr);
      wr_seq1.start(p_sequencer.write_seqr); 
			end
			begin
      rd_seq1.start(p_sequencer.read_seqr);
      rd_seq6.start(p_sequencer.read_seqr);
      rd_seq1.start(p_sequencer.read_seqr); 
      end
		join
  endtask
/*
	task run_testcase7();
    
		wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

		wr_seq7 = write_sequence7::type_id::create("wr_seq7");
    rd_seq7 = read_sequence7::type_id::create("rd_seq7");

    `uvm_info(get_type_name(), ">>> Running Testcase 7 <<<", UVM_MEDIUM)
    fork
			begin
     // wr_seq1.start(p_sequencer.write_seqr); 
      wr_seq7.start(p_sequencer.write_seqr);
			end
			begin
     // rd_seq1.start(p_sequencer.read_seqr); 
      rd_seq7.start(p_sequencer.read_seqr);
			end
    join
  endtask

  task run_testcase8();
   	wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    rd_seq1 = read_sequence1::type_id::create("rd_seq1");

		wr_seq8 = write_sequence8::type_id::create("wr_seq8");
    rd_seq8 = read_sequence8::type_id::create("rd_seq8");

    `uvm_info(get_type_name(), ">>> Running Testcase 8 <<<", UVM_MEDIUM)
   fork
			begin
      wr_seq1.start(p_sequencer.write_seqr); 
      wr_seq8.start(p_sequencer.write_seqr);
  	    end	
        begin
      rd_seq1.start(p_sequencer.read_seqr);
		  rd_seq8.start(p_sequencer.read_seqr);
			end
    join
  endtask
*/
  task run_testcase7();

  	//wr_seq1 = write_sequence1::type_id::create("wr_seq1");
    //rd_seq1 = read_sequence1::type_id::create("rd_seq1");

    wr_seq7 = write_sequence7::type_id::create("wr_seq7");
    rd_seq7 = read_sequence7::type_id::create("rd_seq7");

    `uvm_info(get_type_name(), ">>> Running Testcase 7 <<<", UVM_MEDIUM)
    fork
			begin
			//wr_seq1.start(p_sequencer.write_seqr);	
      wr_seq7.start(p_sequencer.write_seqr);
			end
			begin
      // rd_seq1.start(p_sequencer.read_seqr);
			 rd_seq7.start(p_sequencer.read_seqr);
			end
    join
  endtask

endclass
