`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2025 02:21:31 PM
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
// Additional Comments:INFO: [USF-XSim-97] XSim simulation ran for 1000ns

// 
//////////////////////////////////////////////////////////////////////////////////


module top(
     input clk,
     input [15:0] sw,
     output led,
     output reg [6:0] seg,
     output dp,
     output reg [3:0] an
    );
    wire out_of_bound;
    reg [1:0] active;
    reg [3:0] digit0, digit1, digit2, digit3, digit4;
    reg [35:0] shift_reg;
    reg [16:0] clkdiv;
    reg [3:0] active_digit;
    
    integer i,j;
    
    assign led = out_of_bound;
    assign dp = 1'b0;
    
    
    //clock division
    always @(posedge clk) begin
        clkdiv <=clkdiv+1;
    end
    
    wire slow_clk = clkdiv[16];
    
    // convert the binary value from switch to decimal using double dabble algorithm
    always @(*) begin
        shift_reg = 35'd0;
        shift_reg[15:0] = sw;

        for (i = 0; i < 16; i = i + 1) begin
            if (shift_reg[35:32] > 4)
                shift_reg[35:32] = shift_reg[35:32] + 4'd3;
            if (shift_reg[31:28] > 4)
                shift_reg[31:28] = shift_reg[31:28] + 4'd3;
            if (shift_reg[27:24] > 4)
                shift_reg[27:24] = shift_reg[27:24] + 4'd3;
            if (shift_reg[23:20] > 4)
                shift_reg[23:20] = shift_reg[23:20] + 4'd3;
            if (shift_reg[19:16] > 4)
                shift_reg[19:16] = shift_reg[19:16] + 4'd3;
            
            shift_reg = shift_reg << 1;
        end

        digit4 = shift_reg[35:32];  // Ten Thousands
        digit3 = shift_reg[31:28];  // Thousands
        digit2 = shift_reg[27:24];   // Hundreds
        digit1 = shift_reg[23:20];   // Tens
        digit0 = shift_reg[19:16];  //Ones
        
        
        $display("digits", shift_reg[35:32], shift_reg[31:28], shift_reg[27:24], shift_reg[23:20], shift_reg[19:16]);
    end
  
    // choose the value to be displayed based on anode on each clock cycle
    assign out_of_bound = (sw > 16'd9999);
    
    always @(posedge slow_clk) begin
        //update the digit to be selected
          active <= active+1;

         // update anode and active_digit based on the current active  
         case (active)
            2'b00: begin
                    an <= 4'b1110;
                    active_digit <= out_of_bound? 4'd10 : digit0;
                end
            2'b01: begin
                    an <= 4'b1101;
                    active_digit <= out_of_bound ? 4'd10 : digit1;
                end
            2'b10: begin
                    an <= 4'b1011;
                    active_digit <= out_of_bound ? 4'd10 : digit2;
                end
            2'b11: begin
                    an <= 4'b0111;
                    active_digit <= out_of_bound ? 4'd10 : digit3;
                end
            default: begin
                    an <= 4'b1111;
                    active_digit <= out_of_bound ? 4'd10 :  digit0;
                end
        endcase
    end
    
    always @(*) begin
        // display the value using the correct signal for cathodes
        case (active_digit)
            4'd0: seg <= 7'b1000000;  // '0'
            4'd1: seg <= 7'b1111001;  // '1'
            4'd2: seg <= 7'b0100100;  // '2'
            4'd3: seg <= 7'b0110000;  // '3'
            4'd4: seg <= 7'b0011001;  // '4'
            4'd5: seg <= 7'b0010010;  // '5'
            4'd6: seg <= 7'b0000010;  // '6'
            4'd7: seg <= 7'b1111000;  // '7'
            4'd8: seg <= 7'b0000000;  // '8'
            4'd9: seg <= 7'b0010000;  // '9'
            4'd10: seg <= 7'b0111111; // '-' (for out of bound)
            default: seg <= 7'b1111001; // off
          endcase
    end 
    
      
endmodule
