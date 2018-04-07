`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:49 04/03/2018
// Design Name:   v74x139_a
// Module Name:   /csehome/jh2177/v74x139/v74x139_a_test.v
// Project Name:  v74x139
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: v74x139_a
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module v74x139_a_test;

	// Inputs
	reg A;
	reg B;
	reg C;

	// Outputs
	wire [3:0] Y1;
	wire [3:0] Y2;

	// Instantiate the Unit Under Test (UUT)
	v74x139_a uut (
		.A(A),
		.B(B),
		.C(C),
		.Y1(Y1),
		.Y2(Y2)
	);

	initial begin
		// 000
		A = 0;
		B = 0;
		C = 0;
		
		#100;
        
		// 001
		A = 1;
		B = 0;
		C = 0;
		
		#100;
		
		// 010
		A = 0;
		B = 1;
		C = 0;
		
		#100;
		
		// 011
		A = 1;
		B = 1;
		C = 0;
		
		#100;
		
		// 100
		A = 0;
		B = 0;
		C = 1;
		
		#100;
        
		// 101
		A = 1;
		B = 0;
		C = 1;
		
		#100;
		
		// 110
		A = 0;
		B = 1;
		C = 1;
		
		#100;
		
		// 111
		A = 1;
		B = 1;
		C = 1;
		
		#100;



	end
      
endmodule

