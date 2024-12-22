//=====================================================================
// Project:       Computational Storage Module
// File:          UVM Scoreboard.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM Scoreboard for checking of the signals coming from the DUT through the monitor against the reference model. 
//                Analysis FIFO is used with the scoreboard to collect these samples
//=====================================================================
import "DPI-C" function void set_input_bit(bit value);
import "DPI-C" function int receive_data(int ticks);


class UART_Scoreboard extends uvm_scoreboard;
  
   bit single_BIT = 1; 
   bit [7:0] data;
   int ticksPerSec = 800000; 
   int data_valid = 0;
   
   UART_Sequence_Item uart_seq_item;
  
   uvm_analysis_export    #(UART_Sequence_Item) S_write_exp; 
  
   uvm_tlm_analysis_fifo  #(UART_Sequence_Item) m_tlm_fifo;
   
  // Factory Registration
  `uvm_component_utils(UART_Scoreboard)
  
  //Factory Construction
  function new (string name = "UART_Scoreboard" , uvm_component parent = null);
       super.new(name,parent);
    endfunction
    
   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Scoreboard" ,"We_Are_Now_In_Scoreboard_Build_Phase",UVM_NONE)
	
    // Factory Creation
      uart_seq_item = UART_Sequence_Item::type_id::create("uart_seq_item");
    
    
      S_write_exp = new("S_write_exp",this); 
      m_tlm_fifo  = new ("m_tlm_fifo",this);
    endfunction
    
  function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    `uvm_info ("Scoreboard" ,"We_Are_Now_In_Scoreboard_Connect_Phase",UVM_NONE)
      S_write_exp.connect(m_tlm_fifo.analysis_export); 
    endfunction
    
  task run_phase(uvm_phase phase);
      super.run_phase(phase);
    `uvm_info ("Scoreboard" ,"We_Are_Now_In_Scoreboard_Run_Phase",UVM_NONE)
	forever 
	 begin
	   m_tlm_fifo.get_peek_export.get(uart_seq_item);
	   $display("The TX Clock %0d" , uart_seq_item.TX_CLK);
	   $display("Before the FIGHT %0t" , $time);
	   DPI_REF();
	 end	
    endtask
  
  
  task DPI_REF();
  
        $display("Beforeeee the FIGHT %0t" , $time);
        // Set the TX input bit via DPI
        //@(posedge uart_seq_item.TX_CLK)
		//begin
        $display("This is SV, ", 'b1);
        set_input_bit('b1);

        // Simulate receiving data via DPI with timeout handling
        
        //data = receive_data(ticksPerSec);
        //end
		//$display("AFTERRRRR the FIGHT %0t" , $time);
	  
  
  endtask
  
    endclass



