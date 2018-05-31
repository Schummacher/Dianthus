#!/bin/csh

if (${1} == ram) then
	vcs ram_tb.sv ram.v +v2k -full64 -debug_all -o aaa
else if (${1} == cpu) then
	vcs cpu_tb.sv cpu.v lfsr.v +v2k -full64 -debug_all -o aaa
else if (${1} == top) then
	vcs top_tb.sv top.v cpu.v ram.v +v2k -full64 -debug_all -o aaa
else if (${1} == lfsr) then
	vcs lfsr_tb.sv lfsr.v +v2k -full64 -debug_all -o aaa
endif

if("" == "${1}") then
	echo please input simulate file
else
	./aaa -gui & 
endif
ed:
