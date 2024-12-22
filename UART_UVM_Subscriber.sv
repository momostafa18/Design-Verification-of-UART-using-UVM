//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Subscriber.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Subscriber for functional coverage
//=====================================================================
class UART_Subscriber extends uvm_subscriber #(UART_Sequence_Item);
  
   UART_Sequence_Item uart_seq_item;
   
  
  // Factory Registration
  `uvm_component_utils(UART_Subscriber)
  
  //Factory Construction
  function new (string name = "UART_Subscriber" , uvm_component parent = null);
       super.new(name,parent);

    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Subscriber" ,"We_Are_Now_In_Subscriber_Build_Phase",UVM_NONE)
    // Factory Creation
      uart_seq_item = UART_Sequence_Item::type_id::create("uart_seq_item");
    endfunction
    
  task run_phase(uvm_phase phase);
      super.run_phase(phase);
    `uvm_info ("Subscriber" ,"We_Are_Now_In_Subscriber_Run_Phase",UVM_NONE)
    endtask
  
  	
  
    function void write(UART_Sequence_Item t);
      uart_seq_item = t ;

	endfunction
    endclass
