	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/_ACT_C1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/_ACT_C2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/_ACT_S2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Abs.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND6.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ArrayMUX2.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Comparator.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FullAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Maxnet.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/NOT.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OneHotMux4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OneHotMux6.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR6.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/REG.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegW.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegY.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegX.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TwosComp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR2.v

		
	vlog 	+acc -incr -source  +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -bin -group 	 	{TB}				sim:/$TB/*

	
#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	run -all
	