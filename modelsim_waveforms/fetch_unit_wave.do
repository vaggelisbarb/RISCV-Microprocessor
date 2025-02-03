onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fetch_unit_tb/clock
add wave -noupdate /fetch_unit_tb/stage_in
add wave -noupdate -divider {Control signals}
add wave -noupdate /fetch_unit_tb/reset
add wave -noupdate /fetch_unit_tb/stall
add wave -noupdate -divider {Instruction signals}
add wave -noupdate /fetch_unit_tb/PC_in
add wave -noupdate /fetch_unit_tb/PC_out
add wave -noupdate /fetch_unit_tb/instruction
add wave -noupdate /fetch_unit_tb/UUT/current_pc
add wave -noupdate /fetch_unit_tb/UUT/next_pc
add wave -noupdate -divider {Branch signals}
add wave -noupdate /fetch_unit_tb/branch
add wave -noupdate /fetch_unit_tb/branch_target
add wave -noupdate -divider {Mem connection signals}
add wave -noupdate /fetch_unit_tb/imem_instruction
add wave -noupdate /fetch_unit_tb/imem_request
add wave -noupdate /fetch_unit_tb/imem_next_addr
add wave -noupdate /fetch_unit_tb/IMEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40492 ps} 0}
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
WaveRestoreZoom {31907 ps} {121938 ps}
