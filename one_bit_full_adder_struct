module one_bit_full_adder_struct(
    input  A, B, Cin,
    output S, Cout
);
    wire x1;    // intermediate wire for A ^ B
    wire w1, w2, w3; // wires for partial carry logic

    // SUM = A ^ B ^ Cin
    xor (x1, A, B);
    xor (S, x1, Cin);

    // CARRY-OUT = (A & B) | (B & Cin) | (Cin & A)
    and (w1, A, B);
    and (w2, B, Cin);
    and (w3, Cin, A);
    or  (Cout, w1, w2, w3);
endmodule
