`timescale 1ns / 1ps

/////////////////////////////////////////////////////////////////////////////////////////////////
// SPECIAL CREDIT TO:... 1. poketronics @ embeddedthoughts.com (Reference 5)
/////////////////////////////////////////////////////////////////////////////////////////////////
// Modeling Methods..... 1. Structural Modeling: gate-level modeling, elements as structures
//                          Notes: gate_type=keyword gate_name=chosen (port_list comma sep) 
//                                 wire=keyword gate_name1,gate_name2;
//
//     ( selected ) -->  2. Dataflow Modeling: relationship of input(s) & output(s) as a funtion
//                          Notes: assign=keyword output_name = some funtion of inputs
//                                 outsputs must be a scalar or vector. Merging Fns to condence
//                                 wire=keyowrd gate_name1,gate_name2; is also used here
//
//                       3. Behavioral Modeling: keywords for conditional & recursive statements
//                          Notes: always @ (sensitivity_list), an * triggers at any input change
//                                 triggering signals for behaviors specified in sensitivity list
//                                 signals can be comma separated or combined by the "or" keyword
//                                 inital=keyword for intilization of variables executed at time 0
//                                 reg=keyword saves the previous output
//                                 blocking assignment: "=" executed 1-by-1 (sequential or serial)
//                                 non-blocking assignment: "<=" executed concurrently (parallel)
//////////////////////////////////////////////////////////////////////////////////////////////////
// Realization Steps:... 1. Synthesize: transform system represented as code into FPGA blocks
//                       2. Simulation: feed input(s) & monitor output(s) via testbench file
//                       3. Implementation: optimzation, minimization, constraints
//                       4. Program: gen bit strm, HW mgr: open target/auto conn, program device
//////////////////////////////////////////////////////////////////////////////////////////////////


//#############################################################################################//
//////////////////////////////   Begin Module Instantiation   ///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
// Explanation: module=keyword {module_name}(port_list); 
// Notes: module_name should be unique and not any pre-defined verilog keywords
//        the port_list odes not have a specific order
//        ports may be "input", "output", or "inout"
//        If the project consists of more than one module, they should be properly instiation
//        above this one, e.g. module_name(port_list);
//                             input input_name1,input_name2;
//                             output output_name1, output_name2;
//                             statements;
//                             endmodule
module keyboard  // credit for formatting to embeddedthgouhts.com (Reference 5)
    (
	    input wire clk, reset,                 // Bsys 3 System clock & reset (assignable)
        input wire PS2Data,                    // ps2 data line
        input wire PS2Clk,                     // ps2 clock line
        output wire scan_code_ready,            // signal to outer controlsystem to sample scan_code
        output wire [7:0] scan_code              // scan_code received from keyboard to process
    );
/////////////////////////////////////////////////////////////////////////////////////////////////
    localparam  // these parameters to not belong to any other data type such as net or reg
            BREAK    = 8'hf0;       // break code
     
        // FSM symbolic states
    localparam [2:0] 
            lowercase          = 3'b000, // idle, process lower case letters
            ignore_break       = 3'b001; // ignore repeated scancode after break code -F0- rcvd
                   
    // internal signal declarations
    reg [2:0] state_reg, state_next;           // FSM state register and next state logic
    wire [7:0] scan_out;                       // scan code received from keyboard
    reg got_code_tick;                         // asserted to write curr scancode rcvd to FIFO
    wire scan_done_tick;                       // asserted to signal that ps2_rx has rcvd a scancode

    

    
//#############################################################################################//
///////////////////////       Begin External Module Instantiations       ////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
    ps2_rx ps2_rx_unit (// instantiate ps2 receiver (project dependency)
        .clk(clk), 
        .reset(reset), 
        .rx_en(1'b1), 
        .PS2Data(PS2Data), 
        .PS2Clk(PS2Clk),
        .rx_done_tick(scan_done_tick),
        .rx_data(scan_out)
        );


                                
always @(*) // any change in the input signals will trigger the state machine case statement
    begin
    
    // defaults
    got_code_tick   = 1'b0;
    state_next      = state_reg;
    
    case(state_reg)
    /////////////////////////////////////////////////////////////////////////////////////////////
    // State 1: Processes lwrcase key strokes, go to uppercase state to process shift/capslock //
    /////////////////////////////////////////////////////////////////////////////////////////////
       lowercase:
       begin
        if(scan_done_tick)                        // if scan code received
            begin
            /*if (scan_out == BREAK) begin          // else if code is break code
                got_code_tick = 1'b1;
                state_next = ignore_break;        // go to ignore_break state
            end
            else  */                                // else if code is none of the above
                got_code_tick = 1'b1;
            end
        end

    /////////////////////////////////////////////////////////////////////////////////////////////
    // State 2: Ignores repeated scan code after break code FO received in lowercase state   // 
    /////////////////////////////////////////////////////////////////////////////////////////////
    /*   ignore_break:
       begin
        if(scan_done_tick) begin  
            got_code_tick = 1'b0;  
            state_next = lowercase;// if scancode received, goback 2 lwrCase state 
        end
       end*/
    
    endcase
    end
// output, route got_code_tick to out control circuit to signal when to sample scan_out
assign scan_code_ready = got_code_tick;

// route scan code data out
assign scan_code = scan_out;

endmodule



