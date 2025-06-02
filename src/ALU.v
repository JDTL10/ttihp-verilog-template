module Full_Adder (
    input  wire A,
    input  wire B,
    input  wire Cin,
    output wire Sum,
    output wire Cout
);
    assign {Cout, Sum} = A + B + Cin;
endmodule


// ===============================
// Sum_7bit.v
// ===============================
module Sum_7bit (
    input  wire [6:0] A,
    input  wire [6:0] B,
    input  wire       Cin,
    output wire [6:0] Result,
    output wire       CarryOut,
    output wire       Overflow
);
    wire [7:0] temp;
    assign temp = A + B + Cin;
    assign Result = temp[6:0];
    assign CarryOut = temp[7];
    assign Overflow = (A[6] ~^ B[6]) & (A[6] ^ Result[6]);
endmodule


// ===============================
// Rest_7bit.v
// ===============================
module Rest_7bit (
    input  wire [6:0] A,
    input  wire [6:0] B,
    output wire [6:0] Result,
    output wire       CarryOut,
    output wire       Overflow
);
    wire [6:0] B_neg;
    wire [7:0] temp;
    assign B_neg = ~B;
    assign temp = A + B_neg + 1;
    assign Result = temp[6:0];
    assign CarryOut = temp[7];
    assign Overflow = (A[6] ~^ B_neg[6]) & (A[6] ^ Result[6]);
endmodule


// ===============================
// Funcion_AND.v
// ===============================
module Funcion_AND (
    input  wire [6:0] A,
    input  wire [6:0] B,
    output wire [6:0] OUT
);
    assign OUT = A & B;
endmodule


// ===============================
// Funcion_OR.v
// ===============================
module Funcion_OR (
    input  wire [6:0] A,
    input  wire [6:0] B,
    output wire [6:0] OUT
);
    assign OUT = A | B;
endmodule


// ===============================
// Shift_Left.v
// ===============================
module Shift_Left (
    input  wire [6:0] B,
    output wire [6:0] OUT
);
    assign OUT = B << 1;
endmodule


// ===============================
// Shift_Right.v
// ===============================
module Shift_Right (
    input  wire [6:0] B,
    output wire [6:0] OUT
);
    assign OUT = B >> 1;
endmodule


// ===============================
// ALU.v
// ===============================
module ALU (
    input  wire [6:0] A,
    input  wire [6:0] B,
    input  wire [2:0] OpSel,
    output reg  [6:0] Result,
    output reg        CarryOut,
    output reg        Overflow,
    output wire       Zero,
    output wire       Negative
);
    wire [6:0] out_sum, out_rest, out_and, out_or, out_shl, out_shr;
    wire co_sum, ov_sum, co_rest, ov_rest;

    Sum_7bit sumador (
        .A(A), .B(B), .Cin(1'b0),
        .Result(out_sum),
        .CarryOut(co_sum),
        .Overflow(ov_sum)
    );

    Rest_7bit restador (
        .A(A), .B(B),
        .Result(out_rest),
        .CarryOut(co_rest),
        .Overflow(ov_rest)
    );

    Funcion_AND and_gate (.A(A), .B(B), .OUT(out_and));
    Funcion_OR  or_gate  (.A(A), .B(B), .OUT(out_or));
    Shift_Left  shl      (.B(B), .OUT(out_shl));
    Shift_Right shr      (.B(B), .OUT(out_shr));

    always @(*) begin
        case (OpSel)
            3'b000: begin Result = out_sum;  CarryOut = co_sum;  Overflow = ov_sum;  end
            3'b001: begin Result = out_rest; CarryOut = co_rest; Overflow = ov_rest; end
            3'b010: begin Result = out_and;  CarryOut = 1'b0;     Overflow = 1'b0;     end
            3'b011: begin Result = out_or;   CarryOut = 1'b0;     Overflow = 1'b0;     end
            3'b100: begin Result = out_shl;  CarryOut = 1'b0;     Overflow = 1'b0;     end
            3'b101: begin Result = out_shr;  CarryOut = 1'b0;     Overflow = 1'b0;     end
            default: begin Result = 7'b0;    CarryOut = 1'b0;     Overflow = 1'b0;     end
        endcase
    end

    assign Zero     = (Result == 7'b0);
    assign Negative = Result[6];
    
        Zero = (Result == 7'b0000000);
        Negative = Result[6];
    end
endmodule
