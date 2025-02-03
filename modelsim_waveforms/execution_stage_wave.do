onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /execution_stage_tb/clock
add wave -noupdate -divider {Instruction Addr}
add wave -noupdate -radix hexadecimal /execution_stage_tb/pc_in
add wave -noupdate -divider {Control Signals}
add wave -noupdate /execution_stage_tb/reset
add wave -noupdate /execution_stage_tb/flush
add wave -noupdate /execution_stage_tb/stall
add wave -noupdate -divider {1st operand}
add wave -noupdate -radix unsigned /execution_stage_tb/rs1_reg_in
add wave -noupdate -radix decimal /execution_stage_tb/rs1_data_in
add wave -noupdate /execution_stage_tb/rs1_source_in
add wave -noupdate -divider {2nd operand}
add wave -noupdate -radix unsigned /execution_stage_tb/rs2_reg_in
add wave -noupdate -radix decimal /execution_stage_tb/rs2_data_in
add wave -noupdate /execution_stage_tb/rs2_source_in
add wave -noupdate -divider Immediate
add wave -noupdate /execution_stage_tb/immediate_in
add wave -noupdate -divider {ALU operation}
add wave -noupdate /execution_stage_tb/alu_operation_in
add wave -noupdate -divider {Other signals}
add wave -noupdate /execution_stage_tb/regWrite_in
add wave -noupdate /execution_stage_tb/branch_in
add wave -noupdate -divider {Forward MEM-EXE}
add wave -noupdate /execution_stage_tb/mem_rd_write_in
add wave -noupdate -radix unsigned /execution_stage_tb/mem_rd_reg_in
add wave -noupdate -radix decimal /execution_stage_tb/mem_rd_data_in
add wave -noupdate -divider {Forward WB-EXE}
add wave -noupdate /execution_stage_tb/wb_rd_write_in
add wave -noupdate -radix unsigned /execution_stage_tb/wb_rd_reg_in
add wave -noupdate -radix decimal /execution_stage_tb/wb_rd_data_in
add wave -noupdate -divider Output
add wave -noupdate -divider {Destination register}
add wave -noupdate -radix unsigned /execution_stage_tb/rd_reg_out
add wave -noupdate -radix decimal /execution_stage_tb/rd_data_out
add wave -noupdate /execution_stage_tb/regWrite_out
add wave -noupdate -divider {Branch_O signals}
add wave -noupdate /execution_stage_tb/branch_out
add wave -noupdate /execution_stage_tb/jump_out
add wave -noupdate /execution_stage_tb/jump_target_out
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {47522 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {41952 ps} {131676 ps}
