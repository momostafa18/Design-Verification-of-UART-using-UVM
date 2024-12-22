//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Driver.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Driver file for driving the Computational Storage module
//=====================================================================
class UART_Driver extends uvm_driver #(UART_Sequence_Item);

  // Declare a sequence item and interface
  UART_Sequence_Item uart_seq_item;
  virtual UART_Intf uart_intf;

  // Factory Registration
  `uvm_component_utils(UART_Driver)

  // Factory Construction
  function new(string name = "UART_Driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // UVM Phases
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Driver", "We_Are_Now_In_Driver_Build_Phase", UVM_NONE)

    // Factory Creation
    uart_seq_item = UART_Sequence_Item::type_id::create("uart_seq_item");

    // Database configurations
    if (!(uvm_config_db#(virtual UART_Intf)::get(this, "", "UART_VIF", uart_intf)))
      `uvm_fatal(get_full_name(), "Error")
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Driver", "We_Are_Now_In_Driver_Run_Phase", UVM_NONE)
    
	//uart_intf.start_clock();
	
	
    forever 
    begin

	  // Get the next item from the sequence
      seq_item_port.get_next_item(uart_seq_item);
      
      // Wait for the positive edge of the clock
      @(posedge uart_intf.TX_CLK)
      begin
	  
	  uart_intf.RST           	     <= uart_seq_item.RST ;
	  uart_intf.RX_IN_S     	     <= uart_seq_item.RX_IN_S ;
      uart_intf.parity_enable     	 <= uart_seq_item.parity_enable ;
	  uart_intf.parity_type     	 <= uart_seq_item.parity_type ;

      end
      
      #1; // Delay for 1 time unit
      
      // Indicate that the item has been processed
      seq_item_port.item_done();
	 end
  endtask
endclass
