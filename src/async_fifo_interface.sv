interface async_fifo_interface(input bit write_clk , read_clk);

	logic write_rst , read_rst;
	logic write_en  , read_en;
	logic [ `DATA_WIDTH - 1 : 0 ] write_data , read_data;
	logic write_full , read_empty;

//	always@(write_clk or read_clk) $display(" DUT : write_ptr = %b , read_ptr = %b", dut.waddr , dut.raddr );
	
	clocking async_fifo_read_driver_cb@(posedge read_clk);
		default input #1 output #1;
		output read_rst , read_en;	
	endclocking

	clocking async_fifo_write_driver_cb@(posedge write_clk);
		default input #1 output #1;
		output write_rst , write_en , write_data;	
	endclocking

	clocking async_fifo_read_monitor_cb@(posedge read_clk);
		default input #1 output #1;
		input read_rst , read_en, read_data, read_empty;	
	endclocking

	clocking async_fifo_write_monitor_cb@(posedge write_clk);
		default input #1 output #1;
		input write_rst , write_en , write_data, write_full;	
	endclocking

	modport READ_DRIVER(clocking async_fifo_read_driver_cb);
	modport WRITE_DRIVER(clocking async_fifo_write_driver_cb);
	modport READ_MONITOR(clocking async_fifo_read_monitor_cb);
	modport WRITE_MONITOR(clocking async_fifo_write_monitor_cb);

endinterface
