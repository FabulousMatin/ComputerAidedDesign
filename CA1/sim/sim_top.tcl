	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB				"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FPAddition.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FPMultiplication.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MaxSet.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegW.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegX.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RegY.sv
		
	vlog 	+acc -incr -source  +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*
	
#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	