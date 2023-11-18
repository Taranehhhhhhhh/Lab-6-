module shifter_tb(); 

reg err, clk; 
reg [15:0] in;
reg [1:0] shift;
wire [15:0] sout;


shifter DUT(.in(in), .shift(shift), .sout(sout)); 


initial begin 
    clk = 0; #5; 
    forever begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end 
end 

initial begin 

    //testing the example given in the lab manual 
    in = 16'sb1111000011001111; 
    shift = 2'b00; 
    err = 1'b0; 
    #10; 

    if( sout !== 16'sb1111000011001111) begin 
        $display("Error!"); 
        err = 1'b1; 
    end 

    shift = 2'b01; 
    #10; 

    if( sout !== 16'sb1110000110011110) begin 
        $display("Error! Failed the left shift operation."); 
        err = 1'b1; 
    end 

    shift = 2'b10; 
    #10; 


    if( sout !== 16'sb0111100001100111) begin 
        $display("Error! Failed the right shift operation."); 
        err = 1'b1; 
    end 

    shift = 2'b11; 
    #10; 

    if( sout !== 16'sb1111100001100111) begin 
        $display("Error! Failed the signed right shift operation."); 
        err = 1'b1; 
    end 

    //testing another number 

    in = 16'sb1111000011010000; 
    shift = 2'b00; 
    #10;

    //no shift 

    if (sout !== 16'sb1111000011010000) begin
        $display("Error!"); 
        err = 1'b0; 
    end 

    shift = 2'b01;  
    #10;

    //logical shift left, LSB is 0 

    if( sout !== 16'sb1110000110100000) begin 
        $display("Error! Could perform the logical shift left.");
        err = 1'b1; 
    end 

    shift = 2'b10;  
    #10;

    //logical shift right, MSB is 0 

    if( sout !== 16'sb0111100001101000) begin 
        $display("Error! Could not perform the logical right."); 
        err = 1'b1; 
    end 

    shift = 2'b11; 
    #10;

    //logical shift right, MSB is a copy of in[15]

    if( sout !== 16'sb1111100001101000) begin 
        $display("Error! Could not perform the logical shift right with MSb beign a copy of in[15]."); 
        err = 1'b1; 
    end 

    if(~err) $display("PASSED!"); 

    $stop; 


end 


endmodule: shifter_tb 