module BranchComp_tb #(
  parameter DATA_WIDTH = 32
);
  logic [DATA_WIDTH-1:0] i_data1, i_data2;
  logic                  BranchOp;
  
  logic                  BrEq, BrLT;

  BranchComp  test (.*);
  
  initial begin
    i_data1 = 32'h02000000; i_data2 = 32'h02000000; BranchOp = 0; #5
    i_data1 = 32'h02000000; i_data2 = 32'h00000800; #5
    i_data1 = 32'h00000800; i_data2 = 32'h02000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h82000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h80000020; #5
    i_data1 = 32'h80000020; i_data2 = 32'h82000000; #5
    i_data1 = 32'h00000001; i_data2 = 32'h82000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h00000001; #5
    i_data1 = 'hx; i_data2 = 'hx; #5
    i_data1 = 32'h02000000; i_data2 = 32'h02000000; BranchOp = 1; #5
    i_data1 = 32'h02000000; i_data2 = 32'h00000800; #5
    i_data1 = 32'h00000800; i_data2 = 32'h02000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h82000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h80000020; #5
    i_data1 = 32'h80000020; i_data2 = 32'h82000000; #5
    i_data1 = 32'h00000001; i_data2 = 32'h82000000; #5
    i_data1 = 32'h82000000; i_data2 = 32'h00000001; #5
    #10 $finish;
  end

endmodule