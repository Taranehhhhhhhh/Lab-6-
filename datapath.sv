module datapath(input [15:0]datapath_in, input[2:0]writenum, input write, input[2:0]readnum, input clk, input loada, input asel, input [1:0] ALUop, input loadc, input loadb, input[1:0] shift, input bsel, input loads, input[1:0] vsel, output Z_out, output[15:0] datapath_out);

reg [15:0] data_in, Ain, Bin , in; 
reg [15:0] data_out, sout, out; 
reg [15:0] A_out; 

reg Z_OUT; 
reg [15:0] datapath_OUT; 

assign Z_out = Z_OUT; 
assign datapath_out = datapath_OUT; 



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
        1'b1: Bin = {11'b0, datapath_in[4:0]}; 
        1'b0: Bin = sout; 
    endcase 
end 

//9
always@(*)begin 
    case(vsel)
    1'b1: data_in = datapath_in; 
    1'b0: data_in = datapath_OUT; 
    endcase
end 


//10
always@(posedge clk)begin 
    if(loads) Z_OUT = Z; 
end 


endmodule: datapath 
