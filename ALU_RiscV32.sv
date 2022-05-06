module ALU_RiscV32 #(
  parameter ALU_LENGTH_WIDTH     = 32,
  parameter ALU_SEL_LENGTH_WIDTH = 4
)(
  input logic  [ALU_LENGTH_WIDTH-1:0]     i_alu1, i_alu2,
  input logic  [ALU_SEL_LENGTH_WIDTH-1:0] i_alu_sel,
  
  output logic [ALU_LENGTH_WIDTH-1:0]     o_alu
);

  always @(i_alu1, i_alu2) begin
    case(i_alu_sel)
      // ADD: addition
      4'b0000: o_alu <= i_alu1 + i_alu2;
      // SUB: substraction
      4'b0001: o_alu <= i_alu1 - i_alu2;
      // SLL: shift left logical
      4'b0010: o_alu <= i_alu1 << i_alu2;
      // SLT: set if less than
      4'b0011: begin
        if(i_alu1[31] != i_alu2[31]) begin
          if (i_alu1[31] > i_alu2[31]) o_alu <= 1;
          else o_alu <= 0;
        end else begin
          if(i_alu1 < i_alu2) o_alu <= 1;
          else o_alu <= 0;
        end
      end
      // SLTU: set less than, unsigned 
      4'b0100: o_alu <= i_alu1 < i_alu2;
      // XOR
      4'b0101: o_alu <= i_alu1 ^ i_alu2;
      // SRL: shift right logical
      4'b0110: o_alu <= i_alu1 >> i_alu2;
      // SRA: shift right arithmetic
      4'b0111: o_alu <= i_alu1 >>> i_alu2;
      // OR
      4'b1000: o_alu <= i_alu1 | i_alu2;
      // AND
      4'b1001: o_alu <= i_alu1 & i_alu2;
      default: o_alu <= i_alu2;
    endcase
  end

endmodule