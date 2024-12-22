//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Environment.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM env for construction of agent , scoreboard and subscriber and their connections
//=====================================================================

class UART_Enviroment extends uvm_env;
  
    UART_Agent 		uart_agent;
  	UART_Scoreboard	uart_scoreboard;
    UART_Subscriber	uart_subscriber;
	
    virtual UART_Intf uart_intf;       

  
  // Factory Registration
  `uvm_component_utils(UART_Enviroment)
  
  //Factory Construction
  function new (string name = "UART_Enviroment",uvm_component parent = null);
       super.new(name,parent);
    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Enviroment" ,"We_Are_Now_In_Enviroment_Build_Phase",UVM_NONE)
    // Factory Creation
    uart_agent      = UART_Agent	  :: type_id	::create("uart_agent",this);
    uart_scoreboard = UART_Scoreboard :: type_id	::create("uart_scoreboard",this);
    uart_subscriber = UART_Subscriber :: type_id	::create("uart_subscriber",this);
	
	 //DataBase configurations
    if(!(uvm_config_db#(virtual UART_Intf)::get(this,"","UART_VIF",uart_intf)))
      `uvm_fatal(get_full_name(),"Error")
       
      uvm_config_db #(virtual UART_Intf)::set(this,"UART_Agent","UART_VIF",uart_intf);

    endfunction
    
  function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    `uvm_info ("Enviroment" ,"We_Are_Now_In_Enviroment_Connect_Phase",UVM_NONE)
    uart_agent.M_write_port.connect(uart_scoreboard.S_write_exp);
    uart_agent.M_write_port.connect(uart_subscriber.analysis_export);
    endfunction
    
    endclass
