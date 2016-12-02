/*
--创建日期   : 2015-05-17
--目标芯片   : EP4CE22F17C8
--时钟选择   : odck_in<=165MHz
--演示说明   : odck为像素时钟，v/hsync为同步信号，de为数据有效信号，pixel_*为像素颜色信号，scdt_o为信号有效指示
*/
module tfp401a(
input wire rst,

input wire odck_in,
input wire vsync_in,
input wire hsync_in,
input wire de_in,
input wire[7:0] pixel_r_in,
input wire[7:0] pixel_g_in,
input wire[7:0] pixel_b_in,

output reg scdt_o,
output wire odck_o,
output wire vsync_o,
output wire hsync_o,
output wire de_o,
output wire[7:0] pixel_r_o,
output wire[7:0] pixel_g_o,
output wire[7:0] pixel_b_o
);

assign odck_o = odck_in;
assign vsync_o = vsync_in;
assign hsync_o = hsync_in;
assign de_o = de_in;
assign pixel_b_o = pixel_b_in;
assign pixel_r_o = pixel_r_in;
assign pixel_g_o = pixel_g_in;

reg[1:0] de_det, de_cnt;
reg[19:0] counter;
wire de_transition;

always @(posedge odck_in) begin
    de_det <= {de_det[0], de_in};
end

assign de_transition = de_det[1] != de_det[0];

always @(posedge odck_in or negedge rst) begin
    if (!rst) begin
        scdt_o <= 0;
        counter <= 0;
        de_cnt <= 0;
    end
    else begin
        if (scdt_o && counter==20'd1000000) begin //is active now
            counter<=0;
            de_cnt <=0;
            scdt_o <=(de_cnt==2'd0 ? 1'b0 : 1'b1);
        end else if(!scdt_o && counter==20'd1600) begin
            counter<=0;            
            de_cnt <=0;
            scdt_o <=(de_cnt==2'd2 ? 1'b1 : 1'b0);
        end else begin
            counter <= counter+1'b1;
            if(de_transition && de_cnt != 2'd2)
                de_cnt <= de_cnt+1'b1;
        end
    end

end

endmodule
