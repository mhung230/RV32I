module Comparater #(
  parameter DATA_WIDTH = 32
)(
  input  logic [DATA_WIDTH-1:0] i_data1, i_data2,
  input  logic                  BranchOp,
  
  output logic                  BrEq, BrLT
);

  logic [1:0] Signed;

  always @(i_data1, i_data2) begin
    case (BranchOp)
      // Unsigned
      1'b0: begin
        if (i_data1 == i_data2) begin
          BrEq = 1'b1;
          BrLT = 1'b0;
        end else begin
          BrEq = 1'b0;
          if (i_data1 < i_data2) BrLT = 1'b1;
          else BrLT = 1'b0;
        end
       end
       
       // Signed
       1'b1: begin
        if (i_data1 == i_data2) begin
          BrEq = 1'b1;
          BrLT = 1'b0;
        end else begin
          BrEq = 1'b0;
          case ({i_data1[31],i_data2[31]})
            2'b00: BrLT = (i_data1[30:1] < i_data2[30:1]) ? 1'b1 : 1'b0;
            2'b11: BrLT = (i_data1[30:1] < i_data2[30:1]) ? 1'b1 : 1'b0;
            2'b01: BrLT = 1'b0;
            2'b10: BrLT = 1'b1;
          endcase
        end
       end
     endcase
  end

endmodule