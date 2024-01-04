	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB				    "TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer4.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer8.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Convolution.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemory.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Filter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mult.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux64to16.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux16to1.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Sum.sv
		
	vlog 	+acc -incr -source  +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB TB


#======================= adding signals to wave window ==========================


	add wave -decimal -group 	 	{TB}				sim:/$TB/*
	add wave -decimal -group 	 	{top}				sim:/$TB/cv/*	
	add wave -decimal -group -r		{all}				sim:/$TB/*
	
#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
    run -all
    mem save -outfile ./file/output.txt -dataradix hex -wordsperline 1 -noaddress /TB/cv/dm/data
	