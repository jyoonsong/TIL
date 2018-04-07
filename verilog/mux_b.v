`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:56 04/03/2018 
// Design Name: 
// Module Name:    mux_b 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_b(
	 input G,
    input [1:0] C,
    input [3:0] X,
    output Y
    );
	 
	wire [1:0] sel;
	wire x0;
	wire x1;
	wire x2;
	wire x3;
	wire out;

	assign sel = {C[0], C[1]};
	assign x0 = X[0];
	assign x1 = X[1];
	assign x2 = X[2];
	assign x3 = X[3];

	assign Y = ~out;

	assign out =(sel == 2'b00 && x0 == 1'b0 && G == 1'b0) ? 1'b1 :
					(sel == 2'b01 && x1 == 1'b0 && G == 1'b0) ? 1'b1 :
					(sel == 2'b10 && x2 == 1'b0 && G == 1'b0) ? 1'b1 :
					(sel == 2'b11 && x3 == 1'b0 && G == 1'b0) ? 1'b1 :
					1'b0;



endmodule
