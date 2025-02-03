onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_control_unit_tb/clock
add wave -noupdate -divider {Input signals}
add wave -noupdate /alu_control_unit_tb/opcode_in
add wave -noupdate /alu_control_unit_tb/funct7_in
add wave -noupdate /alu_control_unit_tb/funct3_in
add wave -noupdate -divider {Operation signal}
add wave -noupdate /alu_control_unit_tb/alu_operation_out
add wave -noupdate -divider {Output signal}
add wave -noupdate /alu_control_unit_tb/aluData1_out
add wave -noupdate /alu_control_unit_tb/aluData2_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
