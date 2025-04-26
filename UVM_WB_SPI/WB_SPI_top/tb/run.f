// 64 bit option for AWS labs
-64
-access
+rwc
//-gui
-sv 
-timescale 1ns/1ns
+SVSEED=random
//+UVM_TESTNAME=TEST_1
//+UVM_TESTNAME=TEST_2
//+UVM_TESTNAME=TEST_3
//+UVM_TESTNAME=TEST_4
+UVM_TESTNAME=TEST_5
+UVM_VERBOSITY=UVM_HIGH

../../SPI_rtl/fifo4.v
../../SPI_rtl/simple_spi_top.v

// include directories
//*** add incdir include directories here
-incdir ../../Wishbone_Master_UVC/sv/
-incdir ../../SPI_Slave_UVC/sv/
-incdir ../../SPI_rtl/
-incdir ../sv/




// compile files
//*** add compile files here
../../Wishbone_Master_UVC/sv/wishbone_pkg.sv
../../Wishbone_Master_UVC/sv/wishbone_if.sv
../../SPI_Slave_UVC/sv/spi_pkg.sv
../../SPI_Slave_UVC/sv/spi_if.sv



hw_top.sv
SPI_top.sv
