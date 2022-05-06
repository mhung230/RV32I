module CPU_tb;
  logic clk;
  
  CPU cpu_tb(.*);
  
  always #5 clk <= ~clk;
  
  initial begin
    clk = 0;
  end

endmodule