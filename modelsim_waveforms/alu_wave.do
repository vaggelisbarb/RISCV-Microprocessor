onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/clock
add wave -noupdate /alu_tb/reset
add wave -noupdate -divider Operands
add wave -noupdate -radix decimal /alu_tb/alu_operand1
add wave -noupdate -radix decimal /alu_tb/alu_operand2
add wave -noupdate -divider Operation
add wave -noupdate /alu_tb/alu_op
add wave -noupdate -divider Result
add wave -noupdate -radix decimal /alu_tb/alu_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23710 ps} 0}
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
WaveRestoreZoom {0 ps} {131255 ps}
