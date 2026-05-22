`timescale 1ns / 1ps

module complex_traffic_controller(
    input wire clk,
    input wire rst,
    output reg [2:0] m1_light,
    output reg [2:0] mt_light,
    output reg [2:0] m2_light,
    output reg [2:0] s_light
);

    localparam [2:0] STATE_TMG = 3'b000,
                     STATE_TY1 = 3'b001,
                     STATE_TTG = 3'b010,
                     STATE_TY2 = 3'b011,
                     STATE_TSG = 3'b100,
                     STATE_TY3 = 3'b101;

    localparam [2:0] LIGHT_RED    = 3'b100,
                     LIGHT_YELLOW = 3'b010,
                     LIGHT_GREEN  = 3'b001;

    localparam [4:0] TIME_LONG  = 5'd20,
                     TIME_SHORT = 5'd5;  

    reg [4:0] count;
    reg [2:0] state; 


    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            state <= STATE_TMG;
            count <= 5'd0;
        end else begin
            case (state)
                
                
                STATE_TMG: if (count < TIME_LONG) begin
                               state <= STATE_TMG;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TY1;
                               count <= 5'd0;
                           end
                
                
                STATE_TY1: if (count < TIME_SHORT) begin
                               state <= STATE_TY1;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TTG;
                               count <= 5'd0;
                           end

               
                STATE_TTG: if (count < TIME_LONG) begin
                               state <= STATE_TTG;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TY2;
                               count <= 5'd0;
                           end

             
                STATE_TY2: if (count < TIME_SHORT) begin
                               state <= STATE_TY2;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TSG;
                               count <= 5'd0;
                           end

             
                STATE_TSG: if (count < TIME_LONG) begin
                               state <= STATE_TSG;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TY3;
                               count <= 5'd0;
                           end

                
                STATE_TY3: if (count < TIME_SHORT) begin
                               state <= STATE_TY3;
                               count <= count + 1'b1;
                           end else begin
                               state <= STATE_TMG; 
                               count <= 5'd0;
                           end
                
                
                default: begin
                             state <= STATE_TMG;
                             count <= 5'd0;
                         end
            endcase
        end
    end

  
    always @(*) begin
        
      
        m1_light = LIGHT_RED;
        mt_light = LIGHT_RED;
        m2_light = LIGHT_RED;
        s_light  = LIGHT_RED;

       case (state)
           
            STATE_TMG: begin
                m1_light = LIGHT_GREEN;
                m2_light = LIGHT_GREEN;
            end
            
           
            STATE_TY1: begin
                m1_light = LIGHT_GREEN;
                m2_light = LIGHT_YELLOW;
            end
            
           
            STATE_TTG: begin
                m1_light = LIGHT_GREEN;
                mt_light = LIGHT_GREEN;
            end
            
          
            STATE_TY2: begin
                m1_light = LIGHT_YELLOW;
                mt_light = LIGHT_YELLOW;
            end
            
           
            STATE_TSG: begin
                s_light  = LIGHT_GREEN;
            end
            
      
            STATE_TY3: begin
                s_light  = LIGHT_YELLOW;
            end
        endcase
    end

endmodule