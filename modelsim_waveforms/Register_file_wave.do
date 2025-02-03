onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Setup signals}
add wave -noupdate /register_file_tb/clock
add wave -noupdate /register_file_tb/clk_period
add wave -noupdate -radix hexadecimal /register_file_tb/enable_in
add wave -noupdate -divider {Reg selection}
add wave -noupdate -radix decimal /register_file_tb/selA
add wave -noupdate -radix decimal /register_file_tb/selB
add wave -noupdate -radix decimal /register_file_tb/selD
add wave -noupdate -divider {WR signals}
add wave -noupdate -radix decimal /register_file_tb/write_enable
add wave -noupdate -radix hexadecimal /register_file_tb/rD_data_in
add wave -noupdate -divider {Data Output}
add wave -noupdate -radix hexadecimal /register_file_tb/dataA_out
add wave -noupdate -radix hexadecimal /register_file_tb/dataB_out
add wave -noupdate -radix hexadecimal -childformat {{/register_file_tb/uut/regs_file(0) -radix hexadecimal} {/register_file_tb/uut/regs_file(1) -radix hexadecimal} {/register_file_tb/uut/regs_file(2) -radix hexadecimal} {/register_file_tb/uut/regs_file(3) -radix hexadecimal} {/register_file_tb/uut/regs_file(4) -radix hexadecimal} {/register_file_tb/uut/regs_file(5) -radix hexadecimal} {/register_file_tb/uut/regs_file(6) -radix hexadecimal} {/register_file_tb/uut/regs_file(7) -radix hexadecimal} {/register_file_tb/uut/regs_file(8) -radix hexadecimal} {/register_file_tb/uut/regs_file(9) -radix hexadecimal} {/register_file_tb/uut/regs_file(10) -radix hexadecimal} {/register_file_tb/uut/regs_file(11) -radix hexadecimal} {/register_file_tb/uut/regs_file(12) -radix hexadecimal} {/register_file_tb/uut/regs_file(13) -radix hexadecimal} {/register_file_tb/uut/regs_file(14) -radix hexadecimal} {/register_file_tb/uut/regs_file(15) -radix hexadecimal} {/register_file_tb/uut/regs_file(16) -radix hexadecimal} {/register_file_tb/uut/regs_file(17) -radix hexadecimal} {/register_file_tb/uut/regs_file(18) -radix hexadecimal} {/register_file_tb/uut/regs_file(19) -radix hexadecimal} {/register_file_tb/uut/regs_file(20) -radix hexadecimal} {/register_file_tb/uut/regs_file(21) -radix hexadecimal} {/register_file_tb/uut/regs_file(22) -radix hexadecimal} {/register_file_tb/uut/regs_file(23) -radix hexadecimal} {/register_file_tb/uut/regs_file(24) -radix hexadecimal} {/register_file_tb/uut/regs_file(25) -radix hexadecimal} {/register_file_tb/uut/regs_file(26) -radix hexadecimal} {/register_file_tb/uut/regs_file(27) -radix hexadecimal} {/register_file_tb/uut/regs_file(28) -radix hexadecimal} {/register_file_tb/uut/regs_file(29) -radix hexadecimal} {/register_file_tb/uut/regs_file(30) -radix hexadecimal} {/register_file_tb/uut/regs_file(31) -radix hexadecimal}} -expand -subitemconfig {/register_file_tb/uut/regs_file(0) {-radix hexadecimal} /register_file_tb/uut/regs_file(1) {-radix hexadecimal} /register_file_tb/uut/regs_file(2) {-radix hexadecimal} /register_file_tb/uut/regs_file(3) {-radix hexadecimal} /register_file_tb/uut/regs_file(4) {-radix hexadecimal} /register_file_tb/uut/regs_file(5) {-radix hexadecimal} /register_file_tb/uut/regs_file(6) {-radix hexadecimal} /register_file_tb/uut/regs_file(7) {-radix hexadecimal} /register_file_tb/uut/regs_file(8) {-radix hexadecimal} /register_file_tb/uut/regs_file(9) {-radix hexadecimal} /register_file_tb/uut/regs_file(10) {-radix hexadecimal} /register_file_tb/uut/regs_file(11) {-radix hexadecimal} /register_file_tb/uut/regs_file(12) {-radix hexadecimal} /register_file_tb/uut/regs_file(13) {-radix hexadecimal} /register_file_tb/uut/regs_file(14) {-radix hexadecimal} /register_file_tb/uut/regs_file(15) {-radix hexadecimal} /register_file_tb/uut/regs_file(16) {-radix hexadecimal} /register_file_tb/uut/regs_file(17) {-radix hexadecimal} /register_file_tb/uut/regs_file(18) {-radix hexadecimal} /register_file_tb/uut/regs_file(19) {-radix hexadecimal} /register_file_tb/uut/regs_file(20) {-radix hexadecimal} /register_file_tb/uut/regs_file(21) {-radix hexadecimal} /register_file_tb/uut/regs_file(22) {-radix hexadecimal} /register_file_tb/uut/regs_file(23) {-radix hexadecimal} /register_file_tb/uut/regs_file(24) {-radix hexadecimal} /register_file_tb/uut/regs_file(25) {-radix hexadecimal} /register_file_tb/uut/regs_file(26) {-radix hexadecimal} /register_file_tb/uut/regs_file(27) {-radix hexadecimal} /register_file_tb/uut/regs_file(28) {-radix hexadecimal} /register_file_tb/uut/regs_file(29) {-radix hexadecimal} /register_file_tb/uut/regs_file(30) {-radix hexadecimal} /register_file_tb/uut/regs_file(31) {-radix hexadecimal}} /register_file_tb/uut/regs_file
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86669 ps} 0}
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
WaveRestoreZoom {0 ps} {426677 ps}
