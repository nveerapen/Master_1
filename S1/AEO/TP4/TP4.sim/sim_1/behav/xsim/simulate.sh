#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Oct 10 11:26:20 CEST 2018
# SW Build 2288692 on Thu Jul 26 18:23:50 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xsim chenillard_behav -key {Behavioral:sim_1:Functional:chenillard} -tclbatch chenillard.tcl -log simulate.log