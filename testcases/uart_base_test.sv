class uart_base_test extends uvm_test;
	`uvm_component_utils(uart_base_test)

	virtual uart_if 		uart_lhs_vif;
	virtual uart_if			uart_rhs_vif;
	error_catcher				err_catcher;
	uart_environment 		uart_env;
	uart_configuration	uart_lhs_config;
	uart_configuration	uart_rhs_config;

	//-------------------------------------
	// Constructor
	//-------------------------------------
	function new(string name = "uart_base_test", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	//-------------------------------------
	// Function: build_phase
	//-------------------------------------
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uart_env 				= uart_environment::type_id::create("uart_env",this);
		uart_lhs_config = uart_configuration::type_id::create("uart_lhs_config");
		uart_rhs_config = uart_configuration::type_id::create("uart_rhs_config");
		err_catcher			= error_catcher::type_id::create("err_catcher");

		// get virtual interface
		if(!uvm_config_db #(virtual uart_if)::get(this,"","lhs_vif",uart_lhs_vif))
			`uvm_fatal(get_type_name(),"failed to get interface from uvm_config_db")
		if(!uvm_config_db #(virtual uart_if)::get(this,"","rhs_vif",uart_rhs_vif))
			`uvm_fatal(get_type_name(),"failed to get interface from uvm_config_db")	
		
		uvm_report_cb::add(null,err_catcher);

		lhs_config(uart_lhs_config);
		`uvm_info(get_type_name(),$sformatf("Configure lhs agent: \n %0s",uart_lhs_config.sprint()),UVM_LOW)
		rhs_config(uart_rhs_config);
		`uvm_info(get_type_name(),$sformatf("Configure rhs agent: \n %0s",uart_rhs_config.sprint()),UVM_LOW)

		// set virtual interface
		uvm_config_db #(virtual uart_if)::set(this,"uart_env","uart_lhs_vif",uart_lhs_vif);
		uvm_config_db #(virtual uart_if)::set(this,"uart_env","uart_rhs_vif",uart_rhs_vif);
		// set uart configuration
		uvm_config_db #(uart_configuration)::set(this,"uart_env","uart_lhs_config",uart_lhs_config);
		uvm_config_db #(uart_configuration)::set(this,"uart_env","uart_rhs_config",uart_rhs_config);
	endfunction: build_phase
	
	//----------------------------------------
	// Function: lhs_config
	//----------------------------------------
	virtual function void lhs_config(uart_configuration cfg);
	endfunction: lhs_config

	//---------------------------------------
	// Function: rhs_config
	//---------------------------------------
	virtual function void rhs_config(uart_configuration cfg);
	endfunction: rhs_config

	//----------------------------------------
	// Function: start of simulation phase
	//----------------------------------------
	virtual function void start_of_simulation_phase(uvm_phase phase);
		uvm_top.print_topology();
		// compare configuration
		if(uart_lhs_config.stop_bits != uart_rhs_config.stop_bits)
			`uvm_error(get_type_name(),$sformatf("Configuration missmatch stop_bits: lhs %0d vs rhs %0d",uart_lhs_config.stop_bits,uart_rhs_config.stop_bits))
		if(uart_lhs_config.baud_rate != uart_rhs_config.baud_rate)
			`uvm_error(get_type_name(),$sformatf("Configuration missmatch baud_rate: lhs %0d vs rhs %0d",uart_lhs_config.baud_rate,uart_rhs_config.baud_rate))
		if(uart_lhs_config.data_width != uart_rhs_config.data_width)
			`uvm_error(get_type_name(),$sformatf("Configuration missmatch data_width: lhs %0d vs rhs %0d",uart_lhs_config.data_width,uart_rhs_config.data_width))
		if(uart_lhs_config.parity_mode != uart_rhs_config.parity_mode)
			`uvm_error(get_type_name(),$sformatf("Configuration missmatch parity_mode: lhs %0s vs rhs %0s",uart_lhs_config.parity_mode.name(),uart_rhs_config.parity_mode.name()))
	endfunction: start_of_simulation_phase

endclass: uart_base_test



	
