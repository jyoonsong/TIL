`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:28:45 04/03/2018
// Design Name:   mux_b
// Module Name:   /csehome/jh2177/multiplexer/mux_b_test.v
// Project Name:  multiplexer
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_b_test;

	// Inputs
	reg G;
	reg [1:0] C;
	reg [3:0] X;

	// Outputs
	wire Y;

	// Instantiate the Unit Under Test (UUT)
	mux_b uut (
		.G(G), 
		.C(C), 
		.X(X), 
		.Y(Y)
	);

	initial begin
		G = 0;
		C = 2'b00;
		X = 4'b0000;

		#100;
		
		G = 0;
		C = 2'b00;
		X = 4'b0001;
        
	end
      
endmodule

