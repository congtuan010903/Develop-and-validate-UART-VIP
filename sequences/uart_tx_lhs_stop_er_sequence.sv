class uart_tx_lhs_stop_er_sequence extends uvm_sequence #(uart_transaction);
	`uvm_object_utils(uart_tx_lhs_stop_er_sequence)

	function new(string name = "uart_tx_lhs_stop_er_sequence");
		super.new(name);
	endfunction: new
	
	//-----------------------------------
	// Task: body
	//-----------------------------------
	virtual task body();	
		uart_transaction tx;
		tx = uart_transaction::type_id::create("tx");

		start_item(tx);
		if(!tx.randomize() with
		{
			direction == uart_transaction::DIR_TX;
			stop == 2'b11;
			stop_error == 1;
		}) begin
			`uvm_error(get_type_name(),"Randomize fail")
		end

		finish_item(tx);
		`uvm_info(get_type_name(), $sformatf("Sent transaction: \n %0s",tx.sprint()),UVM_LOW)
		#100;
	endtask: body

endclass: uart_tx_lhs_stop_er_sequence
