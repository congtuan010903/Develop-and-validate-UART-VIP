class uart_environment extends uvm_env;
	`uvm_component_utils(uart_environment)

	virtual uart_if uart_lhs_vif;
	virtual uart_if	uart_rhs_vif;

	uart_agent uart_lhs_agent;
	uart_agent uart_rhs_agent;

	uart_configuration uart_lhs_config;
	uart_configuration uart_rhs_config;

	uart_scoreboard		 uart_sb;

	//----------------------------------
	// Constructor
	//----------------------------------
	function new(string name = "uart_environment", uvm_component parent);
		super.new(name, parent);
	endfunction: new

	//----------------------------------
	// Function: build_phase
	//----------------------------------
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		// get virtual interface
		if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_lhs_vif",uart_lhs_vif))
			`uvm_fatal(get_type_name(),"Failed to get lsh virtual interface")
		if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_rhs_vif",uart_rhs_vif))
			`uvm_fatal(get_type_name(),"Failed to get rhs virtual interface")
		// get uart configuration
		if(!uvm_config_db #(uart_configuration)::get(this,"","uart_lhs_config",uart_lhs_config))
			`uvm_fatal(get_type_name(),"Failed to get lhs configuration")
		if(!uvm_config_db #(uart_configuration)::get(this,"","uart_rhs_config",uart_rhs_config))
			`uvm_fatal(get_type_name(),"Failed to get rhs configuration")
		
		uart_lhs_agent = uart_agent::type_id::create("uart_lhs_agent",this);
		uart_rhs_agent = uart_agent::type_id::create("uart_rhs_agent",this);
		uart_sb				 = uart_scoreboard::type_id::create("uart_sb",this);
	
		// set virtual interface
		uvm_config_db #(virtual uart_if)::set(this,"uart_lhs_agent","uart_vif",uart_lhs_vif);
		uvm_config_db #(virtual uart_if)::set(this,"uart_rhs_agent","uart_vif",uart_rhs_vif);
		// set uart configuration
		uvm_config_db #(uart_configuration)::set(this,"uart_lhs_agent","uart_config",uart_lhs_config);
		uvm_config_db #(uart_configuration)::set(this,"uart_rhs_agent","uart_config",uart_rhs_config);
		uvm_config_db #(uart_configuration)::set(this,"uart_sb","uart_lhs_config",uart_lhs_config);
		uvm_config_db #(uart_configuration)::set(this,"uart_sb","uart_rhs_config",uart_rhs_config);
	endfunction: build_phase

	//----------------------------------------
	// Function: connect_phase
	//----------------------------------------
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		uart_lhs_agent.uart_mon.item_observed_port.connect(uart_sb.uart_lhs_export);
		uart_rhs_agent.uart_mon.item_observed_port.connect(uart_sb.uart_rhs_export);
	endfunction: connect_phase
		
endclass: uart_environment
