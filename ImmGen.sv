module ImmGen(
  input  logic [31:7] i_Imm,
  input  logic [2:0]  ImmSel,
  
  output logic [31:0] o_Imm
);

  always @(i_Imm, ImmSel) begin
    case(ImmSel)
      // I-immediate
      3'b000: begin
        o_Imm[0]     = i_Imm[20];
        o_Imm[4:1]   = i_Imm[24:21];
        o_Imm[10:5]  = i_Imm[30:25];
        o_Imm[31:11] = {21{i_Imm[31]}};
      end
      
      // I-immediate unsigned
      3'b001: begin
        o_Imm[0]     = i_Imm[20];
        o_Imm[4:1]   = i_Imm[24:21];
        o_Imm[11:5]  = i_Imm[31:25];
        o_Imm[31:12] = {20{1'b0}};
      end
      
      // S-immediate
      3'b010: begin
        o_Imm[0]     = i_Imm[7];
        o_Imm[4:1]   = i_Imm[11:8];
        o_Imm[10:5]  = i_Imm[30:25];
        o_Imm[31:11] = {21{i_Imm[31]}};
      end
      
      // B-immediate
      3'b011: begin
        o_Imm[0]     = 0;
        o_Imm[4:1]   = i_Imm[11:8];
        o_Imm[10:5]  = i_Imm[30:25];
        o_Imm[11]    = i_Imm[7];
        o_Imm[31:12] = {20{i_Imm[31]}};
      end
      
      // U-immediate
      3'b100: begin
        o_Imm[11:0]  = 0;
        o_Imm[19:12] = i_Imm[19:12];
        o_Imm[30:20] = i_Imm[30:20];
        o_Imm[31]    = i_Imm[31];
      end
      
      // J-immediate
      3'b101: begin
        o_Imm[0]     = 0;
        o_Imm[4:1]   = i_Imm[24:21];
        o_Imm[10:5]  = i_Imm[30:25];
        o_Imm[11]    = i_Imm[20];
        o_Imm[19:12] = i_Imm[19:12];
        o_Imm[31:20] = {12{i_Imm[31]}};
      end
      
      default: o_Imm = 32'h00000000;
    endcase
  end

endmodule