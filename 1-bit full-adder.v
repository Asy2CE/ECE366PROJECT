module one_bit_full_adder(A, B, Cin, S, Cout);
    input  A, B, Cin;
    output reg S, Cout;
    
        assign {Cout, S} = A + B + Cin;
endmodule
