`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2021 11:32:49 AM
// Design Name: 
// Module Name: speaker_control
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


module speaker_control(
    input clk,
    input [5:0] note,
    output reg audio
    );
       
    reg [18:0] count;
    reg [18:0] value;

    always@(posedge clk)
        if(count > 0)  
            count <= count - 1; 
        else begin 
            count <= value; 
            audio <= ~audio; 
        end
        
    always@(*)
      case (note)
        // These values are wave lengths of notes with respect to time (10 nano sec)
        // value = 100,000,000 / (frequency of notes / 2)
        6'b000000: value = 382233;   //C 3
        6'b000001: value = 360776;   //C#3
        6'b000010: value = 340529;   //D 3
        6'b000011: value = 321419;   //D#3
        6'b000100: value = 303379;   //E 3
        6'b000101: value = 286352;   //F 3
        6'b000110: value = 254817;   //G 3
        6'b000111: value = 240790;   //G#3
        6'b001000: value = 227273;   //A 3
        6'b001001: value = 214519;   //A#3
        6'b001010: value = 202478;   //B 3
        6'b001011: value = 191113;   //C 4
        6'b001100: value = 180388;   //C#4
        6'b001101: value = 170262;   //D 4
        6'b001110: value = 160705;   //D#4
        6'b001111: value = 151685;   //E 4
        6'b010000: value = 143172;   //F 4
        6'b010001: value = 135139;   //F#4
        6'b010010: value = 127553;   //G 4 
        6'b010011: value = 120395;   //G#4
        6'b010100: value = 113636;   //A 4
        6'b010101: value = 107259;   //A#4
        6'b010110: value = 101238;   //B 4 
        6'b010111: value = 95557;    //C 5
        6'b011000: value = 90194;    //C#5
        6'b011001: value = 85131;    //D 5
        6'b011010: value = 80353;    //D#5
        6'b011011: value = 75843;    //E 5
        6'b011100: value = 71587;    //F 5
        6'b011101: value = 67569;    //F#5
        6'b011110: value = 63776;    //G 5
        6'b011111: value = 60197;    //G#5
        6'b100000: value = 56818;    //A 5
        6'b100001: value = 53629;    //A#5
        6'b100010: value = 50619;    //B 5
        6'b100011: value = 270270;    //F# 3 - Missed this one
        6'b111111: value = 0;   //Stop (no noise)
      endcase
endmodule
