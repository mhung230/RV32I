module mux_2to1 #(
  parameter DATA_WIDTH = 32
)(
  input  logic [DATA_WIDTH-1:0] i_data1, i_data2,
  input  logic                  mux_sel,
  
  output logic [DATA_WIDTH-1:0] o_data
);

  assign o_data = mux_sel ? i_data2 : i_data1;

endmodule