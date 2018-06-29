set device mean
set testbench ${device}_tb

vlib work
vmap work work
vlog ${device}.v ${testbench}.sv
vsim work.${testbench}
radix -hex
add wave ./*
run -all