interface async_fifo_assertions(
	write_clk,
	read_clk,
	write_rst,
	read_rst,
	write_en,
	read_en,
	write_data,
	read_data,
	write_full,
	read_empty
);
	input	write_clk;
	input	read_clk;
	input write_rst;
	input	read_rst;
	input	write_en;
	input	read_en;
	input	[ `DATA_WIDTH - 1 : 0 ] write_data;
	input	[ `DATA_WIDTH - 1 : 0 ] read_data;
	input	write_full;
	input	read_empty;

endinterface
