module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out;
// fill out the 


reg[15:0] OUT; 
reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7; 

assign data_out = OUT; 


//sequential logic for writing into the registers 
always@(posedge clk) begin 
    if(write)begin
        case(writenum)
        3'b000: R0 = data_in;
        3'b001: R1 = data_in;
        3'b010: R2 = data_in;
        3'b011: R3 = data_in;
        3'b100: R4 = data_in;
        3'b101: R5 = data_in;
        3'b110: R6 = data_in;
        3'b111: R7 = data_in; 
        default: R0 = data_in; 
        endcase 
    end 
end 

//combinational logic for reading from the registers 
always@(*)begin 
    case(readnum)
        3'b000: OUT = R0;
        3'b001: OUT = R1;
        3'b010: OUT = R2;
        3'b011: OUT = R3;
        3'b100: OUT = R4;
        3'b101: OUT = R5;
        3'b110: OUT = R6;
        3'b111: OUT = R7; 
        default: OUT = R0; 
        endcase    
end  


endmodule
