module DMem #(
  parameter DATA_WIDTH_LENGTH = 32,
  parameter MEM_WIDTH_LENGTH  = 32,
  parameter MEM_DEPTH_LENGTH   = 1 << 18
)(
  input  logic [DATA_WIDTH_LENGTH-1:0] DataW,
  input  logic [MEM_WIDTH_LENGTH-1:0]  Addr,
  input  logic                         MemRW,
  input  logic                         clk,
  
  output logic [DATA_WIDTH_LENGTH-1:0] DataR
);

  logic [17:0] pWord;
  logic [1:0]  pByte;

  logic [DATA_WIDTH_LENGTH-1:0] DMEM [0:MEM_DEPTH_LENGTH-1];
  integer i;
  
  assign pWord = Addr[19:2];
  assign pByte = Addr[1:0];

  always @(posedge clk) begin
  #5
    if (!MemRW) begin
      if (pByte == 2'b00) DataR <= DMEM[pWord];
    end else begin
      if (pByte == 2'b00) DMEM[pWord] <= DataW;
    end
  end
endmodule