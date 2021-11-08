`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2021 04:17:41 PM
// Design Name: 
// Module Name: keyboard_to_piano
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keyboard_to_piano(
		input wire [7:0] scan_code,
		input wire scan_code_ready,
		output reg [5:0] note	
	);
//Music Note Parameters
    parameter C3 = 6'b000000;   //C 3
    parameter CS3 = 6'b000001;  //C# 3
    parameter D3 = 6'b000010;   //D 3
    parameter DS3 = 6'b000011;  //D# 3
    parameter E3 = 6'b000100;   //E 3
    parameter F3 = 6'b000101;   //F 3
    parameter G3 = 6'b000110;   //G 3
    parameter GS3 = 6'b000111;   //G#3
    parameter A3 = 6'b001000;   //A 3
    parameter AS3 = 6'b001001;   //A#3
    parameter B3 = 6'b001010;   //B 3
    parameter C4 = 6'b001011;   //C 4
    parameter CS4 = 6'b001100;   //C#4
    parameter D4 = 6'b001101;   //D 4
    parameter DS4 = 6'b001110;   //D#4
    parameter E4 = 6'b001111;   //E 4
    parameter F4 = 6'b010000;   //F 4
    parameter FS4 = 6'b010001;   //F#4
    parameter G4 = 6'b010010;   //G 4 
    parameter GS4 = 6'b010011;   //G#4
    parameter A4 = 6'b010100;   //A 4
    parameter AS4 = 6'b010101;   //A#4
    parameter B4 = 6'b010110;   //B 4 
    parameter C5 = 6'b010111;    //C 5
    parameter CS5 = 6'b011000;    //C#5
    parameter D5 = 6'b011001;    //D 5
    parameter DS5 = 6'b011010;    //D#5
    parameter E5 = 6'b011011;    //E 5
    parameter F5 = 6'b011100;    //F 5
    parameter FS5 = 6'b011101;    //F#5
    parameter G5 = 6'b011110;    //G 5
    parameter GS5 = 6'b011111;    //G#5
    parameter A5 = 6'b100000;    //A 5
    parameter AS5 = 6'b100001;    //A#5
    parameter B5 = 6'b100010;    //B 5
    parameter FS3 = 6'b100011;    //F# 3
    parameter STOP = 6'b111111;  //stops the song.
   
always @(*)
	begin
	if(scan_code_ready)begin
		case(scan_code)
			8'h45: note = DS4;   // 0
			//8'h16:     // 1
			8'h1e: note = CS3;    // 2
			8'h26: note = DS3; // 3
			//8'h25:    // 4
			8'h2e: note = FS3;   // 5
			8'h36: note = GS3;   // 6
			8'h3d: note = AS3;   // 7
			//8'h3e:    // 8
			8'h46: note = CS4;   // 9
			//8'h1c:    // a
			8'h32: note = C5;   // b
			8'h21: note = A4;   // c
			8'h23: note = GS4;   // d
			8'h24: note = E3;   // e
			8'h2b: note = AS4;   // f
			//8'h34:    // g
			8'h33: note = CS5;   // h
			8'h43: note = C4;   // i
			8'h3b: note = DS5;   // j
			//8'h42:    // k
			8'h4b: note = FS5;   // l
			8'h3a: note = E5;   // m
			8'h31: note = D5;   // n
			8'h44: note = D4;   // o
			8'h4d: note = E4;   // p
			8'h15: note = C3;   // q
			8'h2d: note = F3;   // r
			8'h1b: note = FS4;   // s
			8'h2c: note = G3;   // t
			8'h3c: note = B3;   // u
			8'h2a: note = B4;   // v
			8'h1d: note = D3;   // w
			8'h22: note = G4;   // x
			8'h35: note = A3;   // y
			8'h1a: note = F4;   // z
			//8'h0e:    // ``
			//8'h4e:    // -
			//8'h55:    // =
			//8'h54:    // [
			//8'h5b:    // ]
			//8'h5d:    // \
			8'h4c: note = GS5;   // ;
			8'h52: note = AS5;   // '
			8'h41: note = F5;   // ,
			8'h49: note = G5;   // .
			8'h4a: note = A5;   // /
			//8'h29:    // space
			//8'h5a:    // enter
			//8'h66:    // backspace
			//8'h0D:    // horizontal tab	
			8'h59: note = B5;   // shift
			//default: ascii_code = 8'h2A; // *
			8'hf0: note = STOP;
			default: note = STOP;
		endcase
    end
    
    end
	
endmodule

