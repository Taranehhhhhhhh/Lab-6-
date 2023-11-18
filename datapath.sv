module datapath(input [15:0]mdata, input[15:0]sximm5, input[15:0]sximm8, input[7:0]PC, input[15:0]C, input[2:0]writenum, input write, input[2:0]readnum, input clk, input loada, input asel, input [1:0] ALUop, input loadc, input loadb, input[1:0] shift, input bsel, input loads, input[1:0] vsel, output Z_out, output[15:0] datapath_out);

reg [15:0] data_in, Ain, Bin , in; 
reg [15:0] data_out, sout, out; 
reg [15:0] A_out; 

reg[2:0] Z_OUT; //changed to 3 bits to represent zero flag, negative flag, and overflow flag
reg [15:0] datapath_OUT; 

assign Z_out = Z_OUT; 
assign datapath_out = datapath_OUT; 

assign PC = 8'b00000000;
assign mdata = 16'b0000000000000000;

//1
regfile REGFILE(.data_in(data_in), .writenum(writenum), .write(write), .readnum(readnum), .clk(clk), .data_out(data_out)); 

//8
shifter SH(.in(in), .shift(shift), .sout(sout)); 

//2 
ALU alu(.Ain(Ain), .Bin(Bin), .ALUop(ALUop), .out(out), .Z(Z)); 

//3 
always@(posedge clk) begin 
    if(loada) A_out = data_out; 
end 

//4
always@(posedge clk) begin 
    if(loadb) in = data_out; 
end 


//5 
always@(posedge clk) begin 
    if(loadc) datapath_OUT = out; 
end 


//6 
always@(*)begin 
    case(asel)
    1'b0: Ain = A_out; 
    1'b1: Ain = 16'b0; 
    endcase 
end 

//7
always@(*)begin 
    case(bsel)
        1'b1: Bin = sximm5;    //changed input from "datapath_in" to sximm5
        1'b0: Bin = sout; 
    endcase 
end 

//9
    always@(*)begin             //changing the input MUX for regfile
    case(vsel)
    2'b00: data_in = C;
    2'b01: data_in = {8'b0,PC};
    2'b10: data_in = sximm8;
    2'b11: data_in = mdata;
    endcase
end 


//10 status block:
always@(posedge clk)begin //Z[2] = loads, Z[1] = negative flag, Z[0] = overflow flag
    if(loads) begin
        Z_OUT[2] = 1;
        if(out[15] == 1) Z_OUT[1] = 1;
        else Z_OUT[1] = 0;
        
    
    //NEED TO DO OVERFLOW DETECTION STILL 
    end
end 


endmodule: datapath 
