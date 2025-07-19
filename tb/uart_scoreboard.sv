`uvm_analysis_imp_decl(_lhs)
`uvm_analysis_imp_decl(_rhs)
class uart_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(uart_scoreboard)

	uvm_analysis_imp_lhs #(uart_transaction, uart_scoreboard) uart_lhs_export;
	uvm_analysis_imp_rhs #(uart_transaction, uart_scoreboard) uart_rhs_export;

	uart_configuration uart_lhs_config;
	uart_configuration uart_rhs_config;

	uart_transaction tx_lhs[$];
	uart_transaction rx_lhs[$];
	uart_transaction tx_rhs[$];
	uart_transaction rx_rhs[$];

	//------------------------------------
 	// Constructor
	//------------------------------------
	function new(string name = "uart_scoreboard", uvm_component parent);
		super.new(name, parent);
	endfunction: new

	//-------------------------------------
	// Function: build_phase
	//-------------------------------------
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uart_lhs_export = new("uart_lhs_export",this);
		uart_rhs_export = new("uart_rhs_export",this);
		if(!uvm_config_db #(uart_configuration)::get(this,"","uart_lhs_config",uart_lhs_config))
			`uvm_fatal(get_type_name(),$sformatf("Failed to get configuration from uvm_config_db. Please check!"))
		if(!uvm_config_db #(uart_configuration)::get(this,"","uart_rhs_config",uart_rhs_config))
			`uvm_fatal(get_type_name(),$sformatf("Failed to get configuration from uvm_config_db. Please check!"))
	endfunction: build_phase
	
	//------------------------------------
	// Function: write_lhs
	//------------------------------------
	virtual function void write_lhs(uart_transaction uart_trans);
		if(uart_trans.direction == uart_transaction::DIR_RX) begin
			rx_lhs.push_back(uart_trans);
			`uvm_info(get_type_name(),$sformatf("Received transaction: \n %s",uart_trans.sprint()), UVM_LOW)
		end
		else begin
			tx_lhs.push_back(uart_trans);
			`uvm_info(get_type_name(),$sformatf("Received transaction: \n %s",uart_trans.sprint()), UVM_LOW)
		end
	endfunction: write_lhs

	//------------------------------------
	// Function: write_rhs
	//-----------------------------------
	virtual function void write_rhs(uart_transaction uart_trans);
		if(uart_trans.direction == uart_transaction::DIR_RX) begin
			rx_rhs.push_back(uart_trans);
			`uvm_info(get_type_name(),$sformatf("Received transaction: \n %s",uart_trans.sprint()), UVM_LOW)
		end
		else begin
			tx_rhs.push_back(uart_trans);
			`uvm_info(get_type_name(),$sformatf("Received transaction: \n %s",uart_trans.sprint()), UVM_LOW)
		end
	endfunction: write_rhs
	
	//-----------------------------------
	// Task: run_phase
	//----------------------------------
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			uart_transaction tx_lhs_trans, rx_rhs_trans;
			uart_transaction tx_rhs_trans, rx_lhs_trans;

			wait((tx_lhs.size() > 0 && rx_rhs.size() > 0) || (tx_rhs.size() > 0 && rx_lhs.size() > 0));
			if(tx_lhs.size() > 0 && rx_rhs.size() > 0) begin
				tx_lhs_trans = tx_lhs.pop_front();
				rx_rhs_trans = rx_rhs.pop_front();
				check_data_lhs2rhs(tx_lhs_trans, rx_rhs_trans);
			end
			else begin
				rx_lhs_trans = rx_lhs.pop_front();
				tx_rhs_trans = tx_rhs.pop_front();
				check_data_rhs2lhs(tx_rhs_trans, rx_lhs_trans);
			end
		end
	endtask: run_phase
	
	//----------------------------------------
	// Function: check_data_lhs2rhs
	//----------------------------------------
	function void check_data_lhs2rhs(uart_transaction uart_exp_trans, uart_transaction uart_act_trans);
		// Check data bit
		if(uart_lhs_config.data_error) begin
			`uvm_info(get_type_name(),$sformatf("Data of TX LHS after inject data error: %0h",uart_exp_trans.data),UVM_LOW);
			uart_exp_trans.data[uart_lhs_config.data_er_pos] = ~uart_exp_trans.data[uart_lhs_config.data_er_pos];
			`uvm_info(get_type_name(),$sformatf("Data of TX LHS before inject data error: %0h",uart_exp_trans.data),UVM_LOW);
		end
		if(uart_exp_trans.data == uart_act_trans.data)
			`uvm_info(get_type_name(),"Data match",UVM_LOW)
		else
			`uvm_error(get_type_name(),"Data not match")
	endfunction: check_data_lhs2rhs

	//----------------------------------------
	// Function: check_data_rhs2lhs
	//----------------------------------------
	function void check_data_rhs2lhs(uart_transaction uart_exp_trans, uart_transaction uart_act_trans);
		// Check data bit
		if(uart_rhs_config.data_error) begin
			`uvm_info(get_type_name(),$sformatf("Data of TX RHS after inject data error: %0h",uart_exp_trans.data),UVM_LOW);
			uart_exp_trans.data[uart_rhs_config.data_er_pos] = ~uart_exp_trans.data[uart_rhs_config.data_er_pos];
			`uvm_info(get_type_name(),$sformatf("Data of TX RHS before inject data error: %0h",uart_exp_trans.data),UVM_LOW);
		end
		if(uart_exp_trans.data == uart_act_trans.data)
			`uvm_info(get_type_name(),"Data match",UVM_LOW)
		else
			`uvm_error(get_type_name(),"Data not match")
	endfunction: check_data_rhs2lhs

endclass: uart_scoreboard
