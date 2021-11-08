`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2021 06:02:52 PM
// Design Name: 
// Module Name: top
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


module top(
    input wire clk, reset,                 // Bsys 3 System clock & reset (assignable)
    input wire PS2Data,                    // ps2 data line
    input wire PS2Clk,                     // ps2 clock line
    output wire [6:0] seg,                  // Cathodes for 7 segment displays (timed assign)
    output wire [7:0] AN,            // 7 segment digit selector (timed) 
    output AUD_PWM     
    );
    wire [7:0] scan_code;
    wire [5:0] note;
    wire scan_code_ready;
    
    keyboard kb(.clk(clk),.reset(reset),.PS2Data(PS2Data),.PS2Clk(PS2Clk),.scan_code(scan_code),.scan_code_ready(scan_code_ready));//Recieves scan code from keyboard through PS2 interface
    keyboard_to_piano ktp(.scan_code(scan_code),.note(note),.scan_code_ready(scan_code_ready));//Converts scan code of key into music note equivalent
    display_control pianodc(.clk(clk),.note(note),.AN(AN),.seg(seg));//Displays note being played on 7-segment display
    speaker_control pianosc(.clk(clk),.note(note),.audio(AUD_PWM));//Plays note being pressed on keyboard
    
endmodule
