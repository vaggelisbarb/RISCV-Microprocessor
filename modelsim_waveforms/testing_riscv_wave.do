onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_tb/clock
add wave -noupdate /processor_tb/reset
add wave -noupdate -divider -height 25 FETCH
add wave -noupdate /processor_tb/UUT/fetch_inst/stall
add wave -noupdate /processor_tb/UUT/fetch_inst/flush
add wave -noupdate /processor_tb/UUT/fetch_inst/PC_out
add wave -noupdate /processor_tb/UUT/i_mem_inst/imem_data_out
add wave -noupdate /processor_tb/UUT/fetch_inst/imem_next_addr
add wave -noupdate /processor_tb/UUT/fetch_inst/branch
add wave -noupdate /processor_tb/UUT/fetch_inst/branch_target
add wave -noupdate -divider -height 25 DECODE
add wave -noupdate /processor_tb/UUT/decode/stall
add wave -noupdate /processor_tb/UUT/decode/flush
add wave -noupdate /processor_tb/UUT/decode/instruction_to_decode
add wave -noupdate /processor_tb/UUT/control_unit_inst/alu_operation
add wave -noupdate /processor_tb/UUT/control_unit_inst/regWrite
add wave -noupdate /processor_tb/UUT/control_unit_inst/memRead
add wave -noupdate /processor_tb/UUT/control_unit_inst/memWrite
add wave -noupdate /processor_tb/UUT/control_unit_inst/mem_op_out
add wave -noupdate /processor_tb/UUT/control_unit_inst/branch
add wave -noupdate /processor_tb/UUT/control_unit_inst/branch_comp_op
add wave -noupdate -divider -height 25 {REGISTERS FILE}
add wave -noupdate /processor_tb/UUT/reg_file_inst/rs1_reg
add wave -noupdate /processor_tb/UUT/reg_file_inst/rs2_reg
add wave -noupdate /processor_tb/UUT/reg_file_inst/rs1_data
add wave -noupdate /processor_tb/UUT/reg_file_inst/rs2_data
add wave -noupdate /processor_tb/UUT/reg_file_inst/rd_write_enable
add wave -noupdate /processor_tb/UUT/reg_file_inst/rd_reg
add wave -noupdate /processor_tb/UUT/reg_file_inst/rd_data
add wave -noupdate /processor_tb/UUT/reg_file_inst/regs_file
add wave -noupdate -divider -height 25 EXECUTION
add wave -noupdate /processor_tb/UUT/exe_stage_unit/stall
add wave -noupdate /processor_tb/UUT/exe_stage_unit/flush
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs1_reg_in
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs1_source_in
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs1_data_in
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs2_reg_in
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs2_source_in
add wave -noupdate /processor_tb/UUT/exe_stage_unit/rs2_data_in
add wave -noupdate -divider -height 25 MEMORY
add wave -noupdate /processor_tb/UUT/dmem_inst/dmem_addr_in
add wave -noupdate /processor_tb/UUT/dmem_inst/dmem_read_in
add wave -noupdate /processor_tb/UUT/dmem_inst/dmem_write_in
add wave -noupdate /processor_tb/UUT/dmem_inst/dmem_data_in
add wave -noupdate /processor_tb/UUT/dmem_inst/dmem_op_in
add wave -noupdate /processor_tb/UUT/dmem_inst/rd_reg_out
add wave -noupdate /processor_tb/UUT/dmem_inst/rd_data_out
add wave -noupdate -divider WRITEBACK
add wave -noupdate /processor_tb/UUT/writeback_stage/rd_write_out
add wave -noupdate /processor_tb/UUT/writeback_stage/rd_reg_out
add wave -noupdate /processor_tb/UUT/writeback_stage/rd_data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4667 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
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
WaveRestoreZoom {0 ps} {92743 ps}
