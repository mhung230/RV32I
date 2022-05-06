module IMem #(
  parameter INST_WIDTH_LENGTH = 32,
  parameter DATA_WIDTH_LENGTH = 32,
  parameter MEM_WIDTH_LENGTH  = 32,
  parameter MEM_DEPTH_LENGTH  = 1 << 18
)(
  input  logic [DATA_WIDTH_LENGTH-1:0] i_data,
  
  output logic [INST_WIDTH_LENGTH-1:0] o_data
);

  logic [MEM_WIDTH_LENGTH-1:0] IMEM [0:MEM_DEPTH_LENGTH-1];
  
  logic [17:0] pWord;
  logic [1:0]  pByte;
  
  assign pWord = i_data[19:2];
  assign pByte = i_data[1:0];
  
  initial begin
    $readmemh("D:/Documents/Project/Verilog/RISC-V/Hung/Datapath/R-type.txt",IMEM);
  end
  
  always @(i_data) begin
    if (pByte == 2'b00) o_data <= IMEM[pWord];
    else o_data <= 'hz;
  end

endmodule