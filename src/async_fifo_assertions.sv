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
	read_empty,
	read_ptr,
	write_ptr
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
	input [ ADDR_WIDTH - 1 : 0 ]write_ptr;
	input [ ADDR_WIDTH - 1 : 0 ]read_ptr;

//always@(write_clk or read_clk) $display(" ASSERTION : write_ptr = %b , read_ptr = %b", write_ptr , read_ptr );
	property p1;
		@(posedge write_clk or posedge read_clk)
		 ##7 !( $isunknown(write_rst) || $isunknown(read_rst) || $isunknown(write_en) || $isunknown(read_en) ||
			   $isunknown(write_data) || $isunknown(read_data) || $isunknown(write_full) || $isunknown(read_empty) );
	endproperty

	isunknown_signal_check_1:
	assert property(p1)
	$info("all the signals are known - Assertion 1 passed");
	else
	$error("Assertion 1 failed - all the signals are unknown");

	property p2;
		@(posedge write_clk)
		  (!write_rst && !write_en) |-> !write_full ;
	endproperty

	write_reset_check_2:
	assert property(p2)
	$info("write_reset is valid - Assertion 2 passed");
	else
	$error("Assertion 2 failed - write_reset is invlaid");

	property p3;
		@(posedge read_clk)
		  (!read_rst && !read_en) |-> read_empty ;
	endproperty

	read_reset_check_3:
	assert property(p3)
	$info("read_reset is valid - Assertion 3 passed");
	else
	$error("Assertion 3 failed - read_reset is invlaid");

	property p4;
		@(posedge write_clk)
		 ##1 ( write_rst && !write_en) |-> ( write_full == $past(write_full,1)) ;
	endproperty

	write_full_stable_check_4:
	assert property(p4)
	$info("write_full is stable - Assertion 4 passed");
	else
	$error("Assertion 4 failed - write_full is unstable");

	property p5;
		@(posedge read_clk)
	 ##5 ( read_rst && !read_en) |-> (( read_data == $past(read_data,1)));
	endproperty

	read_latch_check_5:
	assert property(p5)
	$info("read_latch is valid - Assertion 5 passed");
	else
	$error("Assertion 5 failed - read_latch is invlaid");

	property p6;
		@(posedge read_clk)
  	 ( read_rst && read_en) |-> ( read_data );
	endproperty

	data_valid_check_6:
	assert property(p6)
	$info(" read_data is valid - Assertion 6 passed");
	else
	$error("Assertion 6 failed - read_data is invlaid");

	property p7;
		@(posedge read_clk)
	 ##3 ( read_rst && !read_en) |-> ( ( read_empty == $past(read_empty,1) ) );
	endproperty

	read_empty_stable_check_7:
	assert property(p7)
	$info("read_empty is stable - Assertion 7 passed");
	else
	$error("Assertion 7 failed - read_empty is unstable");

	property p8;
		@(posedge write_clk)
		//( ( ~write_ptr[3] == read_ptr[3] ) && ( write_ptr[2:0] == read_ptr[2:0] ) ) |-> ( write_full )  ;
		  ( write_ptr == `FIFO_DEPTH - 1 ) |-> ( write_full );
	endproperty

	is_write_full_check_8:
	assert property(p8)
	$info(" write_full is valid - Assertion 8 passed");
	else
	$error("Assertion 8 failed - write_full is invlaid");

	property p9;
		@(posedge read_clk)
	   ( write_ptr[3:0] == read_ptr[3:0] ) |-> ( read_empty );
	endproperty

	is_read_empty_check_9:
	assert property(p9)
	$info("read_empty is valid - Assertion 9 passed");
	else
	$error("Assertion 9 failed - read_empty is invlaid");

endinterface
