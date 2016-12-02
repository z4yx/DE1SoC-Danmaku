/*
--创建日期   : 2015-05-24
--目标芯片   : EP4CE22F17C8
--时钟选择   : clk=25MHz
--演示说明   : rst全局复位低有效，fifo*接输出像素FIFO，
              pause接动画暂停输入
*/
module test_img_feeder(
  input wire rst,
  input wire clk,
  input wire clk_feeder,

  output wire[31:0] fifoData_out,
  input wire fifoRdclk,
  input wire fifoRdreq,
  output wire fifoRdempty,
  
  input wire pause
);

reg[11:0] hcnt, vcnt;
wire[31:0] pixel_data;
wire sync_pixel_h;
wire sync_pixel_v;
wire wrreq;
wire wrfull;

fifo_32to32 fifo(
    .data({pixel_data[31:2], sync_pixel_v ? 2'b10 : (sync_pixel_h ? 2'b01 : 2'b0) }),
    .rdclk(fifoRdclk),
    .rdreq(fifoRdreq),
    .wrclk(clk_feeder),
    .wrreq(wrreq),
    .q(fifoData_out),
    .rdempty(fifoRdempty),
    .wrfull(wrfull)
);

simple img1(
    clk_feeder,
    rst,
    hcnt,
    vcnt,
    'd800,
    'd600,
    pixel_data[31:24],
    pixel_data[23:16],
    pixel_data[15:8],
    pixel_data[7:0],
    pause
);

//assign pixel_data = {4'd0, hcnt, 16'd0};

assign sync_pixel_h = (hcnt==0);
assign sync_pixel_v = (hcnt==0 && vcnt == 0);
assign wrreq = ~wrfull;

reg[1:0] stopped;

always @(posedge clk_feeder or negedge rst) begin
    if (!rst) begin
        hcnt<=0;
        vcnt<=0;
        stopped<=0;
    end else if(!wrfull)begin
        if (hcnt != 0 | stopped == 2'd1) begin 
          if (hcnt == 800-1) begin
              hcnt <= 0;
              vcnt <= (vcnt == 600-1) ? 0 : vcnt+1;
          end
          else begin
              hcnt<=hcnt+1;
          end
          stopped <= 0;
        end else begin
          stopped <= stopped + 1;
        end
    end
end
endmodule
