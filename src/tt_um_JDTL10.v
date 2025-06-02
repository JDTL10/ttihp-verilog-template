module ALU_Top (
    input  wire [7:0]  ui_in,     
    output wire [7:0]  uo_out,    
    input  wire [7:0]  uio_in,    
    output wire [7:0]  uio_out,  
    output wire [7:0]  uio_oe,    
    input  wire        ena,       
    input  wire        clk,      
    input  wire        rst_n      
);


    wire [6:0] A = ui_in[6:0];    
    wire [6:0] B = uio_in[6:0];    
    wire [2:0] OpSel = uio_out[2:0]; 
    
    wire [6:0] Result;
    wire       CarryOut;
    wire       Overflow;
    wire       Zero;
    wire       Negative;

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

    assign uo_out = {Zero, Result};  
    assign uio_out = {5'b00000, OpSel}; 
    assign uio_oe  = 8'b00000111;      

endmodule
