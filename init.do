vlib work
vmap work work
vlog cpu.v cpu_tb.sv lfsr.v
vsim work.cpu_tb
radix -hex
add wave cpu_tb/*
run -all