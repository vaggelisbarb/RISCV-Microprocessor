onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/clock
add wave -noupdate -divider Instruction
add wave -noupdate -radix binary /control_unit_tb/opcode_in
add wave -noupdate -radix binary /control_unit_tb/funct7_in
add wave -noupdate -radix binary /control_unit_tb/funct3_in
add wave -noupdate -divider {ALU control signals}
add wave -noupdate /control_unit_tb/alu_operation
add wave -noupdate /control_unit_tb/aluData1
add wave -noupdate /control_unit_tb/aluData2
add wave -noupdate /control_unit_tb/regWrite
add wave -noupdate -divider {DMEM control signals}
add wave -noupdate /control_unit_tb/memWrite
add wave -noupdate /control_unit_tb/memRead
add wave -noupdate /control_unit_tb/mem_op_out
add wave -noupdate -divider {BRANCH signals}
add wave -noupdate /control_unit_tb/branch
add wave -noupdate /control_unit_tb/branch_comp_op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8283 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {66096 ps}
