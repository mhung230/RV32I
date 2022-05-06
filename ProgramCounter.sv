module ProgramCounter #(
  parameter PC_WIDTH_LENGTH = 32
)(
  input  logic [PC_WIDTH_LENGTH-1:0] i_data,
  input  logic                       clk,
  
  output logic [PC_WIDTH_LENGTH-1:0] o_data
);

  initial o_data = 0;

  always @(posedge clk) begin
   o_data <= i_data;
  end

endmodule