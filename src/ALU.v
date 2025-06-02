// ===============================
// ALU.v (todo embebido)
// ===============================
module ALU (
    input  wire [6:0] A,
    input  wire [6:0] B,
    input  wire [2:0] OpSel,
    output reg  [6:0] Result,
    output reg        CarryOut_ALU,
    output reg        Overflow_ALU,
    output wire       Zero,
    output wire       Negative
);

    // === Submódulo Sum_7bit ===
    wire [6:0] sum_result;
    wire sum_carryout, sum_overflow;
    wire [7:0] sum_temp = A + B + 1'b0;
    assign sum_result = sum_temp[6:0];
    assign sum_carryout = sum_temp[7];
    assign sum_overflow = (A[6] ~^ B[6]) & (A[6] ^ sum_result[6]);

    // === Submódulo Rest_7bit ===
    wire [6:0] rest_result;
    wire rest_carryout, rest_overflow;
    wire [6:0] B_neg = ~B;
    wire [7:0] rest_temp = A + B_neg + 1'b1;
    assign rest_result = rest_temp[6:0];
    assign rest_carryout = rest_temp[7];
    assign rest_overflow = (A[6] ~^ B_neg[6]) & (A[6] ^ rest_result[6]);

    // === Submódulo Funcion_AND ===
    wire [6:0] and_result = A & B;

    // === Submódulo Funcion_OR ===
    wire [6:0] or_result = A | B;

    // === Submódulo Shift_Left ===
    wire [6:0] shl_result = B << 1;

    // === Submódulo Shift_Right ===
    wire [6:0] shr_result = B >> 1;

    // === Lógica principal ===
    always @(*) begin
        case (OpSel)
            3'b000: begin
                Result = sum_result;
                CarryOut_ALU = sum_carryout;
                Overflow_ALU = sum_overflow;
            end
            3'b001: begin
                Result = rest_result;
                CarryOut_ALU = rest_carryout;
                Overflow_ALU = rest_overflow;
            end
            3'b010: begin
                Result = and_result;
                CarryOut_ALU = 1'b0;
                Overflow_ALU = 1'b0;
            end
            3'b011: begin
                Result = or_result;
                CarryOut_ALU = 1'b0;
                Overflow_ALU = 1'b0;
            end
            3'b100: begin
                Result = shl_result;
                CarryOut_ALU = 1'b0;
                Overflow_ALU = 1'b0;
            end
            3'b101: begin
                Result = shr_result;
                CarryOut_ALU = 1'b0;
                Overflow_ALU = 1'b0;
            end
            default: begin
                Result = 7'b0;
                CarryOut_ALU = 1'b0;
                Overflow_ALU = 1'b0;
            end
        endcase
    end

    assign Zero     = (Result == 7'b0);
    assign Negative = Result[6];

endmodule
