module tb_16bit_PPA;

    reg  [15:0] A, B;
    reg         Cin;
    wire [15:0] S;
    wire        Cout;

    prefix_adder_16bit uut (
        .A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout)
    );

    initial begin
        $monitor("Time=%0t | A=%h, B=%h, Cin=%b | S=%h, Cout=%b",
                 $time, A, B, Cin, S, Cout);
    
        A = 16'h0000; B = 16'h0000; Cin = 0; #10;
        A = 16'h0001; B = 16'h0002; Cin = 0; #10;
        A = 16'h0003; B = 16'h0003; Cin = 1; #10;
        A = 16'h00F0; B = 16'h00F0; Cin = 0; #10;
        A = 16'hFFFF; B = 16'h0001; Cin = 0; #10;
        A = 16'hFFFF; B = 16'hFFFF; Cin = 1; #10;

        $finish;
    end
endmodule