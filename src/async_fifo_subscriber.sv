`uvm_analysis_imp_decl(_write_mon_cg)
`uvm_analysis_imp_decl(_read_mon_cg)

class async_fifo_subscriber extends uvm_component;

	`uvm_component_utils(async_fifo_subscriber)
	uvm_analysis_imp_write_mon_cg#(async_fifo_write_sequence_item, async_fifo_subscriber) cov_write_mon_port;
	uvm_analysis_imp_read_mon_cg#(async_fifo_read_sequence_item, async_fifo_subscriber) cov_read_mon_port;

	async_fifo_write_sequence_item write_seq;
	async_fifo_read_sequence_item read_seq;

//	int wr_rst, wr_en, wr_data, wr_full;
//	int rd_rst, rd_en, rd_data, rd_empty;
	
	real write_mon_cov_results, read_mon_cov_results ;

	covergroup write_coverage;
		option.per_instance = 1;
		WRITE_RESET  : coverpoint write_seq.write_rst  { bins wr_rst[]  = { 0 , 1 } ; }
		WRITE_ENABLE : coverpoint write_seq.write_en   { bins wr_en[]   = { 0 , 1 } ; }
		WRITE_DATA   : coverpoint write_seq.write_data { bins wr_data   = { [ 0 : 255 ] } ; }
		WRITE_FULL   : coverpoint write_seq.write_full { bins wr_full[] = { 0 , 1 } ; }
    WRITE_RESETXWRITE_ENABLE : cross WRITE_RESET , WRITE_ENABLE ;
	endgroup

	covergroup read_coverage;
		option.per_instance = 1;
		READ_RESET  : coverpoint read_seq.read_rst   { bins rd_rst[]   = { 0 , 1 } ; }
		READ_ENABLE : coverpoint read_seq.read_en    { bins rd_en[]    = { 0 , 1 } ; }
		READ_DATA   : coverpoint read_seq.read_data  { bins rd_data    = { [ 0 : 255 ] } ; }
		READ_EMPTY  : coverpoint read_seq.read_empty { bins rd_empty[] = { 0 , 1 } ; }
		READ_RESETXREAD_ENABLE : cross READ_RESET , READ_ENABLE  ; 
	endgroup

	function new(string name = "async_fifo_subscriber", uvm_component parent);
		super.new(name,parent);
		read_coverage  = new();
		write_coverage = new();
		//write_seq = async_fifo_write_sequence_item::type_id::create("write_seq");
		//read_seq  = async_fifo_read_sequence_item::type_id::create("read_seq");
		cov_write_mon_port = new("cov_write_mon_port",this);
		cov_read_mon_port  = new("cov_read_mon_port",this);
	endfunction

	function void write_write_mon_cg(async_fifo_write_sequence_item wr_seq);
		//wr_rst  = wr_seq.write_rst;
		//wr_en   = wr_seq.write_en;
		//wr_data = wr_seq.write_data;
		//wr_full = wr_seq.write_full;
		write_seq = wr_seq;
		write_coverage.sample();
	endfunction

	function void write_read_mon_cg(async_fifo_read_sequence_item rd_seq);
		//rd_rst  = rd_seq.read_rst;
		//rd_en   = rd_seq.read_en;
		//rd_data = rd_seq.read_data;
		//rd_empty = rd_seq.read_empty;
		read_seq = rd_seq;
		read_coverage.sample();
	endfunction

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		write_mon_cov_results  = write_coverage.get_coverage();
		read_mon_cov_results   = read_coverage.get_coverage();                 
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name, $sformatf("[WRITE_MONITOR]  Coverage ------> %0.2f%%", write_mon_cov_results ), UVM_MEDIUM);
		`uvm_info(get_type_name, $sformatf("[READ_MONITOR]   Coverage ------> %0.2f%%", read_mon_cov_results  ), UVM_MEDIUM);
	endfunction

endclass
