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

    wire [2:0] OpSel = ui_in[2:0];
    wire [6:0] A = {6'b0, ui_in[0]};
    wire [6:0] B = {6'b0, ui_in[1]};

    wire [6:0] Result;
    wire CarryOut, Overflow, Zero, Negative;

    ALU alu_inst (
        .A(A),
        .B(B),
        .OpSel(OpSel),
        .Result(Result),
        .CarryOut(CarryOut),
        .Overflow(Overflow),
        .Zero(Zero),
        .Negative(Negative)
    );

    assign uo_out[0] = Result[0];
    assign uo_out[1] = CarryOut;
    assign uo_out[2] = Overflow;
    assign uo_out[3] = Zero;
    assign uo_out[4] = Negative;
    assign uo_out[7:5] = 3'b000;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
