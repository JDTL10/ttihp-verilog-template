// ===============================
// tt_um_JDTL10.v (top)
// ===============================
module tt_um_JDTL10 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Inputs
    wire [2:0] OpSel = ui_in[7:5];    // Operación
    wire [6:0] B = ui_in[6:0];        // B operand
    wire [6:0] A = uio_in[6:0];       // A operand

    // Outputs
    wire [6:0] Result;
    wire CarryOut_ALU, Overflow_ALU, Zero, Negative;

    // ALU instantiation
    ALU alu_inst (
        .A(A),
        .B(B),
        .OpSel(OpSel),
        .Result(Result),
        .CarryOut_ALU(CarryOut_ALU),
        .Overflow_ALU(Overflow_ALU),
        .Zero(Zero),
        .Negative(Negative)
    );

    // Map outputs
    assign uo_out[6:0] = Result;
    assign uo_out[7]   = CarryOut_ALU;

    // Unused outputs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
