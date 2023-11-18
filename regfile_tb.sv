module regfile_tb(); 

reg [15:0] data_in;
reg [2:0] writenum, readnum;
reg write, clk, err; 
wire [15:0] data_out;


regfile DUT(.data_in(data_in), .writenum(writenum), .readnum(readnum), .write(write), .clk(clk), .data_out(data_out)); 


initial begin 
    clk = 0; #5; 
    forever begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end 
end 

//MOV R1, #5; 
//MOV R2, #7; 
//MOV R3, #3; 
//MOV R4, #2;
//MOV R5, #6; 
//MOV R6, #12; 
//MOV R7, #10; 
//MOV R0, #11; 


initial begin 

    //MOV R1 , #5 
    data_in = 16'sd5; 
    writenum = 3'b001; 
    err = 1'b0;
    write = 1'b1; 
    #10; 


    //MOV R2, #7 

    data_in = 16'sd7; 
    writenum = 3'b010; 
    #10; 


    //MOV R3, #3

    data_in = 16'sd3; 
    writenum = 3'b011;  
    #10; 

    //MOV R4, #2

    data_in = 16'sd2; 
    writenum = 3'b100; 
    #10; 

    //MOV R5, #6; 

    data_in = 16'sd6; 
    writenum = 3'b101; 
    #10; 

    //MOV R6, #12; 

    data_in = 16'sd12; 
    writenum = 3'b110; 
    #10; 

    //MOV R7, #10; 

    data_in = 16'sd10; 
    writenum = 3'b111; 
    #10; 

    //MOV R0, #11

    data_in = 16'sd11; 
    writenum = 3'b000; 
    #10; 

    //Now we will read the registers

    //read R1

    readnum = 3'b001; 
    #10; 

    if(data_out !== 16'sd5) begin 
        $display("Error reading R1!"); 
        err = 1'b1; 
    end 

    //read R2 
    readnum = 3'b010;
    #10; 

    if(data_out !== 16'sd7) begin 
        $display("Error reading R2!"); 
        err = 1'b1; 
    end 


    //read R3 
    readnum = 3'b011; 
    #10; 

    if(data_out !== 16'sd3) begin 
        $display("Error reading R3!"); 
        err = 1'b1; 
    end 


    //read R4 
    readnum = 3'b100; 
    #10; 

    if(data_out !== 16'sd2) begin 
        $display("Error reading R4!"); 
        err = 1'b1; 
    end 

    //read R5 

    readnum = 3'b101; 
    #10; 

    if(data_out !== 16'sd6)begin 
        $display("Error reading R5!"); 
        err = 1'b1; 
    end 

    //read R6 

    readnum = 3'b110; 
    #10; 

    if(data_out !== 16'sd12)begin 
        $display("Error reading R6!"); 
        err = 1'b1; 
    end 

    //read R7 

    readnum = 3'b111; 
    #10; 

    if(data_out !== 16'sd10)begin 
        $display("Error reading R7!"); 
        err = 1'b1; 
    end 

    //read R0 

    readnum = 3'b000; 
    #10; 

    if(data_out !== 16'sd11)begin 
        $display("Error reading R0!"); 
        err = 1'b1; 
    end 
    
    if(~err) $display("PASSED!"); 

end 

    $stop; 



endmodule: regfile_tb 