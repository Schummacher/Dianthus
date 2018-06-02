#!/bin/bash

design=
vcs_do=

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
	files='ram_tb.sv ram.v'
elif [ ${design} = "cpu" ] 
then
	files='cpu_tb.sv cpu.v lfsr.v'
elif [ ${design} = "top" ] 
then
	files='top_tb.sv top.v cpu.v ram.v'
elif [ ${design} = "lfsr" ] 
then
	files='lfsr_tb.sv lfsr.v'
else
	echo you input an error design name ${design}
	exit
fi

vcs $files +v2k -full64 -debug_all -o aaa > compile.log
cat compile.log | grep Warning

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
	./aaa -gui ${vcs_do} &
elif [[ $x  =  'n' || $x  =  'no' ]] 
then
	echo thanks using
fi