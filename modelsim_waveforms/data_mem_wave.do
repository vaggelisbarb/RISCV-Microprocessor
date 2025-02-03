onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_memory_tb/clock
add wave -noupdate /data_memory_tb/reset
add wave -noupdate /data_memory_tb/stall
add wave -noupdate -divider {Mem signals}
add wave -noupdate -radix hexadecimal /data_memory_tb/mem_addr_in
add wave -noupdate -radix hexadecimal /data_memory_tb/mem_data_in
add wave -noupdate /data_memory_tb/mem_read_in
add wave -noupdate -divider {W/R signals}
add wave -noupdate /data_memory_tb/mem_write_in
add wave -noupdate /data_memory_tb/mem_op_in
add wave -noupdate -radix decimal /data_memory_tb/rd_reg_in
add wave -noupdate -divider {Output signals}
add wave -noupdate -radix hexadecimal /data_memory_tb/mem_data_out
add wave -noupdate /data_memory_tb/mem_op_out
add wave -noupdate /data_memory_tb/rd_write_out
add wave -noupdate -radix decimal /data_memory_tb/rd_reg_out
add wave -noupdate -divider -height 24 Memory
add wave -noupdate -radix hexadecimal /data_memory_tb/UUT/D_MEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60520 ps} 0}
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
WaveRestoreZoom {44763 ps} {165776 ps}
