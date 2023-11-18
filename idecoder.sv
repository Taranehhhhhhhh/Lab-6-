module idecoder(in, load, nsel, opcode, op, ALUop, sximm5, sximm8, shift, readnum, writenum);

input load; 
input [15:0] in; 
input [2:0] nsel; 
output [2:0] opcode; 
output [1:0] op; 
output [1:0] ALUop; 
output [15:0] sximm5; 
output [15:0] sximm8; 
output [1:0] shift; 
output [2:0] readnum; 
output [2:0] writenum; 

reg clk 
reg [15:0] ins_reg; 

// the register to store the value of in 
always@(posedge clk) begin 
    if(load)begin 
        ins_reg<= in; 
    end 
end 

assign [15:13]ins_reg = opcode; 
assign [12:11]ins_reg = op; 
assign [12:11]ins_reg = ALUop; 
assign [4:3]ins_reg = shift;


//the three select mux for readnum and writenum 

always@(*)begin 
    case(nsel)
    3'b000: [10:8]ins_reg = readnum; 
    3'b001: [7:5]ins_reg = readnum; 
    3'b010: [2:0]ins_reg = readnum; 
    default: readnum = 3'bxxx; 
    endcase
end 

always@(*)begin 
    case(nsel)
    3'b000: [10:8]ins_reg = writenum; 
    3'b001: [7:5]ins_reg = writenum; 
    3'b010: [2:0]ins_reg = writenum; 
    default: writenum = 3'bxxx; 
    endcase
end 

reg[4:0] imm5; 
assign [4:0]ins_reg = imm5; 

sign_ext5 DUT1(.imm5(in), .sximm5(out)); 


reg[7:0] imm8; 
assign [7:0]ins_reg = imm8; 

sign_ext8 DUT2(.imm8(in), .sximm8(out)); 

// sign extension for a 5-bit input 
module sign_ext5([4:0] in, [15:0] out); 

assign out = 16'(signed'(in));

endmodule: sign_ext5 


//sign extension for a 8-but input 
module sign_ext8([7:0] in, [15:0] out); 

assign out = 16'(signed'(in));

endmodule: sign_ext8 


endmodule: idecoder 