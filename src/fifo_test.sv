// Code your testbench here
// or browse Examples
module FIFO_TB();
  
  parameter CLOCK_PERIOD = 10;
  parameter BUFF_SIZE_t = 8;
  parameter DATA_SIZE_t = 8;
  
  typedef struct packed
  {
    int cpf;
    int idade;
    int rg;
  } pessoa;
  
  logic push_i, pop_i, clk_i, rst_i;
  pessoa data_in_i, data_out_o;
  pessoa dataAux;
 
  pessoa pessoa2;
  
  FIFO #(.BUFF_SIZE(BUFF_SIZE_t),.dtype(pessoa)) 
  DUT(
    .push(push_i),
    .pop(pop_i),
    .clk(clk_i),
    .rst(rst_i),
    .data_in(data_in_i),
    .data_out(data_out_o)
  );
  
  initial begin
    clk_i = 0;
    pop_i = 0;
    push_i = 0;
    data_in_i = 0;
    dataAux = 0;
  end
  
  always #(CLOCK_PERIOD/2) clk_i = ~clk_i;
  
  task reset(input logic resetValue);
    rst_i = resetValue;
    @(posedge clk_i);
    rst_i = ~resetValue;
  endtask
  
  task insertFIFO(input logic push, pop, input pessoa data_in);
    push_i = push;
    pop_i = pop;
    data_in_i = data_in;
    @(posedge clk_i);
  endtask
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    reset(0);
    $display("Out = %d\t", data_out_o);
    $display("================ INICIO DOS PUSH'S =====================");
    
    //Inserindo valores na fila
    pessoa2.cpf = 1;
    pessoa2.idade = 20;
    pessoa2.rg = 01;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 2;
    pessoa2.idade = 21;
    pessoa2.rg = 02;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 3;
    pessoa2.idade = 22;
    pessoa2.rg = 03;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 4;
    pessoa2.idade = 23;
    pessoa2.rg = 04;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 5;
    pessoa2.idade = 24;
    pessoa2.rg = 05;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 6;
    pessoa2.idade = 25;
    pessoa2.rg = 06;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 7;
    pessoa2.idade = 26;
    pessoa2.rg = 07;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    $display("================ INICIO DOS POP'S =====================");
    
    //Retirando um valor da fila
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    $display("================ INICIO DOS PUSH'S =====================");
 
    pessoa2.cpf = 8;
    pessoa2.idade = 27;
    pessoa2.rg = 08;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    pessoa2.cpf = 9;
    pessoa2.idade = 28;
    pessoa2.rg = 09;
    dataAux = pessoa2;
    insertFIFO(1,0,dataAux);
    $display("IN = %p\t", data_in_i);
    
    $display("================ INICIO DOS POP'S =====================");
	
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);    
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    insertFIFO(0,1,0);
    $display("Out = %p\t", data_out_o);
    
    $finish;
  end
  
endmodule