module tb_four_bit_RCA_RCS;
    // Test signals
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] S;      // Sum (or result)
    wire       Cout;   // Carry out

    four_bit_RCA_RCS dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    initial begin
        // Unsigned addition example
        A   = 4'b0011; // 3
        B   = 4'b0101; // 5
        Cin = 0;       // Add with carry-in = 0
        #10; // wait a bit
        $display("UNSIGNED ADD: A=%d + B=%d = S=%d (Cout=%b)",
                 A, B, S, Cout);

        // Signed addition example

        A   = 4'b1101;
        B   = 4'b1011;
        Cin = 0;
        #10;
        $display("SIGNED ADD: A=%d + B=%d = S=%d (Cout=%b)",
                 $signed(A), $signed(B), $signed(S), Cout);

        // Unsigned subtraction (A - B)

        A   = 4'b1000; // 8
        B   = ~4'b0010;// invert 2 => 1101
        Cin = 1;       // plus 1
        #10;
        $display("UNSIGNED SUB: 8 - 2 => S=%d (Cout=%b)",
                 S, Cout);

        // Signed subtraction example

        A   = 4'b1100;     // -4
        B   = ~4'b1110;    // invert -2 => 0001
        Cin = 1;           
        #10;
        $display("SIGNED SUB: A=%d - B=%d => S=%d (Cout=%b)",
                 $signed(4'b1100), $signed(4'b1110), $signed(S), Cout);

        #10 $stop;
    end
endmodule
