`timescale 1ns/1ps

module tb_four_bit_RCA_RCS;
    // Test signals
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] S;      // Sum (or result)
    wire       Cout;   // Carry out

    // Instantiate the 4-bit Ripple-Carry Adder
    four_bit_RCA_RCS dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );
    initial begin
        $dumpfile("dump.vcd");            
        $dumpvars(1, tb_four_bit_RCA_RCS);          
    end

    // Stimulus
    initial begin
        // Unsigned addition example: 3 + 5 = 8
        A   = 4'b0011; 
        B   = 4'b0101; 
        Cin = 0;       
        #10;
        $display("UNSIGNED ADD: A=%d + B=%d = S=%d (Cout=%b)",
                 A, B, S, Cout);

        // Signed addition example
        A   = 4'b1101;  // (-3 in 2's complement)
        B   = 4'b1011;  // (-5 in 2's complement)
        Cin = 0;
        #10;
        $display("SIGNED ADD: A=%d + B=%d = S=%d (Cout=%b)",
                 $signed(A), $signed(B), $signed(S), Cout);

        // Unsigned subtraction (simulate A - B using 2's complement)
        A   = 4'b1000; 
        B   = ~4'b0010; 
        Cin = 1;       
        #10;
        $display("UNSIGNED SUB: 8 - 2 => S=%d (Cout=%b)",
                 S, Cout);

        // Signed subtraction example
        A   = 4'b1100;     
        B   = ~4'b1110;    
        Cin = 1;           
        #10;
        $display("SIGNED SUB: A=%d - B=%d => S=%d (Cout=%b)",
                 $signed(4'b1100), $signed(4'b1110), $signed(S), Cout);

        #20;
        $finish;
    end
endmodule
