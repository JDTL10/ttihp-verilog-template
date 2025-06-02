module ALU_Top;

    // Entradas de prueba
    reg  [6:0] A;
    reg  [6:0] B;
    reg  [2:0] OpSel;

    // Salidas
    wire [6:0] Result;
    wire       CarryOut;
    wire       Overflow;
    wire       Zero;
    wire       Negative;

    // Instancia de la ALU
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

    // Proceso de estimulación (se puede modificar en el testbench)
    initial begin
        // Ejemplo de pruebas secuenciales
        A = 7'd10; B = 7'd5; OpSel = 3'b000; #10; // Suma
        A = 7'd10; B = 7'd5; OpSel = 3'b001; #10; // Resta
        A = 7'b1010101; B = 7'b0101010; OpSel = 3'b010; #10; // AND
        A = 7'b1010101; B = 7'b0101010; OpSel = 3'b011; #10; // OR
        B = 7'd4; OpSel = 3'b100; #10; // Shift Left
        B = 7'd8; OpSel = 3'b101; #10; // Shift Right

        $finish; // Terminar simulación
    end

endmodule
