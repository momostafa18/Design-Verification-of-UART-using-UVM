//=====================================================================
// Project:       Computational Storage Module
// File:          package
// Author:        Mohamed Mostafa
// Date:          27/9/2024
// Description:   Package to gather all the UVM files
//=====================================================================

`timescale 1ns / 1fs


`include "uvm_macros.svh"
import uvm_pkg ::*;

`include "UART_UVM_SEQ_Item.sv"
`include "UART_UVM_Sequence.sv"
`include "UART_UVM_Sequencer.sv"
`include "UART_UVM_Driver.sv"
`include "UART_UVM_Monitor.sv"
`include "UART_UVM_Agent.sv"
`include "UART_UVM_Subscriber.sv"
`include "UART_UVM_Scoreboard.sv"
`include "UART_UVM_Env.sv"
`include "UART_UVM_Test.sv"
