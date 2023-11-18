module shifter(in,shift,sout);
input [15:0] in;
input [1:0] shift;
output [15:0] sout;
// fill out the rest

reg [15:0] SOUT; 
assign sout = SOUT; 

always@(*)begin 
    case(shift)
    2'b00: SOUT = in;  
    2'b01: SOUT = in << 1; 
    2'b10: SOUT = in >> 1; 
    2'b11: SOUT = {in[15], in[15:1]}; 
    default: SOUT = in; 
    endcase 
end 

endmodule
