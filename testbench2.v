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
    
    