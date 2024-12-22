//=====================================================================
// Project:       Computational Storage Module
// File:          computational_storage Interface.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   Computational storage interface to make the DUT signals accessible through the testbench
//=====================================================================
interface UART_Intf;	

  // Parameters
   parameter DATA_WIDTH = 8 ;
  
  // DUT's port variables
	bit                          RST;
	bit                          TX_CLK;
	bit                          RX_CLK;
	bit                          RX_IN_S;
	bit   [DATA_WIDTH-1:0]       RX_OUT_P; 
	bit                          RX_OUT_V;
	bit   [DATA_WIDTH-1:0]       TX_IN_P; 
	bit                          TX_IN_V; 
	bit                          TX_OUT_S;
	bit                          TX_OUT_V;  
	bit   [5:0]                  Prescale; 
	bit                          parity_enable;
	bit                          parity_type;
	bit                          parity_error;
	bit                          framing_error;
	
    bit   [DATA_WIDTH-1:0]       fifo_tx_data;
	
	bit   [DATA_WIDTH-1:0]       Tx_IN_p;
	
    bit                          rcv_flop  , 
                                 pls_flop  ;
    bit                          pulse_sig ;
    bit            [2:0]         current_state; 	
		 
  // Clock Generation //
		 bit Master_CLK;
		 int clk_high_TX = 8;
		 int clk_low_TX  = 8;


         int clk_high_RX = 1;
		 int clk_low_RX  = 1;
		 
		 initial begin
		 TX_CLK = 0;
		 RX_CLK = 0;
		 #1;
		  fork
			// TX Clock Generation
			begin
			  forever begin
				TX_CLK = 0;
				#clk_high_TX; // High time for TX clock
				TX_CLK = 1;
				#clk_low_TX;  // Low time for TX clock
			  end
			end

			// RX Clock Generation
			begin
			  forever begin
				RX_CLK = 0;
				#clk_high_RX; // High time for RX clock
				RX_CLK = 1;
				#clk_low_RX;  // Low time for RX clock
			  end
			end
		  join
		end

		 
	  always @(posedge RX_CLK or negedge RST)
	 begin
	  if(RX_OUT_V)      
	   begin
		  pulse_sig = 1;
	   end
	  else if(current_state == 6 )
	   begin
		  pulse_sig = 0; 
	   end

	 end


endinterface
