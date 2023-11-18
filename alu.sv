module ALU(Ain,Bin,ALUop,out,Z);
input [15:0] Ain, Bin;
input [1:0] ALUop;
output [15:0] out;
output Z;
// fill out the rest


reg [15:0] OUT;  
reg z_out = 1'b0; 

assign out = OUT;
assign Z = z_out;  

always@(*)begin 
    case(ALUop)
    2'b00: OUT = Ain + Bin; 
    2'b01: OUT = Ain - Bin; 
    2'b10: OUT = Ain &  Bin; 
    2'b11: OUT = ~ Bin; 
    default: OUT = Ain; 
    endcase 

    if( OUT == 16'sd0) begin 
        z_out = 1'b1; 
    end
    else begin 
        z_out = 1'b0; 
    end 
 
end 


endmodule