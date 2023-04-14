###################################################################

# Created by write_sdc on Thu Apr 13 20:18:11 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports {node0_pc_out[0]}]
set_max_delay 5  -to [get_ports {node0_pc_out[1]}]
set_max_delay 5  -to [get_ports {node0_pc_out[2]}]
set_max_delay 5  -to [get_ports {node0_pc_out[3]}]
set_max_delay 5  -to [get_ports {node0_pc_out[4]}]
set_max_delay 5  -to [get_ports {node0_pc_out[5]}]
set_max_delay 5  -to [get_ports {node0_pc_out[6]}]
set_max_delay 5  -to [get_ports {node0_pc_out[7]}]
set_max_delay 5  -to [get_ports {node0_pc_out[8]}]
set_max_delay 5  -to [get_ports {node0_pc_out[9]}]
set_max_delay 5  -to [get_ports {node0_pc_out[10]}]
set_max_delay 5  -to [get_ports {node0_pc_out[11]}]
set_max_delay 5  -to [get_ports {node0_pc_out[12]}]
set_max_delay 5  -to [get_ports {node0_pc_out[13]}]
set_max_delay 5  -to [get_ports {node0_pc_out[14]}]
set_max_delay 5  -to [get_ports {node0_pc_out[15]}]
set_max_delay 5  -to [get_ports {node0_pc_out[16]}]
set_max_delay 5  -to [get_ports {node0_pc_out[17]}]
set_max_delay 5  -to [get_ports {node0_pc_out[18]}]
set_max_delay 5  -to [get_ports {node0_pc_out[19]}]
set_max_delay 5  -to [get_ports {node0_pc_out[20]}]
set_max_delay 5  -to [get_ports {node0_pc_out[21]}]
set_max_delay 5  -to [get_ports {node0_pc_out[22]}]
set_max_delay 5  -to [get_ports {node0_pc_out[23]}]
set_max_delay 5  -to [get_ports {node0_pc_out[24]}]
set_max_delay 5  -to [get_ports {node0_pc_out[25]}]
set_max_delay 5  -to [get_ports {node0_pc_out[26]}]
set_max_delay 5  -to [get_ports {node0_pc_out[27]}]
set_max_delay 5  -to [get_ports {node0_pc_out[28]}]
set_max_delay 5  -to [get_ports {node0_pc_out[29]}]
set_max_delay 5  -to [get_ports {node0_pc_out[30]}]
set_max_delay 5  -to [get_ports {node0_pc_out[31]}]
set_max_delay 5  -to [get_ports {node1_pc_out[0]}]
set_max_delay 5  -to [get_ports {node1_pc_out[1]}]
set_max_delay 5  -to [get_ports {node1_pc_out[2]}]
set_max_delay 5  -to [get_ports {node1_pc_out[3]}]
set_max_delay 5  -to [get_ports {node1_pc_out[4]}]
set_max_delay 5  -to [get_ports {node1_pc_out[5]}]
set_max_delay 5  -to [get_ports {node1_pc_out[6]}]
set_max_delay 5  -to [get_ports {node1_pc_out[7]}]
set_max_delay 5  -to [get_ports {node1_pc_out[8]}]
set_max_delay 5  -to [get_ports {node1_pc_out[9]}]
set_max_delay 5  -to [get_ports {node1_pc_out[10]}]
set_max_delay 5  -to [get_ports {node1_pc_out[11]}]
set_max_delay 5  -to [get_ports {node1_pc_out[12]}]
set_max_delay 5  -to [get_ports {node1_pc_out[13]}]
set_max_delay 5  -to [get_ports {node1_pc_out[14]}]
set_max_delay 5  -to [get_ports {node1_pc_out[15]}]
set_max_delay 5  -to [get_ports {node1_pc_out[16]}]
set_max_delay 5  -to [get_ports {node1_pc_out[17]}]
set_max_delay 5  -to [get_ports {node1_pc_out[18]}]
set_max_delay 5  -to [get_ports {node1_pc_out[19]}]
set_max_delay 5  -to [get_ports {node1_pc_out[20]}]
set_max_delay 5  -to [get_ports {node1_pc_out[21]}]
set_max_delay 5  -to [get_ports {node1_pc_out[22]}]
set_max_delay 5  -to [get_ports {node1_pc_out[23]}]
set_max_delay 5  -to [get_ports {node1_pc_out[24]}]
set_max_delay 5  -to [get_ports {node1_pc_out[25]}]
set_max_delay 5  -to [get_ports {node1_pc_out[26]}]
set_max_delay 5  -to [get_ports {node1_pc_out[27]}]
set_max_delay 5  -to [get_ports {node1_pc_out[28]}]
set_max_delay 5  -to [get_ports {node1_pc_out[29]}]
set_max_delay 5  -to [get_ports {node1_pc_out[30]}]
set_max_delay 5  -to [get_ports {node1_pc_out[31]}]
set_max_delay 5  -to [get_ports {node2_pc_out[0]}]
set_max_delay 5  -to [get_ports {node2_pc_out[1]}]
set_max_delay 5  -to [get_ports {node2_pc_out[2]}]
set_max_delay 5  -to [get_ports {node2_pc_out[3]}]
set_max_delay 5  -to [get_ports {node2_pc_out[4]}]
set_max_delay 5  -to [get_ports {node2_pc_out[5]}]
set_max_delay 5  -to [get_ports {node2_pc_out[6]}]
set_max_delay 5  -to [get_ports {node2_pc_out[7]}]
set_max_delay 5  -to [get_ports {node2_pc_out[8]}]
set_max_delay 5  -to [get_ports {node2_pc_out[9]}]
set_max_delay 5  -to [get_ports {node2_pc_out[10]}]
set_max_delay 5  -to [get_ports {node2_pc_out[11]}]
set_max_delay 5  -to [get_ports {node2_pc_out[12]}]
set_max_delay 5  -to [get_ports {node2_pc_out[13]}]
set_max_delay 5  -to [get_ports {node2_pc_out[14]}]
set_max_delay 5  -to [get_ports {node2_pc_out[15]}]
set_max_delay 5  -to [get_ports {node2_pc_out[16]}]
set_max_delay 5  -to [get_ports {node2_pc_out[17]}]
set_max_delay 5  -to [get_ports {node2_pc_out[18]}]
set_max_delay 5  -to [get_ports {node2_pc_out[19]}]
set_max_delay 5  -to [get_ports {node2_pc_out[20]}]
set_max_delay 5  -to [get_ports {node2_pc_out[21]}]
set_max_delay 5  -to [get_ports {node2_pc_out[22]}]
set_max_delay 5  -to [get_ports {node2_pc_out[23]}]
set_max_delay 5  -to [get_ports {node2_pc_out[24]}]
set_max_delay 5  -to [get_ports {node2_pc_out[25]}]
set_max_delay 5  -to [get_ports {node2_pc_out[26]}]
set_max_delay 5  -to [get_ports {node2_pc_out[27]}]
set_max_delay 5  -to [get_ports {node2_pc_out[28]}]
set_max_delay 5  -to [get_ports {node2_pc_out[29]}]
set_max_delay 5  -to [get_ports {node2_pc_out[30]}]
set_max_delay 5  -to [get_ports {node2_pc_out[31]}]
set_max_delay 5  -to [get_ports {node3_pc_out[0]}]
set_max_delay 5  -to [get_ports {node3_pc_out[1]}]
set_max_delay 5  -to [get_ports {node3_pc_out[2]}]
set_max_delay 5  -to [get_ports {node3_pc_out[3]}]
set_max_delay 5  -to [get_ports {node3_pc_out[4]}]
set_max_delay 5  -to [get_ports {node3_pc_out[5]}]
set_max_delay 5  -to [get_ports {node3_pc_out[6]}]
set_max_delay 5  -to [get_ports {node3_pc_out[7]}]
set_max_delay 5  -to [get_ports {node3_pc_out[8]}]
set_max_delay 5  -to [get_ports {node3_pc_out[9]}]
set_max_delay 5  -to [get_ports {node3_pc_out[10]}]
set_max_delay 5  -to [get_ports {node3_pc_out[11]}]
set_max_delay 5  -to [get_ports {node3_pc_out[12]}]
set_max_delay 5  -to [get_ports {node3_pc_out[13]}]
set_max_delay 5  -to [get_ports {node3_pc_out[14]}]
set_max_delay 5  -to [get_ports {node3_pc_out[15]}]
set_max_delay 5  -to [get_ports {node3_pc_out[16]}]
set_max_delay 5  -to [get_ports {node3_pc_out[17]}]
set_max_delay 5  -to [get_ports {node3_pc_out[18]}]
set_max_delay 5  -to [get_ports {node3_pc_out[19]}]
set_max_delay 5  -to [get_ports {node3_pc_out[20]}]
set_max_delay 5  -to [get_ports {node3_pc_out[21]}]
set_max_delay 5  -to [get_ports {node3_pc_out[22]}]
set_max_delay 5  -to [get_ports {node3_pc_out[23]}]
set_max_delay 5  -to [get_ports {node3_pc_out[24]}]
set_max_delay 5  -to [get_ports {node3_pc_out[25]}]
set_max_delay 5  -to [get_ports {node3_pc_out[26]}]
set_max_delay 5  -to [get_ports {node3_pc_out[27]}]
set_max_delay 5  -to [get_ports {node3_pc_out[28]}]
set_max_delay 5  -to [get_ports {node3_pc_out[29]}]
set_max_delay 5  -to [get_ports {node3_pc_out[30]}]
set_max_delay 5  -to [get_ports {node3_pc_out[31]}]
set_max_delay 5  -to [get_ports {node0_d_out[0]}]
set_max_delay 5  -to [get_ports {node0_d_out[1]}]
set_max_delay 5  -to [get_ports {node0_d_out[2]}]
set_max_delay 5  -to [get_ports {node0_d_out[3]}]
set_max_delay 5  -to [get_ports {node0_d_out[4]}]
set_max_delay 5  -to [get_ports {node0_d_out[5]}]
set_max_delay 5  -to [get_ports {node0_d_out[6]}]
set_max_delay 5  -to [get_ports {node0_d_out[7]}]
set_max_delay 5  -to [get_ports {node0_d_out[8]}]
set_max_delay 5  -to [get_ports {node0_d_out[9]}]
set_max_delay 5  -to [get_ports {node0_d_out[10]}]
set_max_delay 5  -to [get_ports {node0_d_out[11]}]
set_max_delay 5  -to [get_ports {node0_d_out[12]}]
set_max_delay 5  -to [get_ports {node0_d_out[13]}]
set_max_delay 5  -to [get_ports {node0_d_out[14]}]
set_max_delay 5  -to [get_ports {node0_d_out[15]}]
set_max_delay 5  -to [get_ports {node0_d_out[16]}]
set_max_delay 5  -to [get_ports {node0_d_out[17]}]
set_max_delay 5  -to [get_ports {node0_d_out[18]}]
set_max_delay 5  -to [get_ports {node0_d_out[19]}]
set_max_delay 5  -to [get_ports {node0_d_out[20]}]
set_max_delay 5  -to [get_ports {node0_d_out[21]}]
set_max_delay 5  -to [get_ports {node0_d_out[22]}]
set_max_delay 5  -to [get_ports {node0_d_out[23]}]
set_max_delay 5  -to [get_ports {node0_d_out[24]}]
set_max_delay 5  -to [get_ports {node0_d_out[25]}]
set_max_delay 5  -to [get_ports {node0_d_out[26]}]
set_max_delay 5  -to [get_ports {node0_d_out[27]}]
set_max_delay 5  -to [get_ports {node0_d_out[28]}]
set_max_delay 5  -to [get_ports {node0_d_out[29]}]
set_max_delay 5  -to [get_ports {node0_d_out[30]}]
set_max_delay 5  -to [get_ports {node0_d_out[31]}]
set_max_delay 5  -to [get_ports {node0_d_out[32]}]
set_max_delay 5  -to [get_ports {node0_d_out[33]}]
set_max_delay 5  -to [get_ports {node0_d_out[34]}]
set_max_delay 5  -to [get_ports {node0_d_out[35]}]
set_max_delay 5  -to [get_ports {node0_d_out[36]}]
set_max_delay 5  -to [get_ports {node0_d_out[37]}]
set_max_delay 5  -to [get_ports {node0_d_out[38]}]
set_max_delay 5  -to [get_ports {node0_d_out[39]}]
set_max_delay 5  -to [get_ports {node0_d_out[40]}]
set_max_delay 5  -to [get_ports {node0_d_out[41]}]
set_max_delay 5  -to [get_ports {node0_d_out[42]}]
set_max_delay 5  -to [get_ports {node0_d_out[43]}]
set_max_delay 5  -to [get_ports {node0_d_out[44]}]
set_max_delay 5  -to [get_ports {node0_d_out[45]}]
set_max_delay 5  -to [get_ports {node0_d_out[46]}]
set_max_delay 5  -to [get_ports {node0_d_out[47]}]
set_max_delay 5  -to [get_ports {node0_d_out[48]}]
set_max_delay 5  -to [get_ports {node0_d_out[49]}]
set_max_delay 5  -to [get_ports {node0_d_out[50]}]
set_max_delay 5  -to [get_ports {node0_d_out[51]}]
set_max_delay 5  -to [get_ports {node0_d_out[52]}]
set_max_delay 5  -to [get_ports {node0_d_out[53]}]
set_max_delay 5  -to [get_ports {node0_d_out[54]}]
set_max_delay 5  -to [get_ports {node0_d_out[55]}]
set_max_delay 5  -to [get_ports {node0_d_out[56]}]
set_max_delay 5  -to [get_ports {node0_d_out[57]}]
set_max_delay 5  -to [get_ports {node0_d_out[58]}]
set_max_delay 5  -to [get_ports {node0_d_out[59]}]
set_max_delay 5  -to [get_ports {node0_d_out[60]}]
set_max_delay 5  -to [get_ports {node0_d_out[61]}]
set_max_delay 5  -to [get_ports {node0_d_out[62]}]
set_max_delay 5  -to [get_ports {node0_d_out[63]}]
set_max_delay 5  -to [get_ports {node1_d_out[0]}]
set_max_delay 5  -to [get_ports {node1_d_out[1]}]
set_max_delay 5  -to [get_ports {node1_d_out[2]}]
set_max_delay 5  -to [get_ports {node1_d_out[3]}]
set_max_delay 5  -to [get_ports {node1_d_out[4]}]
set_max_delay 5  -to [get_ports {node1_d_out[5]}]
set_max_delay 5  -to [get_ports {node1_d_out[6]}]
set_max_delay 5  -to [get_ports {node1_d_out[7]}]
set_max_delay 5  -to [get_ports {node1_d_out[8]}]
set_max_delay 5  -to [get_ports {node1_d_out[9]}]
set_max_delay 5  -to [get_ports {node1_d_out[10]}]
set_max_delay 5  -to [get_ports {node1_d_out[11]}]
set_max_delay 5  -to [get_ports {node1_d_out[12]}]
set_max_delay 5  -to [get_ports {node1_d_out[13]}]
set_max_delay 5  -to [get_ports {node1_d_out[14]}]
set_max_delay 5  -to [get_ports {node1_d_out[15]}]
set_max_delay 5  -to [get_ports {node1_d_out[16]}]
set_max_delay 5  -to [get_ports {node1_d_out[17]}]
set_max_delay 5  -to [get_ports {node1_d_out[18]}]
set_max_delay 5  -to [get_ports {node1_d_out[19]}]
set_max_delay 5  -to [get_ports {node1_d_out[20]}]
set_max_delay 5  -to [get_ports {node1_d_out[21]}]
set_max_delay 5  -to [get_ports {node1_d_out[22]}]
set_max_delay 5  -to [get_ports {node1_d_out[23]}]
set_max_delay 5  -to [get_ports {node1_d_out[24]}]
set_max_delay 5  -to [get_ports {node1_d_out[25]}]
set_max_delay 5  -to [get_ports {node1_d_out[26]}]
set_max_delay 5  -to [get_ports {node1_d_out[27]}]
set_max_delay 5  -to [get_ports {node1_d_out[28]}]
set_max_delay 5  -to [get_ports {node1_d_out[29]}]
set_max_delay 5  -to [get_ports {node1_d_out[30]}]
set_max_delay 5  -to [get_ports {node1_d_out[31]}]
set_max_delay 5  -to [get_ports {node1_d_out[32]}]
set_max_delay 5  -to [get_ports {node1_d_out[33]}]
set_max_delay 5  -to [get_ports {node1_d_out[34]}]
set_max_delay 5  -to [get_ports {node1_d_out[35]}]
set_max_delay 5  -to [get_ports {node1_d_out[36]}]
set_max_delay 5  -to [get_ports {node1_d_out[37]}]
set_max_delay 5  -to [get_ports {node1_d_out[38]}]
set_max_delay 5  -to [get_ports {node1_d_out[39]}]
set_max_delay 5  -to [get_ports {node1_d_out[40]}]
set_max_delay 5  -to [get_ports {node1_d_out[41]}]
set_max_delay 5  -to [get_ports {node1_d_out[42]}]
set_max_delay 5  -to [get_ports {node1_d_out[43]}]
set_max_delay 5  -to [get_ports {node1_d_out[44]}]
set_max_delay 5  -to [get_ports {node1_d_out[45]}]
set_max_delay 5  -to [get_ports {node1_d_out[46]}]
set_max_delay 5  -to [get_ports {node1_d_out[47]}]
set_max_delay 5  -to [get_ports {node1_d_out[48]}]
set_max_delay 5  -to [get_ports {node1_d_out[49]}]
set_max_delay 5  -to [get_ports {node1_d_out[50]}]
set_max_delay 5  -to [get_ports {node1_d_out[51]}]
set_max_delay 5  -to [get_ports {node1_d_out[52]}]
set_max_delay 5  -to [get_ports {node1_d_out[53]}]
set_max_delay 5  -to [get_ports {node1_d_out[54]}]
set_max_delay 5  -to [get_ports {node1_d_out[55]}]
set_max_delay 5  -to [get_ports {node1_d_out[56]}]
set_max_delay 5  -to [get_ports {node1_d_out[57]}]
set_max_delay 5  -to [get_ports {node1_d_out[58]}]
set_max_delay 5  -to [get_ports {node1_d_out[59]}]
set_max_delay 5  -to [get_ports {node1_d_out[60]}]
set_max_delay 5  -to [get_ports {node1_d_out[61]}]
set_max_delay 5  -to [get_ports {node1_d_out[62]}]
set_max_delay 5  -to [get_ports {node1_d_out[63]}]
set_max_delay 5  -to [get_ports {node2_d_out[0]}]
set_max_delay 5  -to [get_ports {node2_d_out[1]}]
set_max_delay 5  -to [get_ports {node2_d_out[2]}]
set_max_delay 5  -to [get_ports {node2_d_out[3]}]
set_max_delay 5  -to [get_ports {node2_d_out[4]}]
set_max_delay 5  -to [get_ports {node2_d_out[5]}]
set_max_delay 5  -to [get_ports {node2_d_out[6]}]
set_max_delay 5  -to [get_ports {node2_d_out[7]}]
set_max_delay 5  -to [get_ports {node2_d_out[8]}]
set_max_delay 5  -to [get_ports {node2_d_out[9]}]
set_max_delay 5  -to [get_ports {node2_d_out[10]}]
set_max_delay 5  -to [get_ports {node2_d_out[11]}]
set_max_delay 5  -to [get_ports {node2_d_out[12]}]
set_max_delay 5  -to [get_ports {node2_d_out[13]}]
set_max_delay 5  -to [get_ports {node2_d_out[14]}]
set_max_delay 5  -to [get_ports {node2_d_out[15]}]
set_max_delay 5  -to [get_ports {node2_d_out[16]}]
set_max_delay 5  -to [get_ports {node2_d_out[17]}]
set_max_delay 5  -to [get_ports {node2_d_out[18]}]
set_max_delay 5  -to [get_ports {node2_d_out[19]}]
set_max_delay 5  -to [get_ports {node2_d_out[20]}]
set_max_delay 5  -to [get_ports {node2_d_out[21]}]
set_max_delay 5  -to [get_ports {node2_d_out[22]}]
set_max_delay 5  -to [get_ports {node2_d_out[23]}]
set_max_delay 5  -to [get_ports {node2_d_out[24]}]
set_max_delay 5  -to [get_ports {node2_d_out[25]}]
set_max_delay 5  -to [get_ports {node2_d_out[26]}]
set_max_delay 5  -to [get_ports {node2_d_out[27]}]
set_max_delay 5  -to [get_ports {node2_d_out[28]}]
set_max_delay 5  -to [get_ports {node2_d_out[29]}]
set_max_delay 5  -to [get_ports {node2_d_out[30]}]
set_max_delay 5  -to [get_ports {node2_d_out[31]}]
set_max_delay 5  -to [get_ports {node2_d_out[32]}]
set_max_delay 5  -to [get_ports {node2_d_out[33]}]
set_max_delay 5  -to [get_ports {node2_d_out[34]}]
set_max_delay 5  -to [get_ports {node2_d_out[35]}]
set_max_delay 5  -to [get_ports {node2_d_out[36]}]
set_max_delay 5  -to [get_ports {node2_d_out[37]}]
set_max_delay 5  -to [get_ports {node2_d_out[38]}]
set_max_delay 5  -to [get_ports {node2_d_out[39]}]
set_max_delay 5  -to [get_ports {node2_d_out[40]}]
set_max_delay 5  -to [get_ports {node2_d_out[41]}]
set_max_delay 5  -to [get_ports {node2_d_out[42]}]
set_max_delay 5  -to [get_ports {node2_d_out[43]}]
set_max_delay 5  -to [get_ports {node2_d_out[44]}]
set_max_delay 5  -to [get_ports {node2_d_out[45]}]
set_max_delay 5  -to [get_ports {node2_d_out[46]}]
set_max_delay 5  -to [get_ports {node2_d_out[47]}]
set_max_delay 5  -to [get_ports {node2_d_out[48]}]
set_max_delay 5  -to [get_ports {node2_d_out[49]}]
set_max_delay 5  -to [get_ports {node2_d_out[50]}]
set_max_delay 5  -to [get_ports {node2_d_out[51]}]
set_max_delay 5  -to [get_ports {node2_d_out[52]}]
set_max_delay 5  -to [get_ports {node2_d_out[53]}]
set_max_delay 5  -to [get_ports {node2_d_out[54]}]
set_max_delay 5  -to [get_ports {node2_d_out[55]}]
set_max_delay 5  -to [get_ports {node2_d_out[56]}]
set_max_delay 5  -to [get_ports {node2_d_out[57]}]
set_max_delay 5  -to [get_ports {node2_d_out[58]}]
set_max_delay 5  -to [get_ports {node2_d_out[59]}]
set_max_delay 5  -to [get_ports {node2_d_out[60]}]
set_max_delay 5  -to [get_ports {node2_d_out[61]}]
set_max_delay 5  -to [get_ports {node2_d_out[62]}]
set_max_delay 5  -to [get_ports {node2_d_out[63]}]
set_max_delay 5  -to [get_ports {node3_d_out[0]}]
set_max_delay 5  -to [get_ports {node3_d_out[1]}]
set_max_delay 5  -to [get_ports {node3_d_out[2]}]
set_max_delay 5  -to [get_ports {node3_d_out[3]}]
set_max_delay 5  -to [get_ports {node3_d_out[4]}]
set_max_delay 5  -to [get_ports {node3_d_out[5]}]
set_max_delay 5  -to [get_ports {node3_d_out[6]}]
set_max_delay 5  -to [get_ports {node3_d_out[7]}]
set_max_delay 5  -to [get_ports {node3_d_out[8]}]
set_max_delay 5  -to [get_ports {node3_d_out[9]}]
set_max_delay 5  -to [get_ports {node3_d_out[10]}]
set_max_delay 5  -to [get_ports {node3_d_out[11]}]
set_max_delay 5  -to [get_ports {node3_d_out[12]}]
set_max_delay 5  -to [get_ports {node3_d_out[13]}]
set_max_delay 5  -to [get_ports {node3_d_out[14]}]
set_max_delay 5  -to [get_ports {node3_d_out[15]}]
set_max_delay 5  -to [get_ports {node3_d_out[16]}]
set_max_delay 5  -to [get_ports {node3_d_out[17]}]
set_max_delay 5  -to [get_ports {node3_d_out[18]}]
set_max_delay 5  -to [get_ports {node3_d_out[19]}]
set_max_delay 5  -to [get_ports {node3_d_out[20]}]
set_max_delay 5  -to [get_ports {node3_d_out[21]}]
set_max_delay 5  -to [get_ports {node3_d_out[22]}]
set_max_delay 5  -to [get_ports {node3_d_out[23]}]
set_max_delay 5  -to [get_ports {node3_d_out[24]}]
set_max_delay 5  -to [get_ports {node3_d_out[25]}]
set_max_delay 5  -to [get_ports {node3_d_out[26]}]
set_max_delay 5  -to [get_ports {node3_d_out[27]}]
set_max_delay 5  -to [get_ports {node3_d_out[28]}]
set_max_delay 5  -to [get_ports {node3_d_out[29]}]
set_max_delay 5  -to [get_ports {node3_d_out[30]}]
set_max_delay 5  -to [get_ports {node3_d_out[31]}]
set_max_delay 5  -to [get_ports {node3_d_out[32]}]
set_max_delay 5  -to [get_ports {node3_d_out[33]}]
set_max_delay 5  -to [get_ports {node3_d_out[34]}]
set_max_delay 5  -to [get_ports {node3_d_out[35]}]
set_max_delay 5  -to [get_ports {node3_d_out[36]}]
set_max_delay 5  -to [get_ports {node3_d_out[37]}]
set_max_delay 5  -to [get_ports {node3_d_out[38]}]
set_max_delay 5  -to [get_ports {node3_d_out[39]}]
set_max_delay 5  -to [get_ports {node3_d_out[40]}]
set_max_delay 5  -to [get_ports {node3_d_out[41]}]
set_max_delay 5  -to [get_ports {node3_d_out[42]}]
set_max_delay 5  -to [get_ports {node3_d_out[43]}]
set_max_delay 5  -to [get_ports {node3_d_out[44]}]
set_max_delay 5  -to [get_ports {node3_d_out[45]}]
set_max_delay 5  -to [get_ports {node3_d_out[46]}]
set_max_delay 5  -to [get_ports {node3_d_out[47]}]
set_max_delay 5  -to [get_ports {node3_d_out[48]}]
set_max_delay 5  -to [get_ports {node3_d_out[49]}]
set_max_delay 5  -to [get_ports {node3_d_out[50]}]
set_max_delay 5  -to [get_ports {node3_d_out[51]}]
set_max_delay 5  -to [get_ports {node3_d_out[52]}]
set_max_delay 5  -to [get_ports {node3_d_out[53]}]
set_max_delay 5  -to [get_ports {node3_d_out[54]}]
set_max_delay 5  -to [get_ports {node3_d_out[55]}]
set_max_delay 5  -to [get_ports {node3_d_out[56]}]
set_max_delay 5  -to [get_ports {node3_d_out[57]}]
set_max_delay 5  -to [get_ports {node3_d_out[58]}]
set_max_delay 5  -to [get_ports {node3_d_out[59]}]
set_max_delay 5  -to [get_ports {node3_d_out[60]}]
set_max_delay 5  -to [get_ports {node3_d_out[61]}]
set_max_delay 5  -to [get_ports {node3_d_out[62]}]
set_max_delay 5  -to [get_ports {node3_d_out[63]}]
set_max_delay 5  -to [get_ports {node0_addr_out[0]}]
set_max_delay 5  -to [get_ports {node0_addr_out[1]}]
set_max_delay 5  -to [get_ports {node0_addr_out[2]}]
set_max_delay 5  -to [get_ports {node0_addr_out[3]}]
set_max_delay 5  -to [get_ports {node0_addr_out[4]}]
set_max_delay 5  -to [get_ports {node0_addr_out[5]}]
set_max_delay 5  -to [get_ports {node0_addr_out[6]}]
set_max_delay 5  -to [get_ports {node0_addr_out[7]}]
set_max_delay 5  -to [get_ports {node0_addr_out[8]}]
set_max_delay 5  -to [get_ports {node0_addr_out[9]}]
set_max_delay 5  -to [get_ports {node0_addr_out[10]}]
set_max_delay 5  -to [get_ports {node0_addr_out[11]}]
set_max_delay 5  -to [get_ports {node0_addr_out[12]}]
set_max_delay 5  -to [get_ports {node0_addr_out[13]}]
set_max_delay 5  -to [get_ports {node0_addr_out[14]}]
set_max_delay 5  -to [get_ports {node0_addr_out[15]}]
set_max_delay 5  -to [get_ports {node0_addr_out[16]}]
set_max_delay 5  -to [get_ports {node0_addr_out[17]}]
set_max_delay 5  -to [get_ports {node0_addr_out[18]}]
set_max_delay 5  -to [get_ports {node0_addr_out[19]}]
set_max_delay 5  -to [get_ports {node0_addr_out[20]}]
set_max_delay 5  -to [get_ports {node0_addr_out[21]}]
set_max_delay 5  -to [get_ports {node0_addr_out[22]}]
set_max_delay 5  -to [get_ports {node0_addr_out[23]}]
set_max_delay 5  -to [get_ports {node0_addr_out[24]}]
set_max_delay 5  -to [get_ports {node0_addr_out[25]}]
set_max_delay 5  -to [get_ports {node0_addr_out[26]}]
set_max_delay 5  -to [get_ports {node0_addr_out[27]}]
set_max_delay 5  -to [get_ports {node0_addr_out[28]}]
set_max_delay 5  -to [get_ports {node0_addr_out[29]}]
set_max_delay 5  -to [get_ports {node0_addr_out[30]}]
set_max_delay 5  -to [get_ports {node0_addr_out[31]}]
set_max_delay 5  -to [get_ports {node1_addr_out[0]}]
set_max_delay 5  -to [get_ports {node1_addr_out[1]}]
set_max_delay 5  -to [get_ports {node1_addr_out[2]}]
set_max_delay 5  -to [get_ports {node1_addr_out[3]}]
set_max_delay 5  -to [get_ports {node1_addr_out[4]}]
set_max_delay 5  -to [get_ports {node1_addr_out[5]}]
set_max_delay 5  -to [get_ports {node1_addr_out[6]}]
set_max_delay 5  -to [get_ports {node1_addr_out[7]}]
set_max_delay 5  -to [get_ports {node1_addr_out[8]}]
set_max_delay 5  -to [get_ports {node1_addr_out[9]}]
set_max_delay 5  -to [get_ports {node1_addr_out[10]}]
set_max_delay 5  -to [get_ports {node1_addr_out[11]}]
set_max_delay 5  -to [get_ports {node1_addr_out[12]}]
set_max_delay 5  -to [get_ports {node1_addr_out[13]}]
set_max_delay 5  -to [get_ports {node1_addr_out[14]}]
set_max_delay 5  -to [get_ports {node1_addr_out[15]}]
set_max_delay 5  -to [get_ports {node1_addr_out[16]}]
set_max_delay 5  -to [get_ports {node1_addr_out[17]}]
set_max_delay 5  -to [get_ports {node1_addr_out[18]}]
set_max_delay 5  -to [get_ports {node1_addr_out[19]}]
set_max_delay 5  -to [get_ports {node1_addr_out[20]}]
set_max_delay 5  -to [get_ports {node1_addr_out[21]}]
set_max_delay 5  -to [get_ports {node1_addr_out[22]}]
set_max_delay 5  -to [get_ports {node1_addr_out[23]}]
set_max_delay 5  -to [get_ports {node1_addr_out[24]}]
set_max_delay 5  -to [get_ports {node1_addr_out[25]}]
set_max_delay 5  -to [get_ports {node1_addr_out[26]}]
set_max_delay 5  -to [get_ports {node1_addr_out[27]}]
set_max_delay 5  -to [get_ports {node1_addr_out[28]}]
set_max_delay 5  -to [get_ports {node1_addr_out[29]}]
set_max_delay 5  -to [get_ports {node1_addr_out[30]}]
set_max_delay 5  -to [get_ports {node1_addr_out[31]}]
set_max_delay 5  -to [get_ports {node2_addr_out[0]}]
set_max_delay 5  -to [get_ports {node2_addr_out[1]}]
set_max_delay 5  -to [get_ports {node2_addr_out[2]}]
set_max_delay 5  -to [get_ports {node2_addr_out[3]}]
set_max_delay 5  -to [get_ports {node2_addr_out[4]}]
set_max_delay 5  -to [get_ports {node2_addr_out[5]}]
set_max_delay 5  -to [get_ports {node2_addr_out[6]}]
set_max_delay 5  -to [get_ports {node2_addr_out[7]}]
set_max_delay 5  -to [get_ports {node2_addr_out[8]}]
set_max_delay 5  -to [get_ports {node2_addr_out[9]}]
set_max_delay 5  -to [get_ports {node2_addr_out[10]}]
set_max_delay 5  -to [get_ports {node2_addr_out[11]}]
set_max_delay 5  -to [get_ports {node2_addr_out[12]}]
set_max_delay 5  -to [get_ports {node2_addr_out[13]}]
set_max_delay 5  -to [get_ports {node2_addr_out[14]}]
set_max_delay 5  -to [get_ports {node2_addr_out[15]}]
set_max_delay 5  -to [get_ports {node2_addr_out[16]}]
set_max_delay 5  -to [get_ports {node2_addr_out[17]}]
set_max_delay 5  -to [get_ports {node2_addr_out[18]}]
set_max_delay 5  -to [get_ports {node2_addr_out[19]}]
set_max_delay 5  -to [get_ports {node2_addr_out[20]}]
set_max_delay 5  -to [get_ports {node2_addr_out[21]}]
set_max_delay 5  -to [get_ports {node2_addr_out[22]}]
set_max_delay 5  -to [get_ports {node2_addr_out[23]}]
set_max_delay 5  -to [get_ports {node2_addr_out[24]}]
set_max_delay 5  -to [get_ports {node2_addr_out[25]}]
set_max_delay 5  -to [get_ports {node2_addr_out[26]}]
set_max_delay 5  -to [get_ports {node2_addr_out[27]}]
set_max_delay 5  -to [get_ports {node2_addr_out[28]}]
set_max_delay 5  -to [get_ports {node2_addr_out[29]}]
set_max_delay 5  -to [get_ports {node2_addr_out[30]}]
set_max_delay 5  -to [get_ports {node2_addr_out[31]}]
set_max_delay 5  -to [get_ports {node3_addr_out[0]}]
set_max_delay 5  -to [get_ports {node3_addr_out[1]}]
set_max_delay 5  -to [get_ports {node3_addr_out[2]}]
set_max_delay 5  -to [get_ports {node3_addr_out[3]}]
set_max_delay 5  -to [get_ports {node3_addr_out[4]}]
set_max_delay 5  -to [get_ports {node3_addr_out[5]}]
set_max_delay 5  -to [get_ports {node3_addr_out[6]}]
set_max_delay 5  -to [get_ports {node3_addr_out[7]}]
set_max_delay 5  -to [get_ports {node3_addr_out[8]}]
set_max_delay 5  -to [get_ports {node3_addr_out[9]}]
set_max_delay 5  -to [get_ports {node3_addr_out[10]}]
set_max_delay 5  -to [get_ports {node3_addr_out[11]}]
set_max_delay 5  -to [get_ports {node3_addr_out[12]}]
set_max_delay 5  -to [get_ports {node3_addr_out[13]}]
set_max_delay 5  -to [get_ports {node3_addr_out[14]}]
set_max_delay 5  -to [get_ports {node3_addr_out[15]}]
set_max_delay 5  -to [get_ports {node3_addr_out[16]}]
set_max_delay 5  -to [get_ports {node3_addr_out[17]}]
set_max_delay 5  -to [get_ports {node3_addr_out[18]}]
set_max_delay 5  -to [get_ports {node3_addr_out[19]}]
set_max_delay 5  -to [get_ports {node3_addr_out[20]}]
set_max_delay 5  -to [get_ports {node3_addr_out[21]}]
set_max_delay 5  -to [get_ports {node3_addr_out[22]}]
set_max_delay 5  -to [get_ports {node3_addr_out[23]}]
set_max_delay 5  -to [get_ports {node3_addr_out[24]}]
set_max_delay 5  -to [get_ports {node3_addr_out[25]}]
set_max_delay 5  -to [get_ports {node3_addr_out[26]}]
set_max_delay 5  -to [get_ports {node3_addr_out[27]}]
set_max_delay 5  -to [get_ports {node3_addr_out[28]}]
set_max_delay 5  -to [get_ports {node3_addr_out[29]}]
set_max_delay 5  -to [get_ports {node3_addr_out[30]}]
set_max_delay 5  -to [get_ports {node3_addr_out[31]}]
set_max_delay 5  -to [get_ports node0_memEn]
set_max_delay 5  -to [get_ports node1_memEn]
set_max_delay 5  -to [get_ports node2_memEn]
set_max_delay 5  -to [get_ports node3_memEn]
set_max_delay 5  -to [get_ports node0_memWrEn]
set_max_delay 5  -to [get_ports node1_memWrEn]
set_max_delay 5  -to [get_ports node2_memWrEn]
set_max_delay 5  -to [get_ports node3_memWrEn]
set_max_delay 5  -from [list [get_ports clk] [get_ports reset] [get_ports {node0_inst_in[0]}]  \
[get_ports {node0_inst_in[1]}] [get_ports {node0_inst_in[2]}] [get_ports       \
{node0_inst_in[3]}] [get_ports {node0_inst_in[4]}] [get_ports                  \
{node0_inst_in[5]}] [get_ports {node0_inst_in[6]}] [get_ports                  \
{node0_inst_in[7]}] [get_ports {node0_inst_in[8]}] [get_ports                  \
{node0_inst_in[9]}] [get_ports {node0_inst_in[10]}] [get_ports                 \
{node0_inst_in[11]}] [get_ports {node0_inst_in[12]}] [get_ports                \
{node0_inst_in[13]}] [get_ports {node0_inst_in[14]}] [get_ports                \
{node0_inst_in[15]}] [get_ports {node0_inst_in[16]}] [get_ports                \
{node0_inst_in[17]}] [get_ports {node0_inst_in[18]}] [get_ports                \
{node0_inst_in[19]}] [get_ports {node0_inst_in[20]}] [get_ports                \
{node0_inst_in[21]}] [get_ports {node0_inst_in[22]}] [get_ports                \
{node0_inst_in[23]}] [get_ports {node0_inst_in[24]}] [get_ports                \
{node0_inst_in[25]}] [get_ports {node0_inst_in[26]}] [get_ports                \
{node0_inst_in[27]}] [get_ports {node0_inst_in[28]}] [get_ports                \
{node0_inst_in[29]}] [get_ports {node0_inst_in[30]}] [get_ports                \
{node0_inst_in[31]}] [get_ports {node1_inst_in[0]}] [get_ports                 \
{node1_inst_in[1]}] [get_ports {node1_inst_in[2]}] [get_ports                  \
{node1_inst_in[3]}] [get_ports {node1_inst_in[4]}] [get_ports                  \
{node1_inst_in[5]}] [get_ports {node1_inst_in[6]}] [get_ports                  \
{node1_inst_in[7]}] [get_ports {node1_inst_in[8]}] [get_ports                  \
{node1_inst_in[9]}] [get_ports {node1_inst_in[10]}] [get_ports                 \
{node1_inst_in[11]}] [get_ports {node1_inst_in[12]}] [get_ports                \
{node1_inst_in[13]}] [get_ports {node1_inst_in[14]}] [get_ports                \
{node1_inst_in[15]}] [get_ports {node1_inst_in[16]}] [get_ports                \
{node1_inst_in[17]}] [get_ports {node1_inst_in[18]}] [get_ports                \
{node1_inst_in[19]}] [get_ports {node1_inst_in[20]}] [get_ports                \
{node1_inst_in[21]}] [get_ports {node1_inst_in[22]}] [get_ports                \
{node1_inst_in[23]}] [get_ports {node1_inst_in[24]}] [get_ports                \
{node1_inst_in[25]}] [get_ports {node1_inst_in[26]}] [get_ports                \
{node1_inst_in[27]}] [get_ports {node1_inst_in[28]}] [get_ports                \
{node1_inst_in[29]}] [get_ports {node1_inst_in[30]}] [get_ports                \
{node1_inst_in[31]}] [get_ports {node2_inst_in[0]}] [get_ports                 \
{node2_inst_in[1]}] [get_ports {node2_inst_in[2]}] [get_ports                  \
{node2_inst_in[3]}] [get_ports {node2_inst_in[4]}] [get_ports                  \
{node2_inst_in[5]}] [get_ports {node2_inst_in[6]}] [get_ports                  \
{node2_inst_in[7]}] [get_ports {node2_inst_in[8]}] [get_ports                  \
{node2_inst_in[9]}] [get_ports {node2_inst_in[10]}] [get_ports                 \
{node2_inst_in[11]}] [get_ports {node2_inst_in[12]}] [get_ports                \
{node2_inst_in[13]}] [get_ports {node2_inst_in[14]}] [get_ports                \
{node2_inst_in[15]}] [get_ports {node2_inst_in[16]}] [get_ports                \
{node2_inst_in[17]}] [get_ports {node2_inst_in[18]}] [get_ports                \
{node2_inst_in[19]}] [get_ports {node2_inst_in[20]}] [get_ports                \
{node2_inst_in[21]}] [get_ports {node2_inst_in[22]}] [get_ports                \
{node2_inst_in[23]}] [get_ports {node2_inst_in[24]}] [get_ports                \
{node2_inst_in[25]}] [get_ports {node2_inst_in[26]}] [get_ports                \
{node2_inst_in[27]}] [get_ports {node2_inst_in[28]}] [get_ports                \
{node2_inst_in[29]}] [get_ports {node2_inst_in[30]}] [get_ports                \
{node2_inst_in[31]}] [get_ports {node3_inst_in[0]}] [get_ports                 \
{node3_inst_in[1]}] [get_ports {node3_inst_in[2]}] [get_ports                  \
{node3_inst_in[3]}] [get_ports {node3_inst_in[4]}] [get_ports                  \
{node3_inst_in[5]}] [get_ports {node3_inst_in[6]}] [get_ports                  \
{node3_inst_in[7]}] [get_ports {node3_inst_in[8]}] [get_ports                  \
{node3_inst_in[9]}] [get_ports {node3_inst_in[10]}] [get_ports                 \
{node3_inst_in[11]}] [get_ports {node3_inst_in[12]}] [get_ports                \
{node3_inst_in[13]}] [get_ports {node3_inst_in[14]}] [get_ports                \
{node3_inst_in[15]}] [get_ports {node3_inst_in[16]}] [get_ports                \
{node3_inst_in[17]}] [get_ports {node3_inst_in[18]}] [get_ports                \
{node3_inst_in[19]}] [get_ports {node3_inst_in[20]}] [get_ports                \
{node3_inst_in[21]}] [get_ports {node3_inst_in[22]}] [get_ports                \
{node3_inst_in[23]}] [get_ports {node3_inst_in[24]}] [get_ports                \
{node3_inst_in[25]}] [get_ports {node3_inst_in[26]}] [get_ports                \
{node3_inst_in[27]}] [get_ports {node3_inst_in[28]}] [get_ports                \
{node3_inst_in[29]}] [get_ports {node3_inst_in[30]}] [get_ports                \
{node3_inst_in[31]}] [get_ports {node0_d_in[0]}] [get_ports {node0_d_in[1]}]   \
[get_ports {node0_d_in[2]}] [get_ports {node0_d_in[3]}] [get_ports             \
{node0_d_in[4]}] [get_ports {node0_d_in[5]}] [get_ports {node0_d_in[6]}]       \
[get_ports {node0_d_in[7]}] [get_ports {node0_d_in[8]}] [get_ports             \
{node0_d_in[9]}] [get_ports {node0_d_in[10]}] [get_ports {node0_d_in[11]}]     \
[get_ports {node0_d_in[12]}] [get_ports {node0_d_in[13]}] [get_ports           \
{node0_d_in[14]}] [get_ports {node0_d_in[15]}] [get_ports {node0_d_in[16]}]    \
[get_ports {node0_d_in[17]}] [get_ports {node0_d_in[18]}] [get_ports           \
{node0_d_in[19]}] [get_ports {node0_d_in[20]}] [get_ports {node0_d_in[21]}]    \
[get_ports {node0_d_in[22]}] [get_ports {node0_d_in[23]}] [get_ports           \
{node0_d_in[24]}] [get_ports {node0_d_in[25]}] [get_ports {node0_d_in[26]}]    \
[get_ports {node0_d_in[27]}] [get_ports {node0_d_in[28]}] [get_ports           \
{node0_d_in[29]}] [get_ports {node0_d_in[30]}] [get_ports {node0_d_in[31]}]    \
[get_ports {node0_d_in[32]}] [get_ports {node0_d_in[33]}] [get_ports           \
{node0_d_in[34]}] [get_ports {node0_d_in[35]}] [get_ports {node0_d_in[36]}]    \
[get_ports {node0_d_in[37]}] [get_ports {node0_d_in[38]}] [get_ports           \
{node0_d_in[39]}] [get_ports {node0_d_in[40]}] [get_ports {node0_d_in[41]}]    \
[get_ports {node0_d_in[42]}] [get_ports {node0_d_in[43]}] [get_ports           \
{node0_d_in[44]}] [get_ports {node0_d_in[45]}] [get_ports {node0_d_in[46]}]    \
[get_ports {node0_d_in[47]}] [get_ports {node0_d_in[48]}] [get_ports           \
{node0_d_in[49]}] [get_ports {node0_d_in[50]}] [get_ports {node0_d_in[51]}]    \
[get_ports {node0_d_in[52]}] [get_ports {node0_d_in[53]}] [get_ports           \
{node0_d_in[54]}] [get_ports {node0_d_in[55]}] [get_ports {node0_d_in[56]}]    \
[get_ports {node0_d_in[57]}] [get_ports {node0_d_in[58]}] [get_ports           \
{node0_d_in[59]}] [get_ports {node0_d_in[60]}] [get_ports {node0_d_in[61]}]    \
[get_ports {node0_d_in[62]}] [get_ports {node0_d_in[63]}] [get_ports           \
{node1_d_in[0]}] [get_ports {node1_d_in[1]}] [get_ports {node1_d_in[2]}]       \
[get_ports {node1_d_in[3]}] [get_ports {node1_d_in[4]}] [get_ports             \
{node1_d_in[5]}] [get_ports {node1_d_in[6]}] [get_ports {node1_d_in[7]}]       \
[get_ports {node1_d_in[8]}] [get_ports {node1_d_in[9]}] [get_ports             \
{node1_d_in[10]}] [get_ports {node1_d_in[11]}] [get_ports {node1_d_in[12]}]    \
[get_ports {node1_d_in[13]}] [get_ports {node1_d_in[14]}] [get_ports           \
{node1_d_in[15]}] [get_ports {node1_d_in[16]}] [get_ports {node1_d_in[17]}]    \
[get_ports {node1_d_in[18]}] [get_ports {node1_d_in[19]}] [get_ports           \
{node1_d_in[20]}] [get_ports {node1_d_in[21]}] [get_ports {node1_d_in[22]}]    \
[get_ports {node1_d_in[23]}] [get_ports {node1_d_in[24]}] [get_ports           \
{node1_d_in[25]}] [get_ports {node1_d_in[26]}] [get_ports {node1_d_in[27]}]    \
[get_ports {node1_d_in[28]}] [get_ports {node1_d_in[29]}] [get_ports           \
{node1_d_in[30]}] [get_ports {node1_d_in[31]}] [get_ports {node1_d_in[32]}]    \
[get_ports {node1_d_in[33]}] [get_ports {node1_d_in[34]}] [get_ports           \
{node1_d_in[35]}] [get_ports {node1_d_in[36]}] [get_ports {node1_d_in[37]}]    \
[get_ports {node1_d_in[38]}] [get_ports {node1_d_in[39]}] [get_ports           \
{node1_d_in[40]}] [get_ports {node1_d_in[41]}] [get_ports {node1_d_in[42]}]    \
[get_ports {node1_d_in[43]}] [get_ports {node1_d_in[44]}] [get_ports           \
{node1_d_in[45]}] [get_ports {node1_d_in[46]}] [get_ports {node1_d_in[47]}]    \
[get_ports {node1_d_in[48]}] [get_ports {node1_d_in[49]}] [get_ports           \
{node1_d_in[50]}] [get_ports {node1_d_in[51]}] [get_ports {node1_d_in[52]}]    \
[get_ports {node1_d_in[53]}] [get_ports {node1_d_in[54]}] [get_ports           \
{node1_d_in[55]}] [get_ports {node1_d_in[56]}] [get_ports {node1_d_in[57]}]    \
[get_ports {node1_d_in[58]}] [get_ports {node1_d_in[59]}] [get_ports           \
{node1_d_in[60]}] [get_ports {node1_d_in[61]}] [get_ports {node1_d_in[62]}]    \
[get_ports {node1_d_in[63]}] [get_ports {node2_d_in[0]}] [get_ports            \
{node2_d_in[1]}] [get_ports {node2_d_in[2]}] [get_ports {node2_d_in[3]}]       \
[get_ports {node2_d_in[4]}] [get_ports {node2_d_in[5]}] [get_ports             \
{node2_d_in[6]}] [get_ports {node2_d_in[7]}] [get_ports {node2_d_in[8]}]       \
[get_ports {node2_d_in[9]}] [get_ports {node2_d_in[10]}] [get_ports            \
{node2_d_in[11]}] [get_ports {node2_d_in[12]}] [get_ports {node2_d_in[13]}]    \
[get_ports {node2_d_in[14]}] [get_ports {node2_d_in[15]}] [get_ports           \
{node2_d_in[16]}] [get_ports {node2_d_in[17]}] [get_ports {node2_d_in[18]}]    \
[get_ports {node2_d_in[19]}] [get_ports {node2_d_in[20]}] [get_ports           \
{node2_d_in[21]}] [get_ports {node2_d_in[22]}] [get_ports {node2_d_in[23]}]    \
[get_ports {node2_d_in[24]}] [get_ports {node2_d_in[25]}] [get_ports           \
{node2_d_in[26]}] [get_ports {node2_d_in[27]}] [get_ports {node2_d_in[28]}]    \
[get_ports {node2_d_in[29]}] [get_ports {node2_d_in[30]}] [get_ports           \
{node2_d_in[31]}] [get_ports {node2_d_in[32]}] [get_ports {node2_d_in[33]}]    \
[get_ports {node2_d_in[34]}] [get_ports {node2_d_in[35]}] [get_ports           \
{node2_d_in[36]}] [get_ports {node2_d_in[37]}] [get_ports {node2_d_in[38]}]    \
[get_ports {node2_d_in[39]}] [get_ports {node2_d_in[40]}] [get_ports           \
{node2_d_in[41]}] [get_ports {node2_d_in[42]}] [get_ports {node2_d_in[43]}]    \
[get_ports {node2_d_in[44]}] [get_ports {node2_d_in[45]}] [get_ports           \
{node2_d_in[46]}] [get_ports {node2_d_in[47]}] [get_ports {node2_d_in[48]}]    \
[get_ports {node2_d_in[49]}] [get_ports {node2_d_in[50]}] [get_ports           \
{node2_d_in[51]}] [get_ports {node2_d_in[52]}] [get_ports {node2_d_in[53]}]    \
[get_ports {node2_d_in[54]}] [get_ports {node2_d_in[55]}] [get_ports           \
{node2_d_in[56]}] [get_ports {node2_d_in[57]}] [get_ports {node2_d_in[58]}]    \
[get_ports {node2_d_in[59]}] [get_ports {node2_d_in[60]}] [get_ports           \
{node2_d_in[61]}] [get_ports {node2_d_in[62]}] [get_ports {node2_d_in[63]}]    \
[get_ports {node3_d_in[0]}] [get_ports {node3_d_in[1]}] [get_ports             \
{node3_d_in[2]}] [get_ports {node3_d_in[3]}] [get_ports {node3_d_in[4]}]       \
[get_ports {node3_d_in[5]}] [get_ports {node3_d_in[6]}] [get_ports             \
{node3_d_in[7]}] [get_ports {node3_d_in[8]}] [get_ports {node3_d_in[9]}]       \
[get_ports {node3_d_in[10]}] [get_ports {node3_d_in[11]}] [get_ports           \
{node3_d_in[12]}] [get_ports {node3_d_in[13]}] [get_ports {node3_d_in[14]}]    \
[get_ports {node3_d_in[15]}] [get_ports {node3_d_in[16]}] [get_ports           \
{node3_d_in[17]}] [get_ports {node3_d_in[18]}] [get_ports {node3_d_in[19]}]    \
[get_ports {node3_d_in[20]}] [get_ports {node3_d_in[21]}] [get_ports           \
{node3_d_in[22]}] [get_ports {node3_d_in[23]}] [get_ports {node3_d_in[24]}]    \
[get_ports {node3_d_in[25]}] [get_ports {node3_d_in[26]}] [get_ports           \
{node3_d_in[27]}] [get_ports {node3_d_in[28]}] [get_ports {node3_d_in[29]}]    \
[get_ports {node3_d_in[30]}] [get_ports {node3_d_in[31]}] [get_ports           \
{node3_d_in[32]}] [get_ports {node3_d_in[33]}] [get_ports {node3_d_in[34]}]    \
[get_ports {node3_d_in[35]}] [get_ports {node3_d_in[36]}] [get_ports           \
{node3_d_in[37]}] [get_ports {node3_d_in[38]}] [get_ports {node3_d_in[39]}]    \
[get_ports {node3_d_in[40]}] [get_ports {node3_d_in[41]}] [get_ports           \
{node3_d_in[42]}] [get_ports {node3_d_in[43]}] [get_ports {node3_d_in[44]}]    \
[get_ports {node3_d_in[45]}] [get_ports {node3_d_in[46]}] [get_ports           \
{node3_d_in[47]}] [get_ports {node3_d_in[48]}] [get_ports {node3_d_in[49]}]    \
[get_ports {node3_d_in[50]}] [get_ports {node3_d_in[51]}] [get_ports           \
{node3_d_in[52]}] [get_ports {node3_d_in[53]}] [get_ports {node3_d_in[54]}]    \
[get_ports {node3_d_in[55]}] [get_ports {node3_d_in[56]}] [get_ports           \
{node3_d_in[57]}] [get_ports {node3_d_in[58]}] [get_ports {node3_d_in[59]}]    \
[get_ports {node3_d_in[60]}] [get_ports {node3_d_in[61]}] [get_ports           \
{node3_d_in[62]}] [get_ports {node3_d_in[63]}]]
