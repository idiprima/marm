all: ana ela run wav

.PHONY : all

ana: arm_types.vhd alu.vhd barrelshift.vhd forwarding.vhd execute.vhd register_file.vhd cache.vhd decode.vhd fetch.vhd memory.vhd writeback.vhd cpu.vhd
	ghdl -a --std=93 -frelaxed-rules --mb-comments --ieee=synopsys -fexplicit arm_types.vhd alu.vhd barrelshift.vhd forwarding.vhd execute.vhd register_file.vhd cache.vhd decode.vhd fetch.vhd memory.vhd writeback.vhd cpu.vhd cpu_tb.vhd

ela: arm_types.vhd alu.vhd barrelshift.vhd forwarding.vhd execute.vhd register_file.vhd cache.vhd decode.vhd fetch.vhd memory.vhd writeback.vhd cpu.vhd
	ghdl -e --std=93 -frelaxed-rules --mb-comments --ieee=synopsys -fexplicit cpu
	ghdl -e --std=93 -frelaxed-rules --mb-comments --ieee=synopsys -fexplicit cpu_tb

run: arm_types.vhd alu.vhd barrelshift.vhd forwarding.vhd execute.vhd register_file.vhd cache.vhd decode.vhd fetch.vhd memory.vhd writeback.vhd cpu.vhd cpu_tb.vhd
	ghdl -r --std=93 -frelaxed-rules --mb-comments --ieee=synopsys -fexplicit cpu_tb --vcd=cpu.vcd 

wav: cpu.vcd
	gtkwave cpu.vcd
