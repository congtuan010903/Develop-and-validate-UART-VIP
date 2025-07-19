class rhs2lhs_diff_stop_test extends uart_base_test;
	`uvm_component_utils(rhs2lhs_diff_stop_test)

	uart_tx_lhs_stop_er_sequence tx_lhs_seq;
	uart_tx_rhs_stop_er_sequence tx_rhs_seq;

	function new(string name = "rhs2lhs_diff_stop_test", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	virtual function void rhs_config(uart_configuration cfg);
		cfg.active 		  = 1;
		cfg.baud_rate   = 115200;
		cfg.data_width  = 6;
		cfg.stop_bits   = 2;
		cfg.data_error  = 0;
		cfg.data_er_pos = 3;
		cfg.parity_mode = uart_configuration::PARITY_EVEN;
	endfunction: rhs_config

	virtual function void lhs_config(uart_configuration cfg);
		cfg.active 		  = 0;
		cfg.baud_rate   = 115200;
		cfg.data_width  = 6;
		cfg.stop_bits   = 1;
		cfg.parity_mode = uart_configuration::PARITY_EVEN;
	endfunction: lhs_config

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		err_catcher.add_error_catcher_msg("Configuration missmatch stop_bits: lhs 1 vs rhs 2");
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		err_catcher.add_error_catcher_msg("Detect error on stop bit 1");
		tx_lhs_seq = uart_tx_lhs_stop_er_sequence::type_id::create("tx_lhs_seq");
		tx_rhs_seq = uart_tx_rhs_stop_er_sequence::type_id::create("tx_rhs_seq");
	  fork	
			tx_rhs_seq.start(uart_env.uart_rhs_agent.uart_seqcer); 
			//tx_lhs_seq.start(uart_env.uart_lhs_agent.uart_seqcer);
		join	
		phase.drop_objection(this);
	endtask: run_phase

endclass: rhs2lhs_diff_stop_test
