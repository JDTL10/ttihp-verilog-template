// ===============================
// ALU.v
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
    wire [6:0] out_sum, out_rest, out_and, out_or, out_shl, out_shr;
    wire co_sum, ov_sum, co_rest, ov_rest;

    Sum_7bit sumador (
        .A(A), .B(B), .Cin(1'b0),
        .Result(out_sum),
        .CarryOut_sum(co_sum),
        .Overflow_sum(ov_sum)
    );

    Rest_7bit restador (
        .A(A), .B(B),
        .Result(out_rest),
        .CarryOut_rest(co_rest),
        .Overflow_rest(ov_rest)
    );

    Funcion_AND and_gate (.A(A), .B(B), .OUT(out_and));
    Funcion_OR  or_gate  (.A(A), .B(B), .OUT(out_or));
    Shift_Left  shl      (.B(B), .OUT(out_shl));
    Shift_Right shr      (.B(B), .OUT(out_shr));

    always @(*) begin
        case (OpSel)
            3'b000: begin Result = out_sum;  CarryOut_ALU = co_sum;  Overflow_ALU = ov_sum;  end
            3'b001: begin Result = out_rest; CarryOut_ALU = co_rest; Overflow_ALU = ov_rest; end
            3'b010: begin Result = out_and;  CarryOut_ALU = 1'b0;    Overflow_ALU = 1'b0;    end
            3'b011: begin Result = out_or;   CarryOut_ALU = 1'b0;    Overflow_ALU = 1'b0;    end
            3'b100: begin Result = out_shl;  CarryOut_ALU = 1'b0;    Overflow_ALU = 1'b0;    end
            3'b101: begin Result = out_shr;  CarryOut_ALU = 1'b0;    Overflow_ALU = 1'b0;    end
            default: begin Result = 7'b0;    CarryOut_ALU = 1'b0;    Overflow_ALU = 1'b0;    end
        endcase
    end

    assign Zero     = (Result == 7'b0);
    assign Negative = Result[6];
endmodule
