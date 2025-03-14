module prefix_adder_16bit (
    input  [15:0] A, B,
    input         Cin,
    output [15:0] S,
    output        Cout
);
    wire [15:0] P, G;  
    wire [15:0] C;     

    
    assign P = A | B; 
    assign G = A & B; 

    
   assign C[0]  = G[0]  | (P[0]  & Cin);
    assign C[1]  = G[1]  | (P[1]  & C[0]);
    assign C[2]  = G[2]  | (P[2]  & C[1]);
    assign C[3]  = G[3]  | (P[3]  & C[2]);
    assign C[4]  = G[4]  | (P[4]  & C[3]);
    assign C[5]  = G[5]  | (P[5]  & C[4]);
    assign C[6]  = G[6]  | (P[6]  & C[5]);
    assign C[7]  = G[7]  | (P[7]  & C[6]);
    assign C[8]  = G[8]  | (P[8]  & C[7]);
    assign C[9]  = G[9]  | (P[9]  & C[8]);
    assign C[10] = G[10] | (P[10] & C[9]);
    assign C[11] = G[11] | (P[11] & C[10]);
    assign C[12] = G[12] | (P[12] & C[11]);
    assign C[13] = G[13] | (P[13] & C[12]);
    assign C[14] = G[14] | (P[14] & C[13]);
    assign C[15] = G[15] | (P[15] & C[14]);
    assign Cout = G[15] | (P[15] & C[15]);

    assign S[0]  = (A[0]  ^ B[0])  ^ Cin;
    assign S[1]  = (A[1]  ^ B[1])  ^ C[0];
    assign S[2]  = (A[2]  ^ B[2])  ^ C[1];
    assign S[3]  = (A[3]  ^ B[3])  ^ C[2];
    assign S[4]  = (A[4]  ^ B[4])  ^ C[3];
    assign S[5]  = (A[5]  ^ B[5])  ^ C[4];
    assign S[6]  = (A[6]  ^ B[6])  ^ C[5];
    assign S[7]  = (A[7]  ^ B[7])  ^ C[6];
    assign S[8]  = (A[8]  ^ B[8])  ^ C[7];
    assign S[9]  = (A[9]  ^ B[9])  ^ C[8];
    assign S[10] = (A[10] ^ B[10]) ^ C[9];
    assign S[11] = (A[11] ^ B[11]) ^ C[10];
    assign S[12] = (A[12] ^ B[12]) ^ C[11];
    assign S[13] = (A[13] ^ B[13]) ^ C[12];
    assign S[14] = (A[14] ^ B[14]) ^ C[13];
    assign S[15] = (A[15] ^ B[15]) ^ C[14];
    

endmodule