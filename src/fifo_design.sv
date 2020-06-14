// Code your design here
module FIFO#(parameter BUFF_SIZE = 8,
             parameter type dtype = logic[7:0])
  			(
            input logic push, 
            input logic pop,
            input dtype data_in,
            input logic clk,
            input logic rst,
            output dtype data_out
            );
  
  localparam PTR_SIZE = $clog2(BUFF_SIZE-1);
  logic [PTR_SIZE-1:0] wptr, rptr;
  dtype memory [BUFF_SIZE-1:0];
  logic [3:0] flags; //0:full,1:empty,2:almostFull,3:nearlyEmpty
  integer count;
  
  assign flags[2] = (count == BUFF_SIZE-1) ? 1 : 0; //almost_Full
  assign flags[3] = (count == 1) ? 1 : 0; //nearly_Empty
  
  always_ff@(posedge clk or negedge rst)
    begin
      if(!rst)
        begin
          for(int i=0; i<BUFF_SIZE; i++) memory[i] <= 0;
          count <= 0; data_out <=0; wptr <=0; rptr<=0;
          flags[0] <= 0; flags[1] <= 1; //Iniciando as flags cheia e vazia
        end
      else
        begin
          if(push && !flags[0])
             begin   
               if(wptr != BUFF_SIZE-1)
                 begin
                   memory[wptr] <= data_in;
                   wptr++;
                 end
               else
                 begin
                   memory[wptr] <= data_in;
                   wptr = 0;
                 end
               
               count++;  flags[1] <= 0;
 
               if(wptr == rptr) flags[0] <= 1;
               
            end
          
          if(pop && !flags[1])
            begin
               if(rptr != BUFF_SIZE-1)
                 begin
                   data_out <= memory[rptr];
                   rptr++;
                 end
              else
                begin
                  data_out <= memory[rptr];
                  rptr = 0;
                end
              
              count--;
              flags[0] <= 0;
              
              if(wptr == rptr) flags[1] <= 1;
              
            end
        end
    end
endmodule