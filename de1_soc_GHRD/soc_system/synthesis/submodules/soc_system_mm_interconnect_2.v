// soc_system_mm_interconnect_2.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 15.1 185

`timescale 1 ps / 1 ps
module soc_system_mm_interconnect_2 (
		input  wire        clk_0_clk_clk,                                                      //                                                    clk_0_clk.clk
		input  wire        hps_0_f2h_sdram0_data_translator_reset_reset_bridge_in_reset_reset, // hps_0_f2h_sdram0_data_translator_reset_reset_bridge_in_reset.reset
		input  wire        overlay_dma_reset_n_reset_bridge_in_reset_reset,                    //                    overlay_dma_reset_n_reset_bridge_in_reset.reset
		input  wire [31:0] overlay_dma_mm_read_address,                                        //                                          overlay_dma_mm_read.address
		output wire        overlay_dma_mm_read_waitrequest,                                    //                                                             .waitrequest
		input  wire [7:0]  overlay_dma_mm_read_burstcount,                                     //                                                             .burstcount
		input  wire [7:0]  overlay_dma_mm_read_byteenable,                                     //                                                             .byteenable
		input  wire        overlay_dma_mm_read_read,                                           //                                                             .read
		output wire [63:0] overlay_dma_mm_read_readdata,                                       //                                                             .readdata
		output wire        overlay_dma_mm_read_readdatavalid,                                  //                                                             .readdatavalid
		output wire [28:0] hps_0_f2h_sdram0_data_address,                                      //                                        hps_0_f2h_sdram0_data.address
		output wire        hps_0_f2h_sdram0_data_read,                                         //                                                             .read
		input  wire [63:0] hps_0_f2h_sdram0_data_readdata,                                     //                                                             .readdata
		output wire [7:0]  hps_0_f2h_sdram0_data_burstcount,                                   //                                                             .burstcount
		input  wire        hps_0_f2h_sdram0_data_readdatavalid,                                //                                                             .readdatavalid
		input  wire        hps_0_f2h_sdram0_data_waitrequest                                   //                                                             .waitrequest
	);

	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_waitrequest;   // hps_0_f2h_sdram0_data_translator:uav_waitrequest -> overlay_dma_mm_read_translator:uav_waitrequest
	wire  [63:0] overlay_dma_mm_read_translator_avalon_universal_master_0_readdata;      // hps_0_f2h_sdram0_data_translator:uav_readdata -> overlay_dma_mm_read_translator:uav_readdata
	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_debugaccess;   // overlay_dma_mm_read_translator:uav_debugaccess -> hps_0_f2h_sdram0_data_translator:uav_debugaccess
	wire  [31:0] overlay_dma_mm_read_translator_avalon_universal_master_0_address;       // overlay_dma_mm_read_translator:uav_address -> hps_0_f2h_sdram0_data_translator:uav_address
	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_read;          // overlay_dma_mm_read_translator:uav_read -> hps_0_f2h_sdram0_data_translator:uav_read
	wire   [7:0] overlay_dma_mm_read_translator_avalon_universal_master_0_byteenable;    // overlay_dma_mm_read_translator:uav_byteenable -> hps_0_f2h_sdram0_data_translator:uav_byteenable
	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_readdatavalid; // hps_0_f2h_sdram0_data_translator:uav_readdatavalid -> overlay_dma_mm_read_translator:uav_readdatavalid
	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_lock;          // overlay_dma_mm_read_translator:uav_lock -> hps_0_f2h_sdram0_data_translator:uav_lock
	wire         overlay_dma_mm_read_translator_avalon_universal_master_0_write;         // overlay_dma_mm_read_translator:uav_write -> hps_0_f2h_sdram0_data_translator:uav_write
	wire  [63:0] overlay_dma_mm_read_translator_avalon_universal_master_0_writedata;     // overlay_dma_mm_read_translator:uav_writedata -> hps_0_f2h_sdram0_data_translator:uav_writedata
	wire  [10:0] overlay_dma_mm_read_translator_avalon_universal_master_0_burstcount;    // overlay_dma_mm_read_translator:uav_burstcount -> hps_0_f2h_sdram0_data_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (64),
		.AV_BURSTCOUNT_W             (8),
		.AV_BYTEENABLE_W             (8),
		.UAV_ADDRESS_W               (32),
		.UAV_BURSTCOUNT_W            (11),
		.USE_READ                    (1),
		.USE_WRITE                   (0),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (8),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (1),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) overlay_dma_mm_read_translator (
		.clk                    (clk_0_clk_clk),                                                          //                       clk.clk
		.reset                  (overlay_dma_reset_n_reset_bridge_in_reset_reset),                        //                     reset.reset
		.uav_address            (overlay_dma_mm_read_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (overlay_dma_mm_read_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (overlay_dma_mm_read_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (overlay_dma_mm_read_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (overlay_dma_mm_read_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (overlay_dma_mm_read_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (overlay_dma_mm_read_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (overlay_dma_mm_read_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (overlay_dma_mm_read_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (overlay_dma_mm_read_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (overlay_dma_mm_read_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (overlay_dma_mm_read_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (overlay_dma_mm_read_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (overlay_dma_mm_read_burstcount),                                         //                          .burstcount
		.av_byteenable          (overlay_dma_mm_read_byteenable),                                         //                          .byteenable
		.av_read                (overlay_dma_mm_read_read),                                               //                          .read
		.av_readdata            (overlay_dma_mm_read_readdata),                                           //                          .readdata
		.av_readdatavalid       (overlay_dma_mm_read_readdatavalid),                                      //                          .readdatavalid
		.av_beginbursttransfer  (1'b0),                                                                   //               (terminated)
		.av_begintransfer       (1'b0),                                                                   //               (terminated)
		.av_chipselect          (1'b0),                                                                   //               (terminated)
		.av_write               (1'b0),                                                                   //               (terminated)
		.av_writedata           (64'b0000000000000000000000000000000000000000000000000000000000000000),   //               (terminated)
		.av_lock                (1'b0),                                                                   //               (terminated)
		.av_debugaccess         (1'b0),                                                                   //               (terminated)
		.uav_clken              (),                                                                       //               (terminated)
		.av_clken               (1'b1),                                                                   //               (terminated)
		.uav_response           (2'b00),                                                                  //               (terminated)
		.av_response            (),                                                                       //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                   //               (terminated)
		.av_writeresponsevalid  ()                                                                        //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (29),
		.AV_DATA_W                      (64),
		.UAV_DATA_W                     (64),
		.AV_BURSTCOUNT_W                (8),
		.AV_BYTEENABLE_W                (8),
		.UAV_BYTEENABLE_W               (8),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (11),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (8),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) hps_0_f2h_sdram0_data_translator (
		.clk                    (clk_0_clk_clk),                                                          //                      clk.clk
		.reset                  (hps_0_f2h_sdram0_data_translator_reset_reset_bridge_in_reset_reset),     //                    reset.reset
		.uav_address            (overlay_dma_mm_read_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (overlay_dma_mm_read_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (overlay_dma_mm_read_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (overlay_dma_mm_read_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (overlay_dma_mm_read_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (overlay_dma_mm_read_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (overlay_dma_mm_read_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (overlay_dma_mm_read_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (overlay_dma_mm_read_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (overlay_dma_mm_read_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (overlay_dma_mm_read_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (hps_0_f2h_sdram0_data_address),                                          //      avalon_anti_slave_0.address
		.av_read                (hps_0_f2h_sdram0_data_read),                                             //                         .read
		.av_readdata            (hps_0_f2h_sdram0_data_readdata),                                         //                         .readdata
		.av_burstcount          (hps_0_f2h_sdram0_data_burstcount),                                       //                         .burstcount
		.av_readdatavalid       (hps_0_f2h_sdram0_data_readdatavalid),                                    //                         .readdatavalid
		.av_waitrequest         (hps_0_f2h_sdram0_data_waitrequest),                                      //                         .waitrequest
		.av_write               (),                                                                       //              (terminated)
		.av_writedata           (),                                                                       //              (terminated)
		.av_begintransfer       (),                                                                       //              (terminated)
		.av_beginbursttransfer  (),                                                                       //              (terminated)
		.av_byteenable          (),                                                                       //              (terminated)
		.av_writebyteenable     (),                                                                       //              (terminated)
		.av_lock                (),                                                                       //              (terminated)
		.av_chipselect          (),                                                                       //              (terminated)
		.av_clken               (),                                                                       //              (terminated)
		.uav_clken              (1'b0),                                                                   //              (terminated)
		.av_debugaccess         (),                                                                       //              (terminated)
		.av_outputenable        (),                                                                       //              (terminated)
		.uav_response           (),                                                                       //              (terminated)
		.av_response            (2'b00),                                                                  //              (terminated)
		.uav_writeresponsevalid (),                                                                       //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                    //              (terminated)
	);

endmodule
