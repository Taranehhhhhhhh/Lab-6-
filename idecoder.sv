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

reg clk; 
wire [15:0] ins_reg; 
reg [2:0]Readnum; 
assign readnum = Readnum; 

reg[2:0]Writenum; 
assign writenum = Writenum; 

// the register to store the value of in 

module ins_r(input clk, input load, input [15:0]in , output [15:0]out); 

always@(posedge clk) begin 

    reg [15:0]OUT; 
    assign OUT = out; 

    if(load)begin 
        OUT <= in; 
    end 
end
endmodule: ins_r 




ins_r DUT3(.load(load), .in(in), .out(ins_reg)); 

assign ins_reg[15:13] = opcode; 
assign ins_reg[12:11] = op; 
assign ins_reg[12:11] = ALUop; 
assign ins_reg[4:3]= shift;


//the three select mux for readnum and writenum 

always@(*)begin 
    case(nsel)
        3'b000: Readnum = ins_reg[10:8]; 
        3'b001: Readnum = ins_reg[7:5]; 
        3'b010: Readnum = ins_reg[2:0]; 
        default: Readnum = 3'bxxx; 
    endcase
end 

always@(*)begin 
    case(nsel)
        3'b000: Writenum = ins_reg[10:8]; 
        3'b001: Writenum = ins_reg[7:5]; 
        3'b010: Writenum = ins_reg[2:0]; 
        default: Writenum = 3'bxxx; 
    endcase
end




reg[4:0] imm5; 
assign ins_reg[4:0] = imm5; 

sign_ext5 DUT1(.in(imm5), .out(sximm5)); 


reg[7:0] imm8; 
assign ins_reg[7:0] = imm8; 

sign_ext8 DUT2(.in(imm8), .out(sximm8)); 

// sign extension for a 5-bit input 
module sign_ext5([4:0] in, [15:0] out); 

assign out = 16'(signed'(in));

endmodule: sign_ext5 


//sign extension for a 8-but input 
module sign_ext8([7:0] in, [15:0] out); 

assign out = 16'(signed'(in));

endmodule: sign_ext8 


endmodule: idecoder 
