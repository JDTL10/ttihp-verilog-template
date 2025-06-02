module ALU_Top (
    input  wire [6:0] sw,       // sw[6:0] => B
    input  wire [3:0] btn,      // btn[2:0] => OpSel, btn[3] => reset
    input  wire [6:0] A_input,  // Entrada adicional (p. ej. desde switches extra o constante)
    output wire [6:0] led,      // Resultado
    output wire       CarryOut,
    output wire       Overflow,
    output wire       Zero,
    output wire       Negative
);
    wire [6:0] A, B;
    wire [2:0] OpSel;
    wire rst;

    assign A     = A_input;
    assign B     = sw;
    assign OpSel = btn[2:0];
    assign rst   = btn[3];

    wire [6:0] result;
    wire co, ov, z, n;

    ALU alu_unit (
        .A(A),
        .B(B),
        .OpSel(OpSel),
        .Result(result),
        .CarryOut(co),
        .Overflow(ov),
        .Zero(z),
        .Negative(n)
    );

    assign led       = result;
    assign CarryOut  = co;
    assign Overflow  = ov;
    assign Zero      = z;
    assign Negative  = n;

endmodule
