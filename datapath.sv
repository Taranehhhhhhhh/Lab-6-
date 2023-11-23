module datapath(input [15:0]mdata, input[15:0]sximm5, input[15:0]sximm8, input[7:0]PC, input[2:0]writenum, input write, input[2:0]readnum, input clk, input loada, input asel, input [1:0] ALUop, input loadc, input loadb, input[1:0] shift, input bsel, input loads, input[2:0] vsel, output Z_out,output N, output V, output Z, output[15:0] datapath_out);

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
    2'b00: data_in = datapath_OUT;
    2'b01: data_in = {8'b0,PC};
    2'b10: data_in = sximm8;
    2'b11: data_in = mdata;
    endcase
end 


    //10[0] status block for negative check:
    always@(posedge clk)begin //N: negative flag, V, overflow flag, Z: zero flag
        if(loads) begin
        if(out[15] == 1) N = 1'b1;
        else N = 1'b0;
    end
end 
    //10[1] status block for Z (same as lab5
    always@(posedge clk) begin
        if(loads) Z = 1'b1;
    end

    //10[2] status block for overflow
    always@(posedge clk) begin
        if(loads) begin
            //write code here
        end
    end


endmodule: datapath 
