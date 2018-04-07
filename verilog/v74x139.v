`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:00:06 04/03/2018 
// Design Name: 
// Module Name:    v74x139_a 
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
module v74x139_a(
    input A,
	 input B,
	 input C,
    output [3:0] Y1,
    output [3:0] Y2
    );
	 
	 wire N_C;
	 
	 not T(N_C, C);
	 
	 v74x139h_a T1(.G(C), .A(A), .B(B), .Y(Y1));
	 v74x139h_a T2(.G(N_C), .A(A), .B(B), .Y(Y2));


endmodule
