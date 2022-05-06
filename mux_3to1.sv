module mux_3to1 #(
  parameter DATA_WIDTH = 32
)(
  input  logic [DATA_WIDTH-1:0] i_data1, i_data2, i_data3,
  input  logic [1:0]            mux_sel,
  
  output logic [DATA_WIDTH-1:0] o_data
);

  always @(i_data1, i_data2, i_data3, mux_sel) begin
    case (mux_sel)
      2'b00: o_data = i_data1;
      2'b01: o_data = i_data2;
      2'b10: o_data = i_data3;
    endcase
  end

endmodule