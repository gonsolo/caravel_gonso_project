/* Copyright 2022 Andreas Wendleder
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

/*
	Honzales test: TODO
*/

#define reg_honzales_data       (*(volatile uint32_t*)0x3000000)

void main()
{
        // Enable wishbone  bus
        reg_spi_enable = 1;
        reg_wb_enable = 1;

	// Configure lower 8-IOs as user output
	// Observe counter value in the testbench
	reg_mprj_io_0 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_1 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_2 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_3 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_4 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_5 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_6 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_7 =  GPIO_MODE_USER_STD_OUTPUT;

	reg_mprj_io_8 =  GPIO_MODE_USER_STD_OUTPUT;

        // Configure io as input
	reg_mprj_io_32 =  GPIO_MODE_USER_STD_INPUT_NOPULL;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1) {
                // just wait a bit
        }

        // Flag start of the test
        reg_mprj_datal = 0xAB600000;

        reg_honzales_data = 0xFFFFFFFF;

        // From user project
        //reg_la2_oenb = reg_la2_iena = 0x00000000;    // [95:64]

        // Flag start of the test
        //reg_mprj_datal = 0xAB600000;

        //reg_mprj_slave = 0x00002710;
        //reg_mprj_datal = 0xAB610000;
        //if (reg_mprj_slave == 0x2B3D) {
        //        reg_mprj_datal = 0xAB610000;
        //}

}

