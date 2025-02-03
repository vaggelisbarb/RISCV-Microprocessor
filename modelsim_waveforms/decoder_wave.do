onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decoder_tb/clock
add wave -noupdate -divider {Setup signals}
add wave -noupdate /decoder_tb/reset
add wave -noupdate /decoder_tb/flush
add wave -noupdate /decoder_tb/stall
add wave -noupdate -divider Instruction
add wave -noupdate /decoder_tb/pc_in
add wave -noupdate /decoder_tb/instruction
add wave -noupdate -divider {Instrution Format signals}
add wave -noupdate -radix binary /decoder_tb/opcode
add wave -noupdate -radix binary /decoder_tb/funct7
add wave -noupdate -radix binary /decoder_tb/funct3
add wave -noupdate -radix unsigned /decoder_tb/rs1
add wave -noupdate -radix unsigned /decoder_tb/rs2
add wave -noupdate -radix unsigned /decoder_tb/rd
add wave -noupdate -radix decimal /decoder_tb/immediate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14580 ps} 0}
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
WaveRestoreZoom {0 ps} {127797 ps}
