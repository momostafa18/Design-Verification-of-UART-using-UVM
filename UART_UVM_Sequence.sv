
//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Sequence.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM sequence which is mainly used for creating sequences used to test the DUT
//=====================================================================
class uart_frame;
  // Frame fields
  bit start_bit;
  rand bit [7:0] data_bits;     // 8-bit data frame
  bit stop_bit;

  // Constructor
  function new();
    start_bit = 0;         // Start bit is always 0
    stop_bit = 1;          // Stop bit is always 1
  endfunction

  
endclass


class UART_Sequence extends uvm_sequence #(UART_Sequence_Item);

  UART_Sequence_Item uart_seq_item ;
  uart_frame frame ;	
  // Factory Registration
  `uvm_object_utils(UART_Sequence)
  
  //Factory Construction
  function new (string name = "UART_Sequence");
       super.new(name);
    endfunction


  //Prebody Task  
  task pre_body ;
    uart_seq_item = UART_Sequence_Item :: type_id:: create("uart_seq_item");
	frame = new; 
  endtask


  //Body Task
  task body;
  
  start_item(uart_seq_item);
  uart_seq_item.RST = 0;
  finish_item(uart_seq_item);
			

  start_item(uart_seq_item);
  uart_seq_item.RST = 1;
  uart_seq_item.RX_IN_S = 1;
  finish_item(uart_seq_item);
  
  for (int i = 0 ; i < 10 ; i++) begin 
  
  start_item(uart_seq_item);
  uart_seq_item.RST = 1;
  uart_seq_item.RX_IN_S = 1;
  finish_item(uart_seq_item);
  
  void'(frame.randomize()); // Randomize the data, parity enable, and parity type
  
  
  
  start_item(uart_seq_item);
  uart_seq_item.RX_IN_S = 'b1;
  finish_item(uart_seq_item);
  
  // Start Bit
  start_item(uart_seq_item);
  uart_seq_item.RX_IN_S = frame.start_bit;
  finish_item(uart_seq_item);

  // Data Bits
  foreach (frame.data_bits[i]) begin
  start_item(uart_seq_item);
  uart_seq_item.RX_IN_S = frame.data_bits[i];
  finish_item(uart_seq_item);
    end
  

  // Stop Bit
  start_item(uart_seq_item);
  uart_seq_item.RX_IN_S = frame.stop_bit;
  finish_item(uart_seq_item);

  end
  endtask
  
endclass





