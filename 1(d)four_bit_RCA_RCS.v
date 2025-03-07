module four_bit_subtractor(
    input      [3:0] A, B,
    output     [3:0] Diff,
    output           BorrowOut
);
    wire [3:0] B_inverted;
    wire       c1, c2, c3;  // internal carries
    
    assign B_inverted = ~B; // bitwise inversion of B

    // Now we just do A + (inverted B) + 1
    one_bit_full_adder_struct fa0 (
        .A(A[0]), .B(B_inverted[0]), .Cin(1'b1),
        .S(Diff[0]), .Cout(c1)
    );
    one_bit_full_adder_struct fa1 (
        .A(A[1]), .B(B_inverted[1]), .Cin(c1),
        .S(Diff[1]), .Cout(c2)
    );
    one_bit_full_adder_struct fa2 (
        .A(A[2]), .B(B_inverted[2]), .Cin(c2),
        .S(Diff[2]), .Cout(c3)
    );
    one_bit_full_adder_struct fa3 (
        .A(A[3]), .B(B_inverted[3]), .Cin(c3),
        .S(Diff[3]), .Cout(BorrowOut)
    );
endmodule
module four_bit_RCA_RCS(
    input      [3:0] A, B,
    input            Cin,
    output     [3:0] S,
    output           Cout
);
    // Internal carry wires
    wire c1, c2, c3;

    // Instantiate 1-bit full adder for each bit
    one_bit_full_adder_struct fa0 (
        .A(A[0]), .B(B[0]), .Cin(Cin), 
        .S(S[0]), .Cout(c1)
    );

    one_bit_full_adder_struct fa1 (
        .A(A[1]), .B(B[1]), .Cin(c1), 
        .S(S[1]), .Cout(c2)
    );

    one_bit_full_adder_struct fa2 (
        .A(A[2]), .B(B[2]), .Cin(c2), 
        .S(S[2]), .Cout(c3)
    );

    one_bit_full_adder_struct fa3 (
        .A(A[3]), .B(B[3]), .Cin(c3), 
        .S(S[3]), .Cout(Cout)
    );
endmodule

module one_bit_full_adder_struct(
    input  A, B, Cin,
    output S, Cout
);
    // Intermediate signals
    wire x1;
    wire w1, w2, w3;

    // Compute sum: S = A XOR B XOR Cin
    xor (x1, A, B);
    xor (S, x1, Cin);

    // Compute carry out: Cout = (A & B) | (B & Cin) | (Cin & A)
    and (w1, A, B);
    and (w2, B, Cin);
    and (w3, Cin, A);
    or  (Cout, w1, w2, w3);
endmodule

