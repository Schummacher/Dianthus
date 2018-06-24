set target_library {typical.db}
set link_library {* typical.db}
set symbol_library {smic18.sdb}


# read_verilog cpu.v
# read_verilog ram.v
# read_verilog top.v

read_verilog mean.v

link

create_clock -p 1 [get_ports clk]
set_dont_touch_network [get_clocks clk]

# compile

# report_timing

set_input_delay -max 0.5 -min 0.3 -clock clk [get_ports instrution_bus]
set_input_delay -max 0.5 -min 0.3 -clock clk [get_ports rst_n]


# compile

# report_timing
