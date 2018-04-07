`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:46 04/03/2018 
// Design Name: 
// Module Name:    mux_a 
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
module mux_a(
    input [1:0] C,
    input [3:0] X,
	 input G,
    output Y
    );
	 
	 wire N_C1, N_C2, A1, A2, A3, A4, S;
	 
	 not T1(N_C1, C[0]);
	 not T2(N_C2, C[1]);
	 
	 and T3(A1, X[0], N_C1, N_C2);
	 and T4(A2, X[1], C1, N_C2);
	 and T5(A3, X[2], N_C1, C2);
	 and T6(A4, X[3], C1, C2);
	 
	 or T7(S, A1, A2, A3, A4);
	 and T8(Y, S, ~G);

endmodule
