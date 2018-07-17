#!/bin/bash

design=
vcs_do=
device=
top=
tesbench=
interface=
mode=gui

while [ $# != 0 ]
do
# 	echo $#
	case ${1} in
	-d | --design)
		shift
		design=${1}
		;;
	-t | --test_initial)
		shift
		vcs_do=${1}
		;;
	-m | --mode)
		shift
		mode=${1}
		;;
	-v | --version)
		echo sorry the version is yourself
		exit
		;;
	*)
		echo you input error var $1
		exit
		;;
	esac
	shift
done

# echo $design $vcs_do
# exit

if [ "" = "${design}" ] 
then
	echo please input simulate file
	exit
fi

if [ ${design} = "ram" ] 
then
	testbench='ram_tb.sv'
	device='ram.v'
	# files='ram_t.sv ram_if.sv ctrl_if.sv ram_tb.sv ram.v'
elif [ ${design} = "cpu" ] 
then
	testbench='cpu_tb.sv'
	device='cpu.v lfsr.v'
	# files='cpu_tb.sv cpu.v lfsr.v'
elif [ ${design} = "top" ] 
then
	device='top_tb.sv top.v cpu.v ram.v'
elif [ ${design} = "lfsr" ] 
then
	device='lfsr_tb.sv lfsr.v'
elif [ ${design} = "mean" ] 
then
	testbench='mean_tb.sv'
	device='mean.v'
elif [ ${design} = "mean_p" ] 
then
	testbench='mean_param_tb.sv'
	device='mean_param.v'
elif [ ${design} = "f_div" ] 
then
	testbench='f_div_tb.sv'
	device='f_div.v'
else
	echo you input an error design name ${design}
	exit
fi

files="$testbench $device"
vcs $files +v2k -sverilog -full64 -debug_all -o aaa > compile.log
cat compile.log | grep Warning
cat compile.log | grep Error

x=yes
while [[ $x != y && $x != n && $x != yes && $x != no ]]
do
	echo -n do you want to start simulation: 
	read x
done

if [[ ${vcs_do} = "" ]]
then
	vcs_do=
else
	vcs_do="-do ${vcs_do}.tcl"
fi

if [[ $x  =  'y' || $x  =  'yes' ]] 
then
	if [[ ${mode} = 'cli' ]]
	then
		mode=
	fi
	./aaa -${mode} ${vcs_do} &
elif [[ $x  =  'n' || $x  =  'no' ]] 
then
	echo thanks using
fi
#to be continu
