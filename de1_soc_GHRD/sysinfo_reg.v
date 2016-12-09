
`timescale 1 ns / 1 ps
module sysinfo_reg (
		input  wire [7:0]  avs_s0_address,     // avs_s0.address
		input  wire        avs_s0_read,        //       .read
		output reg [31:0] avs_s0_readdata,    //       .readdata
		input  wire        avs_s0_write,       //       .write
		input  wire [31:0] avs_s0_writedata,   //       .writedata
		output wire        avs_s0_waitrequest, //       .waitrequest
		input  wire [31:0] info_resolution,
		input  wire        clock_clk,          //  clock.clk
		input  wire        reset_reset         //  reset.reset
	);

	wire [31:0] info_resolution_sync;
	assign avs_s0_waitrequest = 1'b0;

	always @(posedge clock_clk or posedge reset_reset) begin : proc_read
		if(reset_reset) begin
			avs_s0_readdata <= 0;
		end else begin
			if (avs_s0_address == 0)
				avs_s0_readdata <= info_resolution_sync;
			else
				avs_s0_readdata <= 0;
		end
	end

	altera_std_synchronizer_bundle #(
		.depth(2),
		.width(32)
	) res_sync (
		.clk(clock_clk),
		.reset_n(~reset_reset),
		.din(info_resolution),
		.dout(info_resolution_sync)
   );

endmodule
