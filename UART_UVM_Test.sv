//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Test.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Test for starting the sequence 
//=====================================================================
class UART_Test extends uvm_test;
  
  UART_Enviroment uart_enviroment ;
  UART_Sequence     uart_sequence ;
  
  virtual UART_Intf uart_intf;

  
  // Factory Registration
  `uvm_component_utils(UART_Test)
  
  //Factory Construction
  function new (string name = "UART_Test" , uvm_component parent = null);
       super.new(name,parent);
    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Test" ,"We_Are_Now_In_Test_Build_Phase",UVM_NONE)
    // Factory Creation
    uart_enviroment= UART_Enviroment::type_id::create("uart_enviroment",this);
    uart_sequence= UART_Sequence::type_id::create("uart_sequence");
	
	//DataBase configurations
    if(!(uvm_config_db#(virtual UART_Intf)::get(this,"","UART_VIF",uart_intf)))
      `uvm_fatal(get_full_name(),"Error")
       
      uvm_config_db #(virtual UART_Intf)::set(this,"UART_Enviroment","UART_VIF",uart_intf);
    endfunction
    
    
  task run_phase(uvm_phase phase);
      super.run_phase(phase);
    `uvm_info ("Test" ,"We_Are_Now_In_Test_Run_Phase",UVM_NONE)
     phase.raise_objection(this,"Starting Sequence");
     uart_sequence.start(uart_enviroment.uart_agent.uart_sequencer);
	 #1000;
     phase.drop_objection(this,"Finished Sequence");
    endtask
    
    endclass
