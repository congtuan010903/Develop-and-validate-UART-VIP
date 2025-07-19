//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : test_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_TEST_PKG__SV
`define GUARD_UART_TEST_PKG__SV

package test_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  import seq_pkg::*;
  import env_pkg::*;

  // Include your file
	`include"uart_base_test.sv"
	`include"lhs2rhs_5bit_test.sv"
	`include"lhs2rhs_6bit_test.sv"
	`include"lhs2rhs_7bit_test.sv"
	`include"lhs2rhs_8bit_test.sv"
	`include"lhs2rhs_9bit_test.sv"
	`include"lhs2rhs_9bit_data_error_test.sv"
	`include"lhs2rhs_5bit_odd_test.sv"
	`include"lhs2rhs_6bit_odd_test.sv"
	`include"lhs2rhs_7bit_odd_test.sv"
	`include"lhs2rhs_8bit_odd_test.sv"
	`include"lhs2rhs_8bit_odd_error_test.sv"
	`include"lhs2rhs_8bit_odd_data_error_test.sv"
	`include"lhs2rhs_5bit_even_test.sv"
	`include"lhs2rhs_6bit_even_test.sv"
	`include"lhs2rhs_7bit_even_test.sv"
	`include"lhs2rhs_8bit_even_test.sv"
	`include"lhs2rhs_8bit_even_error_test.sv"
	`include"lhs2rhs_8bit_even_data_error_test.sv"
		
	`include"lhs2rhs_1stop_test.sv"
	`include"lhs2rhs_2stop_test.sv"
	`include"lhs2rhs_stop_error_test.sv"
	`include"lhs2rhs_diff_stop_test.sv"

	`include"lhs2rhs_4800_test.sv"
	`include"lhs2rhs_9600_test.sv"
	`include"lhs2rhs_19200_test.sv"
	`include"lhs2rhs_57600_test.sv"
	`include"lhs2rhs_115200_test.sv"
	`include"lhs2rhs_diff_baud_test.sv"
	`include"lhs2rhs_diff_parity_test.sv"
	`include"lhs2rhs_start_error_test.sv"

	`include"fd_5bit_test.sv"
	`include"fd_6bit_test.sv"
	`include"fd_7bit_test.sv"
	`include"fd_8bit_test.sv"
	`include"fd_9bit_test.sv"
	`include"fd_9bit_data_error_test.sv"
	`include"fd_5bit_odd_test.sv"
	`include"fd_6bit_odd_test.sv"
	`include"fd_7bit_odd_test.sv"
	`include"fd_8bit_odd_test.sv"
	`include"fd_8bit_odd_error_test.sv"
	`include"fd_8bit_odd_data_error_test.sv"
	`include"fd_5bit_even_test.sv"
	`include"fd_6bit_even_test.sv"
	`include"fd_7bit_even_test.sv"
	`include"fd_8bit_even_test.sv"
	`include"fd_8bit_even_error_test.sv"
	`include"fd_8bit_even_data_error_test.sv"
		
	`include"fd_1stop_test.sv"
	`include"fd_2stop_test.sv"
	`include"fd_stop_error_test.sv"
	`include"fd_diff_stop_test.sv"

	`include"fd_4800_test.sv"
	`include"fd_9600_test.sv"
	`include"fd_19200_test.sv"
	`include"fd_57600_test.sv"
	`include"fd_115200_test.sv"
	`include"fd_diff_baud_test.sv"
	`include"fd_diff_parity_test.sv"
	`include"fd_start_error_test.sv"

	`include"rhs2lhs_5bit_test.sv"
	`include"rhs2lhs_6bit_test.sv"
	`include"rhs2lhs_7bit_test.sv"
	`include"rhs2lhs_8bit_test.sv"
	`include"rhs2lhs_9bit_test.sv"
	`include"rhs2lhs_9bit_data_error_test.sv"
	`include"rhs2lhs_5bit_odd_test.sv"
	`include"rhs2lhs_6bit_odd_test.sv"
	`include"rhs2lhs_7bit_odd_test.sv"
	`include"rhs2lhs_8bit_odd_test.sv"
	`include"rhs2lhs_8bit_odd_error_test.sv"
	`include"rhs2lhs_8bit_odd_data_error_test.sv"
	`include"rhs2lhs_5bit_even_test.sv"
	`include"rhs2lhs_6bit_even_test.sv"
	`include"rhs2lhs_7bit_even_test.sv"
	`include"rhs2lhs_8bit_even_test.sv"
	`include"rhs2lhs_8bit_even_error_test.sv"
	`include"rhs2lhs_8bit_even_data_error_test.sv"
		
	`include"rhs2lhs_1stop_test.sv"
	`include"rhs2lhs_2stop_test.sv"
	`include"rhs2lhs_stop_error_test.sv"
	`include"rhs2lhs_diff_stop_test.sv"

	`include"rhs2lhs_4800_test.sv"
	`include"rhs2lhs_9600_test.sv"
	`include"rhs2lhs_19200_test.sv"
	`include"rhs2lhs_57600_test.sv"
	`include"rhs2lhs_115200_test.sv"
	`include"rhs2lhs_diff_baud_test.sv"
	`include"rhs2lhs_diff_parity_test.sv"
	`include"rhs2lhs_start_error_test.sv"

endpackage: test_pkg

`endif


