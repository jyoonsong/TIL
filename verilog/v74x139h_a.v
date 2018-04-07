`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:35 04/03/2018 
// Design Name: 
// Module Name:    v74x139h_a 
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
module v74x139h_a(
    input G,
    input A,
    input B,
    output [3:0] Y
    );
	 
	 wire N_A, N_B, N_G;
	 
	 not T1(N_G, G);
	 not T2(N_A, A);
	 not T3(N_B, B);
	 
	 nand T4(Y[0], N_G, N_A, N_B);
	 nand T5(Y[1], N_G, A, N_B);
	 nand T6(Y[2], N_G, N_A, B);
	 nand T7(Y[3], N_G, A, B);

endmodule
