
// 4-bit Ripple-Carry Adder (Problem 1)

module four_bit_RCA (
    input  [3:0] A, B,
    input        Cin,
    output [3:0] S,
    output       Cout
);
    // Simple 4-bit addition
    assign {Cout, S} = A + B + Cin;
endmodule


// 32-bit Carry Lookahead Adder (CLA)

module CLA(A, B, Cin, S, Cout);
    input  [31:0] A, B;
    input         Cin;
    output [31:0] S;
    output        Cout;

    // 8 "blocks" of 4 bits each
    // G[i], P[i] = block-level generate and propagate
    wire [7:0] G, P;
    // C[i] are the carry signals at block boundaries
    // C[0] is the global Cin, C[8] is the final carry out
    wire [8:0] C;
    assign C[0] = Cin;

    // Generate 8 blocks in a loop
    genvar i;
    generate
      for (i = 0; i < 8; i = i + 1) begin : BLOCKS
        // Sliced 4 bits of A and B for this block
        wire [3:0] a_block, b_block;
        wire [3:0] sum_block;
        wire [3:0] g_bit, p_bit;  

        // Extract bits [4*i+3 : 4*i]
        assign a_block = A[4*i+3 : 4*i];
        assign b_block = B[4*i+3 : 4*i];


        assign g_bit[0] = a_block[0] & b_block[0];
        assign g_bit[1] = a_block[1] & b_block[1];
        assign g_bit[2] = a_block[2] & b_block[2];
        assign g_bit[3] = a_block[3] & b_block[3];

        assign p_bit[0] = a_block[0] ^ b_block[0];
        assign p_bit[1] = a_block[1] ^ b_block[1];
        assign p_bit[2] = a_block[2] ^ b_block[2];
        assign p_bit[3] = a_block[3] ^ b_block[3];

        //    G[i] = g3 + (p3 & g2) + (p3 & p2 & g1) + (p3 & p2 & p1 & g0)
        //    P[i] = p3 & p2 & p1 & p0

        wire p3g2, p3p2g1, p3p2p1g0;
        wire p3p2, p3p2p1;

        and (p3g2,    p_bit[3], g_bit[2]);
        and (p3p2,    p_bit[3], p_bit[2]);
        and (p3p2g1,  p3p2,     g_bit[1]);
        and (p3p2p1,  p3p2,     p_bit[1]);
        and (p3p2p1g0, p3p2p1,  g_bit[0]);

        wire temp_or1, temp_or2;
        or  (temp_or1, g_bit[3], p3g2);
        or  (temp_or2, temp_or1, p3p2g1);
        or  (G[i],     temp_or2, p3p2p1g0);

        // P[i] = p3 & p2 & p1 & p0
        wire t1, t2;
        and (t1, p_bit[3], p_bit[2]);
        and (t2, t1, p_bit[1]);
        and (P[i], t2, p_bit[0]);

        four_bit_RCA rca_block (
            .A(a_block),
            .B(b_block),
            .Cin(C[i]),     
            .S(sum_block),
            .Cout()          
        );

        // Place the 4-bit sum into the correct slice of S
        assign S[4*i+3 : 4*i] = sum_block;

    
        // 4) Carry-out of this block (for next block):
        //    C[i+1] = G[i] + (P[i] & C[i])
        wire p_i_and_c_i;
        and (p_i_and_c_i, P[i], C[i]);
        or  (C[i+1], G[i], p_i_and_c_i);
      end
    endgenerate

    assign Cout = C[8];
endmodule

