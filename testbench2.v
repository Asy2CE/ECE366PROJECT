module tb_16bit_PPA;

    reg  [15:0] A, B;
    reg  Cin;
    wire [15:0] S;
    wire Cout;

    prefix_adder_16bit uut (
        .A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout)
    );

    initial begin
        A = 16'h1234; B = 16'h5678; Cin = 0; #10;
        A = 16'hFFFF; B = 16'h0001; Cin = 0; #10;
        A = 16'hAAAA; B = 16'h5555; Cin = 1; #10;
        A = 16'h8000; B = 16'h8000; Cin = 1; #10;
        A = 16'h0000; B = 16'h0000; Cin = 0; #10;
        $stop;
        
    end
endmodule