//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Monitor.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM monitor to sample the signals from the DUT and forward it to the scoreboard for checking 
//                against the golden model and the subscriber for the coverage collection
//=====================================================================
class UART_Monitor extends uvm_monitor;
  
  UART_Sequence_Item uart_seq_item;
  virtual UART_Intf uart_intf;
  
  uvm_analysis_port #(UART_Sequence_Item) M_write_port;
  
  // Factory Registration
  `uvm_component_utils(UART_Monitor)
  
  //Factory Construction
  function new (string name = "UART_Monitor" , uvm_component parent = null);
       super.new(name,parent);
    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Monitor" ,"We_Are_Now_In_Monitor_Build_Phase",UVM_NONE)
      // Factory Creation
      uart_seq_item = UART_Sequence_Item::type_id::create("uart_seq_item");
    
    //DataBase configurations
    if(!(uvm_config_db#(virtual UART_Intf)::get(this,"","UART_VIF",uart_intf)))
      `uvm_fatal(get_full_name(),"Error")
	  
     M_write_port = new("M_write_port",this); 
    endfunction
    
  task run_phase(uvm_phase phase);
      super.run_phase(phase);
    `uvm_info ("Monitor" ,"We_Are_Now_In_Monitor_Run_Phase",UVM_NONE)
    forever
      begin
        @ (posedge uart_intf.TX_CLK);
         begin
		 
		 uart_seq_item.TX_OUT_S  	  <= uart_intf.TX_OUT_S ;
		 uart_seq_item.TX_OUT_V  	  <= uart_intf.TX_OUT_V ;
		 uart_seq_item.parity_error   <= uart_intf.parity_error ;
		 uart_seq_item.framing_error  <= uart_intf.framing_error ;
		 uart_seq_item.RX_IN_S  	  <= uart_intf.RX_IN_S ;
		 uart_seq_item.RX_OUT_P  	  <= uart_intf.RX_OUT_P ;
		 uart_seq_item.RX_OUT_V  	  <= uart_intf.RX_OUT_V ;
		 uart_seq_item.TX_CLK         <= uart_intf.TX_CLK;
		 uart_seq_item.RX_CLK         <= uart_intf.RX_CLK;

		 
		 
		 
		 

         M_write_port.write(uart_seq_item);         
         end
      end
	  
    endtask
   endclass 
