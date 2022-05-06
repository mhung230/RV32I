module ControlUnit #(
  parameter DATA_WIDTH = 32
)(
  input  logic [DATA_WIDTH-1:0] Inst,
  input  logic                  BrEq, BrLT,
  
  output logic       PCSel,
  output logic [2:0] ImmSel,
  output logic       RegWEn,
  output logic       BrUn,
  output logic       BSel,
  output logic       ASel,
  output logic [3:0] ALUSel,
  output logic       MemRW,
  output logic [1:0] WBSel
);
  
  logic [10:0] in;
  logic [14:0] out;

  always @(Inst, BrEq, BrLT) begin
    in  = {Inst[30], Inst[14:12], Inst[6:2], BrEq, BrLT};
    case(in)
      //R-type
      //ADD
      11'b0_000_01100_x_x: out = 15'b0_xxx_1_x_0_0_0000_0_01;
      //SUB
      11'b1_000_01100_x_x: out = 15'b0_xxx_1_x_0_0_0001_0_01;
      //SLL
      11'b0_001_01100_x_x: out = 15'b0_xxx_1_x_0_0_0010_0_01;
      //SLT
      11'b0_010_01100_x_x: out = 15'b0_xxx_1_x_0_0_0011_0_01;
      //SLTU
      11'b0_011_01100_x_x: out = 15'b0_xxx_1_x_0_0_0100_0_01;
      //XOR
      11'b0_100_01100_x_x: out = 15'b0_xxx_1_x_0_0_0101_0_01;
      //SRL
      11'b0_101_01100_x_x: out = 15'b0_xxx_1_x_0_0_0110_0_01;
      //SRA
      11'b1_101_01100_x_x: out = 15'b0_xxx_1_x_0_0_0111_0_01;
      //OR
      11'b0_110_01100_x_x: out = 15'b0_xxx_1_x_0_0_1000_0_01;
      //AND
      11'b0_111_01100_x_x: out = 15'b0_xxx_1_x_0_0_1001_0_01;
      
      //I-Type
      //ADDI
      11'bx_000_00100_x_x: out = 15'b0_000_1_x_1_0_0000_0_01;
      //SLTI
      11'bx_010_00100_x_x: out = 15'b0_000_1_x_1_0_0011_0_01;
      //SLTIU
      11'bx_011_00100_x_x: out = 15'b0_001_1_x_1_0_0100_0_01;
      //XORI
      11'bx_100_00100_x_x: out = 15'b0_000_1_x_1_0_0101_0_01;
      //ORI
      11'bx_110_00100_x_x: out = 15'b0_000_1_x_1_0_1000_0_01;
      //ANDI
      11'bx_111_00100_x_x: out = 15'b0_000_1_x_1_0_1001_0_01;
      //SLLI
      11'b0_001_00100_x_x: out = 15'b0_000_1_x_1_0_0010_0_01;
      //SRLI
      11'b0_101_00100_x_x: out = 15'b0_000_1_x_1_0_0110_0_01;
      //SRAI
      11'b1_101_00100_x_x: out = 15'b0_000_1_x_1_0_0111_0_01;
      //LB
      11'bx_000_00000_x_x: out = 15'b0_000_1_x_1_0_0000_0_00;
      //LH
      11'bx_010_00000_x_x: out = 15'b0_000_1_x_1_0_0000_0_00;
      //LW
      11'bx_011_00000_x_x: out = 15'b0_000_1_x_1_0_0000_0_00;
      //LBU
      11'bx_100_00000_x_x: out = 15'b0_001_1_x_1_0_0000_0_00;
      //LHU
      11'bx_110_00000_x_x: out = 15'b0_001_1_x_1_0_0000_0_00;
      
      //S-Type
      //SB
      11'bx_000_01000_x_x: out = 15'b0_010_1_x_1_0_0000_0_xx;
      //SH
      11'bx_001_01000_x_x: out = 15'b0_010_1_x_1_0_0000_0_xx;
      //SW
      11'bx_010_01000_x_x: out = 15'b0_010_1_x_1_0_0000_0_xx;
      
      //B-Type
      //BEQ
      11'bx_000_11000_1_x: out = 15'b1_011_0_x_1_1_0000_0_xx;
      //BNE
      11'bx_001_11000_0_x: out = 15'b1_011_0_x_1_1_0000_0_xx;
      //BLT
      11'bx_100_11000_x_1: out = 15'b1_011_0_0_1_1_0000_0_xx;
      //BGE
      11'bx_101_11000_x_0: out = 15'b1_011_0_0_1_1_0000_0_xx;
      //BLTU
      11'bx_100_11000_x_1: out = 15'b1_011_0_1_1_1_0000_0_xx;
      //BGE
      11'bx_101_11000_x_0: out = 15'b1_011_0_1_1_1_0000_0_xx;
      
      //U-Type
      //LUI
      11'bx_xxx_01101_x_x: out = 15'b0_100_1_x_1_x_xxxx_0_01;
      //AUIPC
      11'bx_xxx_00101_x_x: out = 15'b0_100_1_x_1_1_0000_0_01;
      
      //J-Type
      //JAL
      11'bx_xxx_11011_x_x: out = 15'b1_101_1_x_1_1_0000_0_10;
      //JARL
      11'bx_000_11001_x_x: out = 15'b1_000_1_x_1_0_0000_0_10;      
    endcase
    
    {PCSel, ImmSel[2:0], BrUn, BSel, ASel, ALUSel[3:0], MemRW, RegWEn, WBSel[1:0]} = out;
    
  end
  
endmodule