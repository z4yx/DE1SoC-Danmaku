// new_component.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module pixel_filter (
		output wire [28:0] avm_m0_address,     // avm_m0.address
		input  wire        avm_m0_waitrequest, //       .waitrequest
		output wire        avm_m0_write,       //       .write
		output wire [63:0] avm_m0_writedata,   //       .writedata
		output wire [7:0]  avm_m0_burstcount,  //       .burstcount
		output wire [7:0]  avm_m0_byteenable,  //       .byteenable
		input  wire        clock_clk,          //  clock.clk
		input  wire        reset_reset,        //  reset.reset
		input  wire [28:0] avm_s0_address,     // avm_s0.address
		input  wire [7:0]  avm_s0_burstcount,  //       .burstcount
		input  wire        avm_s0_write,       //       .write
		input  wire [7:0]  avm_s0_byteenable,  //       .byteenable
		output wire        avm_s0_waitrequest, //       .waitrequest
		input  wire [63:0] avm_s0_writedata    //       .writedata
	);

	wire[7:0] mask;
	
	generate
	genvar i;
	for(i=0;i<8;i=i+1)begin : m
		assign mask[i] = (avm_s0_writedata[(i+1)*8-4:i*8] != 5'hd);
	end
	endgenerate
	
	assign avm_m0_address = avm_s0_address;

	assign avm_m0_byteenable = avm_s0_byteenable & mask;

	assign avm_m0_write = avm_s0_write;

	assign avm_m0_writedata = avm_s0_writedata;

	assign avm_m0_burstcount = avm_s0_burstcount;

	assign avm_s0_waitrequest = avm_m0_waitrequest;

endmodule
