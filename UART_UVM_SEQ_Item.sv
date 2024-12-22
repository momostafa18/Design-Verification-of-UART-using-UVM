//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Sequence item.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Sequence item which carry the variables of the DUT to be easily randomized through the sequence , 
//                it's a UVM object ,so it can traverse the whole environment
//=====================================================================
class UART_Sequence_Item extends uvm_sequence_item;
  
   // Factory Registration
  `uvm_object_utils(UART_Sequence_Item)
  
  //Factory Construction
  function new (string name = "UART_Sequence_Item");
       super.new(name);
    endfunction
	
		// Parameters
        parameter DATA_WIDTH = 8 ;
		
		bit                          		 RST;
		bit                            		 TX_CLK;
		bit                            		 RX_CLK;
		rand bit	                         RX_IN_S;
		bit                                  RX_INN_S;
		bit   [DATA_WIDTH-1:0]       	     RX_OUT_P; 
		bit                                  RX_OUT_V;
		bit   [DATA_WIDTH-1:0]               TX_IN_P; 
		bit                                  TX_IN_V; 
		bit                          		 TX_OUT_S;
		bit                          		 TX_OUT_V;  
		bit   [5:0]                          Prescale; 
		bit                                  parity_enable;
		bit                                  parity_type;
		bit                          		 parity_error;
		bit                          		 framing_error;
		
		
		
	 
  
endclass
