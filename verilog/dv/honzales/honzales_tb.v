// Copyright 2022 Andreas Wendleder

`default_nettype none

`timescale 1 ns / 1 ps

module honzales_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;

        // Set input to 1 for counting, 0 to return 0
        assign mprj_io[32] = 1'b1;

	assign mprj_io_0 = mprj_io[7:0];
	// assign mprj_io_0 = {mprj_io[8:4],mprj_io[2:0]};

	assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
	// assign mprj_io[3] = 1'b1;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("honzales.vcd");
		$dumpvars(0, honzales_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Mega-Project Honzales (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Mega-Project Honzales (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

        integer image;

	initial begin
                image = $fopen("image.ppm", "w");
                $fdisplay(image, "P3");
                $fdisplay(image, "64 64");
                $fdisplay(image, "255");

	        // Observe Output pins [7:0]
		wait(mprj_io_0 == 8'h01);

                // Write a red image after first value is encountered
                repeat (64) begin
                        repeat (64) begin
                                $fwrite(image, "255 0 0 ");
                        end
                        $fwrite(image, "\n");
                end

		wait(mprj_io_0 == 8'h02);
		wait(mprj_io_0 == 8'h03);
		wait(mprj_io_0 == 8'h04);
		wait(mprj_io_0 == 8'h05);
		wait(mprj_io_0 == 8'h06);
		wait(mprj_io_0 == 8'h07);
		wait(mprj_io_0 == 8'h08);
		wait(mprj_io_0 == 8'h09);
		wait(mprj_io_0 == 8'h0A);   
		wait(mprj_io_0 == 8'hFF);
		wait(mprj_io_0 == 8'h00);
		
		`ifdef GL
	    	$display("Monitor: Test 1 Mega-Project Honzales (GL) Passed");
		`else
		    $display("Monitor: Test 1 Mega-Project Honzales (RTL) Passed");
		`endif

                $fclose(image);

	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#300000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

	always @(mprj_io) begin
		#1 $display("MPRJ-IO state = %b ", mprj_io[7:0]);
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("honzales.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
