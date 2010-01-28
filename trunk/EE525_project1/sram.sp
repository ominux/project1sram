
** SRAM simulation stimulus file for hspiceD


*****************************Hspice 45nm node model selection ********************

.INCLUDE "/automnt/home/lab.apps/vlsiapps/kits/FreePDK45/ncsu_basekit/models/hspice/hspice_nom.include"



.GLOBAL vdd
.GLOBAL vdd!

vvdd vdd gnd DC=1.1
vvdd! vdd! gnd! DC=1.1


*****************************Simulation settings ********************************

.TRAN 2e-12 40ns START=0.0
.OP

.TEMP 25
.OPTION
+    ARTIST=2
+    INGOLD=2
+    PARHIER=LOCAL
+    PSF=2
+    POST


*****************************Include your netlist here **************************

*.INCLUDE "netlist"
.INCLUDE "SRAM_TopLevel/SRAM_TopLevel.pex.netlist"


*to simulate your SRAM, you may create an instance in this file, or 
*comment out the .subckt and .end in your sram_layout.pex.netlist


.vec testvector


*****************************Clock define ***********************************

* you may change the clk frequency if you want to speed up or slow down the simulation 
* if your SRAM is slower, you might need to slow down the clock frequency
* change tunit (the time unit) in the testvector if you change anything here
Vclk inclk gnd pulse (0V 1.1V 30ps 20ps 20ps 0.98ns 2ns)
Vclkb inclk_ gnd pulse (1.1V 0V 30ps 20ps 20ps 0.98ns 2ns)


*****************************INPUTS ***********************************

* the address inputs
xa4 vdd gnd ain4 a4 minbuff
xa3 vdd gnd ain3 a3 minbuff
xa2 vdd gnd ain2 a2 minbuff
xa1 vdd gnd ain1 a1 minbuff
xa0 vdd gnd ain0 a0 minbuff

xab4 vdd gnd abin4 _a4 minbuff
xab3 vdd gnd abin3 _a3 minbuff
xab2 vdd gnd abin2 _a2 minbuff
xab1 vdd gnd abin1 _a1 minbuff
xab0 vdd gnd abin0 _a0 minbuff


* data inputs
xd0 vdd gnd din0 d0 minbuff
xd1 vdd gnd din1 d1 minbuff
xd2 vdd gnd din2 d2 minbuff
xd3 vdd gnd din3 d3 minbuff
xd4 vdd gnd din4 d4 minbuff
xd5 vdd gnd din5 d5 minbuff
xd6 vdd gnd din6 d6 minbuff
xd7 vdd gnd din7 d7 minbuff


* read/write mode control
xwe vdd gnd read_in r_w minbuff


* clock input and not_clock input
xclk vdd gnd inclk clk minbuff
xclkb vdd gnd inclk_ clk_ minbuff


*****************************OUTPUTS ***********************************

* the outputs with 25f load
cw0 w0 gnd 25f 
cw1 w1 gnd 25f
cw2 w2 gnd 25f
cw3 w3 gnd 25f
cw4 w4 gnd 25f
cw5 w5 gnd 25f
cw6 w6 gnd 25f
cw7 w7 gnd 25f

c_w0 _w0 gnd 25f 
c_w1 _w1 gnd 25f
c_w2 _w2 gnd 25f
c_w3 _w3 gnd 25f
c_w4 _w4 gnd 25f
c_w5 _w5 gnd 25f
c_w6 _w6 gnd 25f
c_w7 _w7 gnd 25f




*****************************Given subckts ***********************************

* This is really a 2X buf
* using this to drive all inputs
.subckt minbuff  VDD GND A Y
mM0 GND 5 Y GND NMOS_VTL L=5e-08 W=5e-07 AD=8.75e-14 AS=5.25e-14 PD=1.49e-06
+ PS=1.21e-06
mM1 5 A GND GND NMOS_VTL L=5e-08 W=2.5e-07 AD=2.625e-14 AS=8.75e-14 PD=7.1e-07
+ PS=1.49e-06
mM2 VDD 5 Y VDD PMOS_VTL L=5e-08 W=1e-06 AD=1.75e-13 AS=1.05e-13 PD=2.49e-06
+ PS=2.21e-06
mM3 5 A VDD VDD PMOS_VTL L=5e-08 W=5e-07 AD=5.25e-14 AS=1.75e-13 PD=1.21e-06
+ PS=2.49e-06
c_4 Y 0 0.117784f
c_8 GND 0 0.0661014f
c_12 VDD 0 0.0922986f
c_16 A 0 0.0837548f
c_21 5 0 0.240126f
cc_1 GND Y 0.0866284f
cc_2 VDD Y 0.0886059f
cc_3 5 Y 0.117455f
cc_4 A GND 0.00209883f
cc_5 5 GND 0.105626f
cc_6 A VDD 0.00162454f
cc_7 5 VDD 0.0772828f
cc_8 5 A 0.155049f
.ends

.end
