module datapath_tb(); 

reg [15:0]mdata;
reg[15:0]sximm5;
reg[15:0]sximm8;
reg[7:0]PC;
reg[2:0]writenum; 
reg write; 
reg[2:0]readnum; 
reg clk;  
reg loada;  
reg asel;  
reg [1:0] ALUop; 
reg loadc;  
reg loadb;  
reg[1:0] shift; 
reg bsel; 
reg loads; 
reg[1:0] vsel;
reg err;   
wire Z_out; 
wire[15:0] datapath_out; 


datapath DP(.datapath_in(datapath_in), .writenum(writenum), .write(write), .readnum(readnum), .clk(clk), .loada(loada), .asel(asel), .ALUop(ALUop), .loadc(loadc), .loadb(loadb), .shift(shift), .bsel(bsel), .loads(loads), .vsel(vsel), .Z_out(Z_out), .datapath_out(datapath_out)); 


//MOV R0, #7 
//MOV R1, #2 
//ADD R2, R1, R0, LSL#1 


initial begin 
    clk = 0; #5; 
    forever begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end 
end 

initial begin 


//MOV R0, #7 
//MOV R1, #2 
//ADD R2, R1, R0, LSL#1 

//MOV R0, #7 
err = 1'b0; 
datapath_in = 16'sd7; 
vsel = 1'b1; 
//data_in = 7  
writenum = 3'd0; 
write = 1'b1; 
loada = 1'b0; 
loadb = 1'b0; 
//R0 = 7 
#10; 

//MOV, R1, #2 
datapath_in = 16'sd2;  
//data_in = 2
writenum = 3'd1; 
//R1 = 2
#10;  


//ADD R2, R1, R0, LSL#1

write = 1'b0; 
readnum = 3'd1; 
loada = 1'b1; 
//reads the value stored in R1
#10; 


loada = 1'b0; 
readnum = 3'd0; 
loadb = 1'b1; 
//reads the valu stored in R0 
#10; 


loadb = 1'b0; 
shift = 2'b01; 
asel = 1'b0; 
bsel = 1'b0; 
ALUop = 2'b00; 
loadc = 1'b0; 
loads = 1'b0; 
#10; 
//LSL #1 on R0 
//R1 + R0 


loadc = 1'b1; 
vsel = 1'b0; 
writenum = 3'd2; 
write = 1'b1;
#10;


if(datapath_out !== 16'sd16) begin 
    $display("Error!"); 
    err = 1'b1; 
end 

//MOV R3, #42
//MOV R5, #13 
//ADD R2, R5, R3 

//MOV , R3, #42 
loadc = 1'b0; 
datapath_in = 16'sd42; 
vsel = 1'b1; 
writenum = 3'b011; 
write = 1'b1; 
#10; 

//MOV R5, #13 
datapath_in = 16'sd13; 
writenum = 3'b101; 
#10; 


//ADD R2, R5, R3
write = 1'b0; 
readnum = 3'b011; 
loadb = 1'b1; 
#10; 


loadb = 1'b0; 
loada = 1'b1; 
readnum = 3'b101; 
#10 


loada = 1'b1; 
shift = 2'b00; 
asel = 1'b0; 
bsel = 1'b0; 
ALUop = 2'b00; 
#10; 


loadc = 1'b1; 
vsel = 1'b0; 
writenum = 3'b010; 
write = 1'b1; 
loadc = 1'b1; 
#10; 

vsel = 1'b0; 
writenum = 3'b010; 
write = 1'b1; 
#10; 


if(datapath_out !== 16'sd55) begin 
    $display("Error!"); 
    err = 1'b1; 
end 

//MOV R7, R3 

write = 1'b0; 
readnum = 3'b011;
loadb = 1'b1; 
#10; 

shift = 2'b00; 
bsel = 1'b0; 
asel = 1'b1; 
ALUop = 2'b00; 
loadc = 1'b1; 
#10; 

vsel = 1'b0;
writenum = 3'b111; 
write = 1'b1; 
#10; 

if(datapath_out !== 16'sd42)begin 
    $display("Error!"); 
    err = 1'b1; 
end 


if(~err) $display("PASSED!"); 



end 


endmodule: datapath_tb 
