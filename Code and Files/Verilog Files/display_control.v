`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2021 06:30:56 PM
// Design Name: 
// Module Name: display_control
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


module display_control(
    input clk,
    input [5:0] note,
    output reg [7:0] AN,
    output reg [6:0] seg
    );
    
    //Display variables
    reg [4:0] music_note, symbol, octave;
    
    //note decoder 
    always@(*)begin
        case(note)
        6'b000000: begin music_note = 12; symbol=18; octave=3; end    //C 3
        6'b000001: begin music_note = 12; symbol=17; octave=3; end   //C#3
        6'b000010: begin music_note = 13; symbol=18; octave=3; end   //D 3
        6'b000011: begin music_note = 13; symbol=17; octave=3; end   //D#3
        6'b000100: begin music_note = 14; symbol=18; octave=3; end   //E 3
        6'b000101: begin music_note = 15; symbol=18; octave=3; end   //F 3
        6'b000110: begin music_note = 16; symbol=18; octave=3; end   //G 3
        6'b000111: begin music_note = 16; symbol=17; octave=3; end   //G#3
        6'b001000: begin music_note = 10; symbol=18; octave=3; end   //A 3
        6'b001001: begin music_note = 10; symbol=17; octave=3; end   //A#3
        6'b001010: begin music_note = 11; symbol=18; octave=3; end   //B 3
        6'b001011: begin music_note = 12; symbol=18; octave=4; end   //C 4
        6'b001100: begin music_note = 12; symbol=17; octave=4; end   //C#4
        6'b001101: begin music_note = 13; symbol=18; octave=4; end   //D 4
        6'b001110: begin music_note = 13; symbol=17; octave=4; end   //D#4
        6'b001111: begin music_note = 14; symbol=18; octave=4; end   //E 4
        6'b010000: begin music_note = 15; symbol=18; octave=4; end   //F 4
        6'b010001: begin music_note = 15; symbol=17; octave=4; end   //F#4
        6'b010010: begin music_note = 16; symbol=18; octave=4; end   //G 4 
        6'b010011: begin music_note = 16; symbol=17; octave=4; end   //G#4
        6'b010100: begin music_note = 10; symbol=18; octave=4; end   //A 4
        6'b010101: begin music_note = 10; symbol=17; octave=4; end   //A#4
        6'b010110: begin music_note = 11; symbol=18; octave=4; end   //B 4 
        6'b010111: begin music_note = 12; symbol=18; octave=5; end    //C 5
        6'b011000: begin music_note = 12; symbol=17; octave=5; end    //C#5
        6'b011001: begin music_note = 13; symbol=18; octave=5; end    //D 5
        6'b011010: begin music_note = 13; symbol=17; octave=5; end    //D#5
        6'b011011: begin music_note = 14; symbol=18; octave=5; end    //E 5
        6'b011100: begin music_note = 15; symbol=18; octave=5; end    //F 5
        6'b011101: begin music_note = 15; symbol=17; octave=5; end    //F#5
        6'b011110: begin music_note = 16; symbol=18; octave=5; end    //G 5
        6'b011111: begin music_note = 16; symbol=17; octave=5; end    //G#5
        6'b100000: begin music_note = 10; symbol=18; octave=5; end    //A 5
        6'b100001: begin music_note = 10; symbol=17; octave=5; end    //A#5
        6'b100010: begin music_note = 11; symbol=18; octave=5; end    //B 5
        6'b100011: begin music_note = 15; symbol=17; octave=3; end    //F# 3 - Missed this one
        6'b111111: begin music_note = 18; symbol=18; octave=18; end   //Stop (no noise)
        endcase
    end
    
    ////////////////////////////////////////////////////////////////////////
    //7-Segment Display Implementation
    reg [4:0] LED_BCD;
    reg [19:0] refresh_counter; //20 bits for 10.5us refresh period
    wire [2:0] LED_activating_counter;
    
    always@(posedge clk) begin //counter
        refresh_counter <= refresh_counter + 1;
    end
    
    assign LED_activating_counter = refresh_counter[19:17];
    
    always@(*)begin
        case(LED_activating_counter)
        3'b000: begin LED_BCD = music_note; AN = 8'b11110111; end
        3'b001: begin LED_BCD = symbol; AN = 8'b11111011; end
        3'b010: AN = 8'b11111111;
        3'b011: begin LED_BCD = octave; AN = 8'b11111110; end
        3'b100: AN = 8'b11111111;
        3'b101: AN = 8'b11111111;
        3'b110: AN = 8'b11111111;
        3'b111: AN = 8'b11111111;
        endcase
    end
    
    always@(*)begin
        case(LED_BCD)
        5'b00000: seg = 7'b0000001;   //0
//      5'b00001: segment = 7'b1001111;   //1
//      5'b00010: segment = 7'b0010010;   //2
        5'b00011: seg = 7'b0000110;   //3
        5'b00100: seg = 7'b1001100;   //4
        5'b00101: seg = 7'b0100100;   //5
//      5'b00110: segment = 7'b0100000;   //6
//      5'b00111: segment = 7'b0001111;   //7
//      5'b01000: segment = 7'b0000000;   //8
//      5'b01001: segment = 7'b0000100;   //9
        5'b01010: seg = 7'b0001000;   //A
        5'b01011: seg = 7'b1100000;   //B
        5'b01100: seg = 7'b0110001;   //C
        5'b01101: seg = 7'b1000010;   //D
        5'b01110: seg = 7'b0110000;   //E
        5'b01111: seg = 7'b0111000;   //F
        5'b10000: seg = 7'b0100001;   //G
        5'b10001: seg = 7'b1001000;   //H
        5'b10010: seg = 7'b1111111;   //" "
        endcase
    end
    
endmodule
