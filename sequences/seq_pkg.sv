//=============================================================================
// Project       : UART VIP
//=============================================================================

`ifndef GUARD_UART_SEQ_PKG__SV
`define GUARD_UART_SEQ_PKG__SV

package seq_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;

  // Include your file
	`include"uart_tx_lhs_sequence.sv"
	`include"uart_tx_lhs_parity_er_sequence.sv"
	`include"uart_tx_lhs_stop_er_sequence.sv"
	`include"uart_tx_lhs_start_er_sequence.sv"
	
	`include"uart_tx_rhs_sequence.sv"
	`include"uart_tx_rhs_parity_er_sequence.sv"
	`include"uart_tx_rhs_stop_er_sequence.sv"
	`include"uart_tx_rhs_start_er_sequence.sv"

endpackage: seq_pkg

`endif


