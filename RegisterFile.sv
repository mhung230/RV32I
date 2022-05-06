module RegisterFile #(
  parameter REGISTER_WIDTH_LENGTH = 32,
  parameter ADDRESS_WIDTH_LENGTH  = 5
)(
  input  logic [ADDRESS_WIDTH_LENGTH-1:0]  Read1, Read2, WriteReg,
  input  logic [REGISTER_WIDTH_LENGTH-1:0] WriteData,
  input  logic                             RegWrite,
  input  logic                             clk,
  
  output logic [REGISTER_WIDTH_LENGTH-1:0] Data1, Data2
);

  logic [REGISTER_WIDTH_LENGTH-1:0] RF [0:REGISTER_WIDTH_LENGTH-1];
  
  integer i;
  
  initial begin
    Data1 = 0;
    Data2 = 0;
    for (i = 1; i < REGISTER_WIDTH_LENGTH; i++) RF[i] = 0;
  end
  
  always @(posedge clk) begin
    Data1 <= RF[Read1];
    Data2 <= RF[Read2];
    if (RegWrite) RF[WriteReg] <= WriteData;
  end
  
endmodule