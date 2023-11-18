module ALU_tb();

reg [15:0] Ain, Bin;
reg [1:0] ALUop;
wire [15:0] out;
wire Z;
reg err, clk; 

ALU DUT(.Ain(Ain), .Bin(Bin), .ALUop(ALUop), .out(out), .Z(Z)); 

initial begin 
    clk = 0; #5; 
    forever begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end 
end 

initial begin 
    //testing the addition operation 
    Ain = 16'sd2; 
    Bin = 16'sd3; 
    ALUop = 2'b00; 
    err = 1'b0; 
    #10; 

    if(out !== 16'sd5) begin 
        $display("Error!Could not add 2 + 3 successfully."); 
        err = 1'b1; 
    end 


    Ain = 16'sd4; 
    Bin = 16'sd6; 
    ALUop = 2'b00; 
    #10; 

    if(out !== 16'sd10) begin 
        $display("Error! Could not add 4 + 6 successfully."); 
        err = 1'b1; 
    end 

    //testing the subtrcation operation 

    Ain = 16'sd7; 
    Bin = 16'sd2; 
    ALUop = 2'b01;  
    #10; 


    if(out !== 16'sd5) begin 
        $display("Error! Could not subtract 7 - 2."); 
        err = 1'b1; 
    end 

 

    Ain = 16'sd10; 
    Bin = 16'sd5; 
    ALUop = 2'b01; 
    #10; 


    if(out !== 16'sd5) begin 
        $display("Error! Could not subtract 10 - 5."); 
        err = 1'b1; 
    end 

    //testing the bitwise AND operation 


    Ain = 16'sd8; 
    Bin = 16'sd7; 
    ALUop = 2'b10;  
    #10; 

    if(out !== 16'sd0) begin
        $display("Error! Could not perform the bitwise AND operation on 8 and 7."); 
        err = 1'b1; 
    end 

    if( Z !== 1'b1) begin 
        $display("Error! Status register is not working."); 
        err = 1'b1; 
    end 

    //testing the NOT operation 

    Ain = 16'sd0; 
    Bin = 16'sd8; 
    ALUop = 2'b11; 
    #10; 

    if(out !== 16'sb1111111111110111) begin 
        $display("Error! COuld not person the NOT operation on 8."); 
        err = 1'b1; 
    end 

    if(~err) $display("PASSED!"); 

    $stop; 


end 


endmodule: ALU_tb 