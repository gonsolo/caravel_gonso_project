////////////////////////////////////////////////////////////////////////////
// SPDX-FileCopyrightText: 2022 , Julien OURY                       
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
// SPDX-FileContributor: Created by Julien OURY <julien.oury@outlook.fr>
//
////////////////////////////////////////////////////////////////////////////

`default_nettype none

`timescale 1 ns / 1 ps

module string_led_controller_tb;
  reg clock;
  reg RSTB;
  reg CSB;
  reg power1, power2;
  reg power3, power4;

  wire gpio;
  wire [37:0] mprj_io;
  wire [15:0] checkbits;
  //wire [15:0] errorbits;
  
  wire [7:0]    color;
  //wire [5:0]    pixel_x;
  //wire [5:0]    pixel_y;
  wire          pixel_write;

  reg [7:0]  cmd_addr;
  reg [7:0]  cmd_data;

  assign checkbits = mprj_io[31:16];
  //assign errorbits = mprj_io[15:0];
  
  assign color = mprj_io[7:0];
  //assign pixel_x = mprj_io[13:8]
  //assign pixel_y = mprj_io[19:14]
  assign pixel_write = mprj_io[8];

  assign (pull1,pull0)  mprj_io[37:0] = 38'b11111111111111111111111111111111111111;
  //assign (pull1,pull0)  mprj_io[37:8] = 30'b111111111111111111111111111111;
  //assign (pull1,pull0)  mprj_io[7:0] = 8'h80;
  //assign color = 8'h00;

  // External clock is used by default.  Make this artificially fast for the
  // simulation.  Normally this would be a slow clock and the digital PLL
  // would be the fast clock.

  always #12.5 clock <= (clock === 1'b0);

  initial begin
    clock = 0;
  end

  initial begin
    $dumpfile("string_led_controller.vcd");
    $dumpvars(0, string_led_controller_tb);

    // Repeat cycles of 1000 clock edges as needed to complete testbench
    //repeat (7000) begin
    repeat (40) begin
      repeat (1000) @(posedge clock);
      // $display("+1000 cycles");
    end
    $display("%c[1;31m",27);
    `ifdef GL
      $display ("Monitor: Timeout, Test Mega-Project WB Port (GL) Failed");
    `else
      $display ("Monitor: Timeout, Test Mega-Project WB Port (RTL) Failed");
    `endif
    $display("%c[0m",27);
    $finish;
  end

  integer image;

  initial begin

    wait(checkbits == 16'hAB60);
    $display("Starting");


    wait (checkbits == 16'hAB61);

    $display("Color: %0d", color);

    $display("Writing image");
    image = $fopen("image.ppm", "w");
    $fdisplay(image, "P3");
    $fdisplay(image, "64 64");
    $fdisplay(image, "255");

    repeat (64) begin
            repeat (64) begin
                    $fdisplay(image, color);
                    $fdisplay(image, color);
                    $fdisplay(image, color);
            end
            $fwrite(image, "\n");
    end

    wait (checkbits == 16'hAB62);
    $display("Checking AB62 ok");

    wait (checkbits == 16'hAB63);
    $display("Checking AB63 ok");

    $finish;
  end

  initial begin
    RSTB <= 1'b0;
    CSB  <= 1'b1;    // Force CSB high
    #2000;
    RSTB <= 1'b1;        // Release reset
    #100000;
    CSB = 1'b0;    // CSB can be released
  end

  initial begin    // Power-up sequence
    power1 <= 1'b0;
    power2 <= 1'b0;
    #200;
    power1 <= 1'b1;
    #200;
    power2 <= 1'b1;
  end

  wire flash_csb;
  wire flash_clk;
  wire flash_io0;
  wire flash_io1;

  wire VDD3V3 = power1;
  wire VDD1V8 = power2;
  wire VSS = 1'b0;

  caravel uut (
    .vddio    (VDD3V3),
    .vddio_2  (VDD3V3),
    .vssio    (VSS),
    .vssio_2  (VSS),
    .vdda    (VDD3V3),
    .vssa    (VSS),
    .vccd    (VDD1V8),
    .vssd    (VSS),
    .vdda1    (VDD3V3),
    .vdda1_2  (VDD3V3),
    .vdda2    (VDD3V3),
    .vssa1    (VSS),
    .vssa1_2  (VSS),
    .vssa2    (VSS),
    .vccd1    (VDD1V8),
    .vccd2    (VDD1V8),
    .vssd1    (VSS),
    .vssd2    (VSS),
    .clock    (clock),
    .gpio     (gpio),
    .mprj_io  (mprj_io),
    .flash_csb(flash_csb),
    .flash_clk(flash_clk),
    .flash_io0(flash_io0),
    .flash_io1(flash_io1),
    .resetb    (RSTB)
  );

  spiflash #(
    .FILENAME("string_led_controller.hex")
  ) spiflash (
    .csb(flash_csb),
    .clk(flash_clk),
    .io0(flash_io0),
    .io1(flash_io1),
    .io2(),      // not used
    .io3()      // not used
  );

endmodule
`default_nettype wire
