###################################################################

# Created by write_sdc on Sat Apr  1 00:13:00 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports {instrAddr[0]}]
set_max_delay 5  -to [get_ports {instrAddr[1]}]
set_max_delay 5  -to [get_ports {instrAddr[2]}]
set_max_delay 5  -to [get_ports {instrAddr[3]}]
set_max_delay 5  -to [get_ports {instrAddr[4]}]
set_max_delay 5  -to [get_ports {instrAddr[5]}]
set_max_delay 5  -to [get_ports {instrAddr[6]}]
set_max_delay 5  -to [get_ports {instrAddr[7]}]
set_max_delay 5  -to [get_ports {instrAddr[8]}]
set_max_delay 5  -to [get_ports {instrAddr[9]}]
set_max_delay 5  -to [get_ports {instrAddr[10]}]
set_max_delay 5  -to [get_ports {instrAddr[11]}]
set_max_delay 5  -to [get_ports {instrAddr[12]}]
set_max_delay 5  -to [get_ports {instrAddr[13]}]
set_max_delay 5  -to [get_ports {instrAddr[14]}]
set_max_delay 5  -to [get_ports {instrAddr[15]}]
set_max_delay 5  -to [get_ports {instrAddr[16]}]
set_max_delay 5  -to [get_ports {instrAddr[17]}]
set_max_delay 5  -to [get_ports {instrAddr[18]}]
set_max_delay 5  -to [get_ports {instrAddr[19]}]
set_max_delay 5  -to [get_ports {instrAddr[20]}]
set_max_delay 5  -to [get_ports {instrAddr[21]}]
set_max_delay 5  -to [get_ports {instrAddr[22]}]
set_max_delay 5  -to [get_ports {instrAddr[23]}]
set_max_delay 5  -to [get_ports {instrAddr[24]}]
set_max_delay 5  -to [get_ports {instrAddr[25]}]
set_max_delay 5  -to [get_ports {instrAddr[26]}]
set_max_delay 5  -to [get_ports {instrAddr[27]}]
set_max_delay 5  -to [get_ports {instrAddr[28]}]
set_max_delay 5  -to [get_ports {instrAddr[29]}]
set_max_delay 5  -to [get_ports {instrAddr[30]}]
set_max_delay 5  -to [get_ports {instrAddr[31]}]
set_max_delay 5  -to [get_ports {dmemDataout[0]}]
set_max_delay 5  -to [get_ports {dmemDataout[1]}]
set_max_delay 5  -to [get_ports {dmemDataout[2]}]
set_max_delay 5  -to [get_ports {dmemDataout[3]}]
set_max_delay 5  -to [get_ports {dmemDataout[4]}]
set_max_delay 5  -to [get_ports {dmemDataout[5]}]
set_max_delay 5  -to [get_ports {dmemDataout[6]}]
set_max_delay 5  -to [get_ports {dmemDataout[7]}]
set_max_delay 5  -to [get_ports {dmemDataout[8]}]
set_max_delay 5  -to [get_ports {dmemDataout[9]}]
set_max_delay 5  -to [get_ports {dmemDataout[10]}]
set_max_delay 5  -to [get_ports {dmemDataout[11]}]
set_max_delay 5  -to [get_ports {dmemDataout[12]}]
set_max_delay 5  -to [get_ports {dmemDataout[13]}]
set_max_delay 5  -to [get_ports {dmemDataout[14]}]
set_max_delay 5  -to [get_ports {dmemDataout[15]}]
set_max_delay 5  -to [get_ports {dmemDataout[16]}]
set_max_delay 5  -to [get_ports {dmemDataout[17]}]
set_max_delay 5  -to [get_ports {dmemDataout[18]}]
set_max_delay 5  -to [get_ports {dmemDataout[19]}]
set_max_delay 5  -to [get_ports {dmemDataout[20]}]
set_max_delay 5  -to [get_ports {dmemDataout[21]}]
set_max_delay 5  -to [get_ports {dmemDataout[22]}]
set_max_delay 5  -to [get_ports {dmemDataout[23]}]
set_max_delay 5  -to [get_ports {dmemDataout[24]}]
set_max_delay 5  -to [get_ports {dmemDataout[25]}]
set_max_delay 5  -to [get_ports {dmemDataout[26]}]
set_max_delay 5  -to [get_ports {dmemDataout[27]}]
set_max_delay 5  -to [get_ports {dmemDataout[28]}]
set_max_delay 5  -to [get_ports {dmemDataout[29]}]
set_max_delay 5  -to [get_ports {dmemDataout[30]}]
set_max_delay 5  -to [get_ports {dmemDataout[31]}]
set_max_delay 5  -to [get_ports {dmemDataout[32]}]
set_max_delay 5  -to [get_ports {dmemDataout[33]}]
set_max_delay 5  -to [get_ports {dmemDataout[34]}]
set_max_delay 5  -to [get_ports {dmemDataout[35]}]
set_max_delay 5  -to [get_ports {dmemDataout[36]}]
set_max_delay 5  -to [get_ports {dmemDataout[37]}]
set_max_delay 5  -to [get_ports {dmemDataout[38]}]
set_max_delay 5  -to [get_ports {dmemDataout[39]}]
set_max_delay 5  -to [get_ports {dmemDataout[40]}]
set_max_delay 5  -to [get_ports {dmemDataout[41]}]
set_max_delay 5  -to [get_ports {dmemDataout[42]}]
set_max_delay 5  -to [get_ports {dmemDataout[43]}]
set_max_delay 5  -to [get_ports {dmemDataout[44]}]
set_max_delay 5  -to [get_ports {dmemDataout[45]}]
set_max_delay 5  -to [get_ports {dmemDataout[46]}]
set_max_delay 5  -to [get_ports {dmemDataout[47]}]
set_max_delay 5  -to [get_ports {dmemDataout[48]}]
set_max_delay 5  -to [get_ports {dmemDataout[49]}]
set_max_delay 5  -to [get_ports {dmemDataout[50]}]
set_max_delay 5  -to [get_ports {dmemDataout[51]}]
set_max_delay 5  -to [get_ports {dmemDataout[52]}]
set_max_delay 5  -to [get_ports {dmemDataout[53]}]
set_max_delay 5  -to [get_ports {dmemDataout[54]}]
set_max_delay 5  -to [get_ports {dmemDataout[55]}]
set_max_delay 5  -to [get_ports {dmemDataout[56]}]
set_max_delay 5  -to [get_ports {dmemDataout[57]}]
set_max_delay 5  -to [get_ports {dmemDataout[58]}]
set_max_delay 5  -to [get_ports {dmemDataout[59]}]
set_max_delay 5  -to [get_ports {dmemDataout[60]}]
set_max_delay 5  -to [get_ports {dmemDataout[61]}]
set_max_delay 5  -to [get_ports {dmemDataout[62]}]
set_max_delay 5  -to [get_ports {dmemDataout[63]}]
set_max_delay 5  -to [get_ports {dmemAddr[0]}]
set_max_delay 5  -to [get_ports {dmemAddr[1]}]
set_max_delay 5  -to [get_ports {dmemAddr[2]}]
set_max_delay 5  -to [get_ports {dmemAddr[3]}]
set_max_delay 5  -to [get_ports {dmemAddr[4]}]
set_max_delay 5  -to [get_ports {dmemAddr[5]}]
set_max_delay 5  -to [get_ports {dmemAddr[6]}]
set_max_delay 5  -to [get_ports {dmemAddr[7]}]
set_max_delay 5  -to [get_ports {dmemAddr[8]}]
set_max_delay 5  -to [get_ports {dmemAddr[9]}]
set_max_delay 5  -to [get_ports {dmemAddr[10]}]
set_max_delay 5  -to [get_ports {dmemAddr[11]}]
set_max_delay 5  -to [get_ports {dmemAddr[12]}]
set_max_delay 5  -to [get_ports {dmemAddr[13]}]
set_max_delay 5  -to [get_ports {dmemAddr[14]}]
set_max_delay 5  -to [get_ports {dmemAddr[15]}]
set_max_delay 5  -to [get_ports {dmemAddr[16]}]
set_max_delay 5  -to [get_ports {dmemAddr[17]}]
set_max_delay 5  -to [get_ports {dmemAddr[18]}]
set_max_delay 5  -to [get_ports {dmemAddr[19]}]
set_max_delay 5  -to [get_ports {dmemAddr[20]}]
set_max_delay 5  -to [get_ports {dmemAddr[21]}]
set_max_delay 5  -to [get_ports {dmemAddr[22]}]
set_max_delay 5  -to [get_ports {dmemAddr[23]}]
set_max_delay 5  -to [get_ports {dmemAddr[24]}]
set_max_delay 5  -to [get_ports {dmemAddr[25]}]
set_max_delay 5  -to [get_ports {dmemAddr[26]}]
set_max_delay 5  -to [get_ports {dmemAddr[27]}]
set_max_delay 5  -to [get_ports {dmemAddr[28]}]
set_max_delay 5  -to [get_ports {dmemAddr[29]}]
set_max_delay 5  -to [get_ports {dmemAddr[30]}]
set_max_delay 5  -to [get_ports {dmemAddr[31]}]
set_max_delay 5  -to [get_ports dmemEn]
set_max_delay 5  -to [get_ports dmemWrEn]
set_max_delay 5  -to [get_ports {nicDataOut[0]}]
set_max_delay 5  -to [get_ports {nicDataOut[1]}]
set_max_delay 5  -to [get_ports {nicDataOut[2]}]
set_max_delay 5  -to [get_ports {nicDataOut[3]}]
set_max_delay 5  -to [get_ports {nicDataOut[4]}]
set_max_delay 5  -to [get_ports {nicDataOut[5]}]
set_max_delay 5  -to [get_ports {nicDataOut[6]}]
set_max_delay 5  -to [get_ports {nicDataOut[7]}]
set_max_delay 5  -to [get_ports {nicDataOut[8]}]
set_max_delay 5  -to [get_ports {nicDataOut[9]}]
set_max_delay 5  -to [get_ports {nicDataOut[10]}]
set_max_delay 5  -to [get_ports {nicDataOut[11]}]
set_max_delay 5  -to [get_ports {nicDataOut[12]}]
set_max_delay 5  -to [get_ports {nicDataOut[13]}]
set_max_delay 5  -to [get_ports {nicDataOut[14]}]
set_max_delay 5  -to [get_ports {nicDataOut[15]}]
set_max_delay 5  -to [get_ports {nicDataOut[16]}]
set_max_delay 5  -to [get_ports {nicDataOut[17]}]
set_max_delay 5  -to [get_ports {nicDataOut[18]}]
set_max_delay 5  -to [get_ports {nicDataOut[19]}]
set_max_delay 5  -to [get_ports {nicDataOut[20]}]
set_max_delay 5  -to [get_ports {nicDataOut[21]}]
set_max_delay 5  -to [get_ports {nicDataOut[22]}]
set_max_delay 5  -to [get_ports {nicDataOut[23]}]
set_max_delay 5  -to [get_ports {nicDataOut[24]}]
set_max_delay 5  -to [get_ports {nicDataOut[25]}]
set_max_delay 5  -to [get_ports {nicDataOut[26]}]
set_max_delay 5  -to [get_ports {nicDataOut[27]}]
set_max_delay 5  -to [get_ports {nicDataOut[28]}]
set_max_delay 5  -to [get_ports {nicDataOut[29]}]
set_max_delay 5  -to [get_ports {nicDataOut[30]}]
set_max_delay 5  -to [get_ports {nicDataOut[31]}]
set_max_delay 5  -to [get_ports {nicDataOut[32]}]
set_max_delay 5  -to [get_ports {nicDataOut[33]}]
set_max_delay 5  -to [get_ports {nicDataOut[34]}]
set_max_delay 5  -to [get_ports {nicDataOut[35]}]
set_max_delay 5  -to [get_ports {nicDataOut[36]}]
set_max_delay 5  -to [get_ports {nicDataOut[37]}]
set_max_delay 5  -to [get_ports {nicDataOut[38]}]
set_max_delay 5  -to [get_ports {nicDataOut[39]}]
set_max_delay 5  -to [get_ports {nicDataOut[40]}]
set_max_delay 5  -to [get_ports {nicDataOut[41]}]
set_max_delay 5  -to [get_ports {nicDataOut[42]}]
set_max_delay 5  -to [get_ports {nicDataOut[43]}]
set_max_delay 5  -to [get_ports {nicDataOut[44]}]
set_max_delay 5  -to [get_ports {nicDataOut[45]}]
set_max_delay 5  -to [get_ports {nicDataOut[46]}]
set_max_delay 5  -to [get_ports {nicDataOut[47]}]
set_max_delay 5  -to [get_ports {nicDataOut[48]}]
set_max_delay 5  -to [get_ports {nicDataOut[49]}]
set_max_delay 5  -to [get_ports {nicDataOut[50]}]
set_max_delay 5  -to [get_ports {nicDataOut[51]}]
set_max_delay 5  -to [get_ports {nicDataOut[52]}]
set_max_delay 5  -to [get_ports {nicDataOut[53]}]
set_max_delay 5  -to [get_ports {nicDataOut[54]}]
set_max_delay 5  -to [get_ports {nicDataOut[55]}]
set_max_delay 5  -to [get_ports {nicDataOut[56]}]
set_max_delay 5  -to [get_ports {nicDataOut[57]}]
set_max_delay 5  -to [get_ports {nicDataOut[58]}]
set_max_delay 5  -to [get_ports {nicDataOut[59]}]
set_max_delay 5  -to [get_ports {nicDataOut[60]}]
set_max_delay 5  -to [get_ports {nicDataOut[61]}]
set_max_delay 5  -to [get_ports {nicDataOut[62]}]
set_max_delay 5  -to [get_ports {nicDataOut[63]}]
set_max_delay 5  -to [get_ports {nicAddr[0]}]
set_max_delay 5  -to [get_ports {nicAddr[1]}]
set_max_delay 5  -to [get_ports nicEn]
set_max_delay 5  -to [get_ports nicWrEn]
set_max_delay 5  -from [list [get_ports clk] [get_ports reset] [get_ports {instrIn[0]}]        \
[get_ports {instrIn[1]}] [get_ports {instrIn[2]}] [get_ports {instrIn[3]}]     \
[get_ports {instrIn[4]}] [get_ports {instrIn[5]}] [get_ports {instrIn[6]}]     \
[get_ports {instrIn[7]}] [get_ports {instrIn[8]}] [get_ports {instrIn[9]}]     \
[get_ports {instrIn[10]}] [get_ports {instrIn[11]}] [get_ports {instrIn[12]}]  \
[get_ports {instrIn[13]}] [get_ports {instrIn[14]}] [get_ports {instrIn[15]}]  \
[get_ports {instrIn[16]}] [get_ports {instrIn[17]}] [get_ports {instrIn[18]}]  \
[get_ports {instrIn[19]}] [get_ports {instrIn[20]}] [get_ports {instrIn[21]}]  \
[get_ports {instrIn[22]}] [get_ports {instrIn[23]}] [get_ports {instrIn[24]}]  \
[get_ports {instrIn[25]}] [get_ports {instrIn[26]}] [get_ports {instrIn[27]}]  \
[get_ports {instrIn[28]}] [get_ports {instrIn[29]}] [get_ports {instrIn[30]}]  \
[get_ports {instrIn[31]}] [get_ports {dmemDataIn[0]}] [get_ports               \
{dmemDataIn[1]}] [get_ports {dmemDataIn[2]}] [get_ports {dmemDataIn[3]}]       \
[get_ports {dmemDataIn[4]}] [get_ports {dmemDataIn[5]}] [get_ports             \
{dmemDataIn[6]}] [get_ports {dmemDataIn[7]}] [get_ports {dmemDataIn[8]}]       \
[get_ports {dmemDataIn[9]}] [get_ports {dmemDataIn[10]}] [get_ports            \
{dmemDataIn[11]}] [get_ports {dmemDataIn[12]}] [get_ports {dmemDataIn[13]}]    \
[get_ports {dmemDataIn[14]}] [get_ports {dmemDataIn[15]}] [get_ports           \
{dmemDataIn[16]}] [get_ports {dmemDataIn[17]}] [get_ports {dmemDataIn[18]}]    \
[get_ports {dmemDataIn[19]}] [get_ports {dmemDataIn[20]}] [get_ports           \
{dmemDataIn[21]}] [get_ports {dmemDataIn[22]}] [get_ports {dmemDataIn[23]}]    \
[get_ports {dmemDataIn[24]}] [get_ports {dmemDataIn[25]}] [get_ports           \
{dmemDataIn[26]}] [get_ports {dmemDataIn[27]}] [get_ports {dmemDataIn[28]}]    \
[get_ports {dmemDataIn[29]}] [get_ports {dmemDataIn[30]}] [get_ports           \
{dmemDataIn[31]}] [get_ports {dmemDataIn[32]}] [get_ports {dmemDataIn[33]}]    \
[get_ports {dmemDataIn[34]}] [get_ports {dmemDataIn[35]}] [get_ports           \
{dmemDataIn[36]}] [get_ports {dmemDataIn[37]}] [get_ports {dmemDataIn[38]}]    \
[get_ports {dmemDataIn[39]}] [get_ports {dmemDataIn[40]}] [get_ports           \
{dmemDataIn[41]}] [get_ports {dmemDataIn[42]}] [get_ports {dmemDataIn[43]}]    \
[get_ports {dmemDataIn[44]}] [get_ports {dmemDataIn[45]}] [get_ports           \
{dmemDataIn[46]}] [get_ports {dmemDataIn[47]}] [get_ports {dmemDataIn[48]}]    \
[get_ports {dmemDataIn[49]}] [get_ports {dmemDataIn[50]}] [get_ports           \
{dmemDataIn[51]}] [get_ports {dmemDataIn[52]}] [get_ports {dmemDataIn[53]}]    \
[get_ports {dmemDataIn[54]}] [get_ports {dmemDataIn[55]}] [get_ports           \
{dmemDataIn[56]}] [get_ports {dmemDataIn[57]}] [get_ports {dmemDataIn[58]}]    \
[get_ports {dmemDataIn[59]}] [get_ports {dmemDataIn[60]}] [get_ports           \
{dmemDataIn[61]}] [get_ports {dmemDataIn[62]}] [get_ports {dmemDataIn[63]}]    \
[get_ports {nicDataIn[0]}] [get_ports {nicDataIn[1]}] [get_ports               \
{nicDataIn[2]}] [get_ports {nicDataIn[3]}] [get_ports {nicDataIn[4]}]          \
[get_ports {nicDataIn[5]}] [get_ports {nicDataIn[6]}] [get_ports               \
{nicDataIn[7]}] [get_ports {nicDataIn[8]}] [get_ports {nicDataIn[9]}]          \
[get_ports {nicDataIn[10]}] [get_ports {nicDataIn[11]}] [get_ports             \
{nicDataIn[12]}] [get_ports {nicDataIn[13]}] [get_ports {nicDataIn[14]}]       \
[get_ports {nicDataIn[15]}] [get_ports {nicDataIn[16]}] [get_ports             \
{nicDataIn[17]}] [get_ports {nicDataIn[18]}] [get_ports {nicDataIn[19]}]       \
[get_ports {nicDataIn[20]}] [get_ports {nicDataIn[21]}] [get_ports             \
{nicDataIn[22]}] [get_ports {nicDataIn[23]}] [get_ports {nicDataIn[24]}]       \
[get_ports {nicDataIn[25]}] [get_ports {nicDataIn[26]}] [get_ports             \
{nicDataIn[27]}] [get_ports {nicDataIn[28]}] [get_ports {nicDataIn[29]}]       \
[get_ports {nicDataIn[30]}] [get_ports {nicDataIn[31]}] [get_ports             \
{nicDataIn[32]}] [get_ports {nicDataIn[33]}] [get_ports {nicDataIn[34]}]       \
[get_ports {nicDataIn[35]}] [get_ports {nicDataIn[36]}] [get_ports             \
{nicDataIn[37]}] [get_ports {nicDataIn[38]}] [get_ports {nicDataIn[39]}]       \
[get_ports {nicDataIn[40]}] [get_ports {nicDataIn[41]}] [get_ports             \
{nicDataIn[42]}] [get_ports {nicDataIn[43]}] [get_ports {nicDataIn[44]}]       \
[get_ports {nicDataIn[45]}] [get_ports {nicDataIn[46]}] [get_ports             \
{nicDataIn[47]}] [get_ports {nicDataIn[48]}] [get_ports {nicDataIn[49]}]       \
[get_ports {nicDataIn[50]}] [get_ports {nicDataIn[51]}] [get_ports             \
{nicDataIn[52]}] [get_ports {nicDataIn[53]}] [get_ports {nicDataIn[54]}]       \
[get_ports {nicDataIn[55]}] [get_ports {nicDataIn[56]}] [get_ports             \
{nicDataIn[57]}] [get_ports {nicDataIn[58]}] [get_ports {nicDataIn[59]}]       \
[get_ports {nicDataIn[60]}] [get_ports {nicDataIn[61]}] [get_ports             \
{nicDataIn[62]}] [get_ports {nicDataIn[63]}]]
