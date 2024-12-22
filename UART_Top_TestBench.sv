//=====================================================================
// Project:       Computational Storage Module
// File:          computational_storage TestBench.sv
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   UVM TestBench file for checking the Computational Storage module
//=====================================================================

module UART_TestBench();

 `include "UART_PKG.sv"
  UART_Intf uart_intf();
  
	
  
  
  UART DUT
  (
  .RST            (uart_intf.RST            ),  // Reset signal
  .TX_CLK         (uart_intf.TX_CLK         ),  // Transmit clock
  .RX_CLK         (uart_intf.RX_CLK         ),  // Receive clock
  .RX_IN_S        (uart_intf.RX_IN_S        ),  // Receive input serial
  .RX_OUT_P       (uart_intf.RX_OUT_P       ),  // Receive output parallel
  .RX_OUT_V       (uart_intf.RX_OUT_V       ),  // Receive output valid
  .TX_IN_P        (uart_intf.Tx_IN_p        ),  // Transmit input parallel
  .TX_IN_V        (uart_intf.pulse_sig       ),  // Transmit input valid
  .TX_OUT_S       (uart_intf.TX_OUT_S       ),  // Transmit output serial
  .TX_OUT_V       (uart_intf.TX_OUT_V       ),  // Transmit output valid
  .Prescale       (uart_intf.Prescale       ),  // Prescale value
  .parity_enable  (uart_intf.parity_enable  ),  // Parity enable signal
  .parity_type    (uart_intf.parity_type    ),  // Parity type
  .parity_error   (uart_intf.parity_error   ),  // Parity error flag
  .framing_error  (uart_intf.framing_error  )   // Framing error flag
  );
  

    
   initial 
	begin
	 uvm_config_db #(virtual UART_Intf)::set(null,"*","UART_VIF",uart_intf);
     run_test("UART_Test");
	 end

   /*assign DUT.TX_IN_V = DUT.RX_OUT_V  ;
   assign DUT.TX_IN_P = DUT.RX_OUT_P  ;*/
   
   assign uart_intf.Prescale      = 8;
   assign uart_intf.parity_enable = 0;
   assign uart_intf.current_state = DUT.U0_UART_TX.U0_fsm.current_state;
					 
   assign uart_intf.Tx_IN_p       = (uart_intf.RX_OUT_V == 1) ? uart_intf.RX_OUT_P : uart_intf.Tx_IN_p ;	


endmodule
