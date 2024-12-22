//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Agent.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Agent to encapsulate the driver and monitor and drive the signals from the monitor to the SC and subscriber , also connecting the driver and the sequencer
//=====================================================================
class UART_Agent extends uvm_agent;
  
  UART_Driver 	    uart_driver;
  UART_Monitor 	    uart_monitor;
  UART_Sequencer	uart_sequencer;
  virtual UART_Intf uart_intf ;      
  
  uvm_analysis_port #(UART_Sequence_Item) M_write_port;
  
  // Factory Registration
  `uvm_component_utils(UART_Agent)
  
  //Factory Construction
  function new (string name = "UART_Agent" , uvm_component parent = null);
       super.new(name,parent);
    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Agent" ,"We_Are_Now_In_Agent_Build_Phase",UVM_NONE)
    // Factory Creation
      uart_driver = UART_Driver::type_id::create("uart_driver", this);
      uart_monitor = UART_Monitor::type_id::create("uart_monitor", this);
      uart_sequencer = UART_Sequencer::type_id::create("uart_sequencer", this);
    
    
    //DataBase configurations
    if(!(uvm_config_db#(virtual UART_Intf)::get(this,"","UART_VIF",uart_intf)))
      `uvm_fatal(get_full_name(),"Error")
       
    uvm_config_db #(virtual UART_Intf)::set(this,"UART_Agent","UART_VIF",uart_intf);
    uvm_config_db #(virtual UART_Intf)::set(this,"UART_Monitor","UART_VIF",uart_intf);

     M_write_port = new("M_write_port",this); 
    endfunction
    
  function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    `uvm_info ("Agent" ,"We_Are_Now_In_Agent_Connect_Phase",UVM_NONE)
    uart_driver.seq_item_port.connect(uart_sequencer.seq_item_export);
    uart_monitor.M_write_port.connect(M_write_port);
    endfunction
    
  endclass  
