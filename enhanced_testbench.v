module tb_cla_32bit;
  reg  [31:0] A, B;
  reg         Cin;
  wire [31:0] S;
  wire        Cout;

  // Instantiate 32-bit CLA
  CLA dut (
    .A   (A),
    .B   (B),
    .Cin (Cin),
    .S   (S),
    .Cout(Cout)
  );

  initial begin
    // Test #1: Small numbers
    A = 32'h00000003; // 3
    B = 32'h00000005; // 5
    Cin = 0;
    #10;
    $display("Test1: A=%d, B=%d, Cin=%b => S=%d, Cout=%b", A, B, Cin, S, Cout);

    // Test #2: Larger number
    A = 32'hFFFFFFFF; // 4294967295 (all 1's)
    B = 32'h00000001; // 1
    Cin = 0;
    #10;
    $display("Test2: A=%h, B=%h, Cin=%b => S=%h, Cout=%b", A, B, Cin, S, Cout);

    // Test #3
    A = 32'h0000ABCD; 
    B = 32'h00001234; 
    Cin = 1;
    #10;
    $display("Test3: A=%h, B=%h, Cin=%b => S=%h, Cout=%b", A, B, Cin, S, Cout);

    #10 $finish;
  end
endmodule

