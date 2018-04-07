`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:23 04/03/2018 
// Design Name: 
// Module Name:    mux_c 
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
module mux_c(
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
	reg out;

	assign sel = {C[1], C[0]};
	assign x0 = X[0];
	assign x1 = X[1];
	assign x2 = X[2];
	assign x3 = X[3];

	assign Y = ~out;

	always@(G or sel or x0 or x1 or x2 or x3)
		begin
			if (G == 1'b0)
				begin
					if (sel == 2'b00 && x0 == 1'b1)
						begin 
							out = 1'b0;
						end
					else if (sel == 2'b01 && x1 == 1'b1)
						begin 
							out = 1'b0;
						end
					else if (sel == 2'b10 && x2 == 1'b1)
						begin
							out = 1'b0;
						end
					else if (sel == 2'b11 && x3 == 1'b1)
						begin
							out = 1'b0;
						end
					else
						begin
							out = 1'b1;
						end
				end
		end


endmodule
