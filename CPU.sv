module CPU #(
  parameter DATA_WIDTH = 32
)(
  input logic clk
);

  // Wires of Datapath
  logic [DATA_WIDTH-1:0] pc_in, pc_out, pc_plus4_out;
  logic [4:0]            rs1, rs2, rsd;
  logic [DATA_WIDTH-1:0] rs1_out, rs2_out;
  logic [DATA_WIDTH-1:0] imem_out;
  logic [DATA_WIDTH-1:7] imm_in;
  logic [DATA_WIDTH-1:0] imm_out;
  logic [DATA_WIDTH-1:0] alumux1_out, alumux2_out, aluout;
  logic [DATA_WIDTH-1:0] dmem_out;
  logic [DATA_WIDTH-1:0] wb_out;
  
  // Wires of Control Unit
  logic [DATA_WIDTH-1:0] inst;
  logic                  br_eq, br_lt;
  
  logic                  pcmux_sel;
  logic [2:0]            imm_sel;
  logic                  regfilemux_sel;
  logic                  cmpop;
  logic                  alumux1_sel,alumux2_sel;
  logic [3:0]            aluop;
  logic                  dmem_sel;
  logic [1:0]            wbmux_sel;

  

  assign rs1 = inst[19:5];
  assign rs2 = inst[24:20];
  assign rsd = inst[11:7];
  
  assign imm_in = inst[31:7];

  // DATAPATH 
  // IF: Instruction Fetch
  mux_2to1 PCmux(
    .i_data1 (pc_plus4_out), .i_data2 (aluout), .mux_sel (pcmux_sel),
    .o_data  (pc_in)
  );
  
  ProgramCounter PC(
    .i_data (pc_in), .clk (clk),
    .o_data (pc_out)
  );
  
  Plus4 PCPlus4(
    .i_data (pc_out),
    .o_data (pc_plus4_out)
  );

  IMem  IMEM(
  .i_data (pc_out),
  .o_data (inst)
  );
  
  // ID: Instruction Decode
  RegisterFile RegisterBank(
    .Read1(rs1), .Read2(rs2), .WriteReg(rsd), .WriteData(wb_out), .RegWrite(regfilemux_sel), .clk(clk),
    .Data1(rs1_out), .Data2(rs2_out)
  );
  
  ImmGen immgen(
    .i_Imm (imm_in), .ImmSel(imm_sel), 
    .o_Imm (imm_out)
  );
  
  // EX: Excute
  
  mux_2to1 ALUmux1(
    .i_data1 (rs1_out), .i_data2 (pc_out), .mux_sel (alumux1_sel),
    .o_data  (alumux1_out)
  );
  
  mux_2to1 ALUmux2(
    .i_data1 (rs2_out), .i_data2 (imm_out), .mux_sel (alumux2_sel),
    .o_data  (alumux2_out)
  );
  
  ALU_RiscV32 ALU(
    .i_alu1(alumux1_out), .i_alu2(alumux2_out), .i_alu_sel(aluop),
    .o_alu(aluout)
  );
  
  Comparater BranchComp(
    .i_data1 (rs1_out), .i_data2(rs2_out), .BranchOp(cmpop),
    .BrEq(br_eq), .BrLT(br_lt)
  );
  
  //MEM: Memory Access
  DMem DMEM(
    .DataW(rs2_out), .Addr(aluout), .MemRW(dmem_sel), .clk(clk),
    .DataR(dmem_out)
  );
  
  mux_3to1 Wbmux(
    .i_data1(dmem_out), .i_data2(aluout), .i_data3(pc_plus4_out), .mux_sel(wbmux_sel),
    .o_data (wb_out)
);

  // WB: Register Write
  
  
  //CONTROL UNIT
  ControlUnit control(
    .Inst(inst), .BrEq(br_eq), .BrLT(br_lt),
    .PCSel(pcmux_sel), .ImmSel(imm_sel), .RegWEn(regfilemux_sel), 
    .BrUn(cmpop), .BSel(alumux2_sel), .ASel(alumux1_sel),
    .ALUSel(aluop), .MemRW(dmem_sel), .WBSel(wbmux_sel)
);
  
endmodule