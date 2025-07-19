class rhs2lhs_8bit_even_data_error_test extends uart_base_test;
	`uvm_component_utils(rhs2lhs_8bit_even_data_error_test)

	uart_tx_lhs_sequence tx_lhs_seq;
	uart_tx_rhs_sequence tx_rhs_seq;

	function new(string name = "rhs2lhs_8bit_even_data_error_test", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	virtual function void rhs_config(uart_configuration cfg);
		cfg.active 		  = 1;
		cfg.baud_rate   = 9600;
		cfg.data_width  = 8;
		cfg.stop_bits   = 2;
		cfg.data_error  = 1;
		cfg.data_er_pos = 2;
		cfg.parity_mode = uart_configuration::PARITY_EVEN;
	endfunction: rhs_config

	virtual function void lhs_config(uart_configuration cfg);
		cfg.active 		  = 0;
		cfg.baud_rate   = 9600;
		cfg.data_width  = 8;
		cfg.stop_bits   = 2;
		cfg.parity_mode = uart_configuration::PARITY_EVEN;
	endfunction: lhs_config

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		err_catcher.add_error_catcher_msg("Data not match");
		tx_lhs_seq = uart_tx_lhs_sequence::type_id::create("tx_lhs_seq");
		tx_rhs_seq = uart_tx_rhs_sequence::type_id::create("tx_rhs_seq");
	  fork	
			tx_rhs_seq.start(uart_env.uart_rhs_agent.uart_seqcer); 
			//tx_lhs_seq.start(uart_env.uart_lhs_agent.uart_seqcer);
		join	
		phase.drop_objection(this);
	endtask: run_phase

endclass: rhs2lhs_8bit_even_data_error_test
