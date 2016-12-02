

module avalon_slave_edid (/*autoport*/
//inout
			edid_scl,
			edid_sda,
//output
			slave_readdata,
//input
			clk,
			reset,
			slave_address,
			slave_read,
			slave_write,
			slave_writedata,
			slave_byteenable);

// most of the set values will only be used by the component .tcl file.  The DATA_WIDTH and MODE_X = 3 influence the hardware created.
// ENABLE_SYNC_SIGNALS isn't used by this hardware at all but it provided anyway so that it can be exposed in the component .tcl file
// to control the stubbing of certain signals.
parameter DATA_WIDTH = 8;          // word size of each input and output register


// clock interface
input clk;
input reset;


// slave interface
input [7:0] slave_address;
input slave_read;
input slave_write;
output wire [DATA_WIDTH-1:0] slave_readdata;
input [DATA_WIDTH-1:0] slave_writedata;
input [(DATA_WIDTH/8)-1:0] slave_byteenable;


// user interface
inout wire edid_scl;
inout wire edid_sda;

wire [7:0] addr_i2c;
wire [7:0] data_i2c;

edid_mem on_chip_edid(
	.clock    (clk),
	.data     (slave_writedata),
	.wraddress(slave_address),
	.wren     (slave_write),
	.q        (data_i2c),
	.rdaddress(addr_i2c)
	);
i2cSlave edid_i2c(
	.clk          (clk),
	.rst          (reset),
	.sda          (edid_sda),
	.scl          (edid_scl),
	.regAddr      (addr_i2c),
	.dataFromRegIF(data_i2c),
	.writeEn      (),
	.dataToRegIF  ()
);
assign slave_readdata = 0;
	
endmodule
