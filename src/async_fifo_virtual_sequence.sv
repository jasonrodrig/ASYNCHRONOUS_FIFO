class async_fifo_virtual_sequence extends uvm_sequence;

	`uvm_object_utils(async_fifo_virtual_sequence)
	`uvm_declare_p_sequencer(async_fifo_virtual_sequencer)
	async_fifo_write_sequencer write_seq;
	async_fifo_read_sequencer read_seq;

	//async_fifo_write_sequence write_seq;
	//async_fifo_read_sequence read_seq;
	write_sequence1 wr_seq1;
	read_sequence1 rd_seq1;
	write_sequence2 wr_seq2;
	read_sequence2 rd_seq2;
	write_sequence3 wr_seq3;
	read_sequence3 rd_seq3;
	write_sequence4 wr_seq4;
	read_sequence4 rd_seq4;

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
	endfunction 


	task body();
		fork
			begin
				wr_seq1.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq1.start(p_sequencer.read_seqr);
			end
		join

		fork
			begin
				wr_seq2.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq2.start(p_sequencer.read_seqr);
			end
		join

		fork
			begin
				wr_seq3.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq3.start(p_sequencer.read_seqr);
			end
		join

		fork
			begin
				wr_seq4.start(p_sequencer.write_seqr);
			end
			begin
				rd_seq4.start(p_sequencer.read_seqr);
			end
		join

	endtask

endclass

