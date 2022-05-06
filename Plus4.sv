module Plus4 #(
  parameter INS_WIDTH_LENGTH = 32
)(
  input  logic [INS_WIDTH_LENGTH-1:0] i_data,
  
  output logic [INS_WIDTH_LENGTH-1:0] o_data
);
  
  initial o_data = 0;

  always @(i_data) begin
    o_data = i_data + 4;
  end

endmodule