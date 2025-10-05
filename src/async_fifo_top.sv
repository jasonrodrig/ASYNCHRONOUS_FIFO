`include "async_fifo_defines.sv"
`include "async_fifo_design.v"
`include "async_fifo_interface.sv"
`include "async_fifo_packages.sv"
`include "async_fifo_assertions.sv"

import uvm_pkg::*;
import async_fifo_pkg::*;

module top;

	bit write_clk, read_clk;

	async_fifo_interface vif(write_clk,read_clk);

	FIFO dut(
		.wclk(vif.write_clk),
		.rclk(vif.read_clk),
		.wrst_n(vif.write_rst),
		.rrst_n(vif.read_rst),
		.winc(vif.write_en),
		.rinc(vif.read_en),
		.wdata(vif.write_data),
		.rdata(vif.read_data),
		.wfull(vif.write_full),
		.rempty(vif.read_empty)
	);

	bind vif async_fifo_assertions ASSERT(
		.write_clk(vif.write_clk),
		.read_clk(vif.read_clk),
		.write_rst(vif.write_rst),
		.read_rst(vif.read_rst),
		.write_en(vif.write_en),
		.read_en(vif.read_en),
		.write_data(vif.write_data),
		.read_data(vif.read_data),
		.write_full(vif.write_full),
		.read_empty(vif.read_empty),
		.write_ptr(dut.raddr),
		.read_ptr(dut.waddr)
	);

	initial begin
		write_clk = 1'b0;
		forever #5 write_clk = ~write_clk;
	end

	initial begin
		read_clk = 1'b0;
		forever #10 read_clk = ~read_clk;
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end

	initial begin
		uvm_config_db#(virtual async_fifo_interface)::set(null,"*","vif",vif);
	end

	initial begin
		run_test("async_fifo_test");
		#1000 $finish;
	end

endmodule
