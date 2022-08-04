////////////////////////////////////////////////////////////////////////////
// SPDX-FileCopyrightText: 2022 Andreas Wendleder
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
// SPDX-FileContributor: Created by Andreas Wendleder
// <andreas.wendleder@gmail.com>
//
////////////////////////////////////////////////////////////////////////////

module user_proj_example(

`ifdef USE_POWER_PINS
    inout  wire vccd1,  // User area 1 1.8V supply
    inout  wire vssd1,  // User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input  wire         wb_clk_i,
    input  wire         wb_rst_i,
    input  wire         wbs_stb_i,
    input  wire         wbs_cyc_i,
    input  wire         wbs_we_i,
    input  wire [3:0]   wbs_sel_i,
    input  wire [31:0]  wbs_dat_i,
    input  wire [31:0]  wbs_adr_i,
    output wire         wbs_ack_o,
    output wire [31:0]  wbs_dat_o,

    // Logic Analyzer Signals
    input  wire [127:0] la_data_in,
    output wire [127:0] la_data_out,
    input  wire [127:0] la_oenb,

    // IOs
    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output wire [2:0] irq
);

  wire rst_n;
  
 
  // IO
  assign io_out[37]    =       1'b0  ;
  assign io_out[31: 0] = {(32){1'b0}};

  assign io_oeb[37]    =       1'b1  ;
  assign io_oeb[36]    =       1'b0  ; // String LED outputs
  assign io_oeb[35:32] = {( 4){1'b0}}; // MOTOR outputs
  assign io_oeb[31: 0] = {(32){1'b1}};
  
  // Gonso: Temporary
  //assign io_out[8]      =       1'b1;
  //assign io_out[7:0]    =       8'h00;
  reg [7:0] bla = 8'h00;
  assign io_out[7:0] = bla;
  always @(posedge wb_clk_i) begin
    bla = 8'h00;
  end

  // LA
  assign la_data_out = {(128){1'b0}};
  
  assign irq[2] = 1'b0;
  
  assign rst_n = ~wb_rst_i;

  wire [7:0] blabla;
 
  string_led_controller #(
    .TECHNO( 0),
    .ASIZE ( 6),
    .PSIZE (20)
  ) i_string_led_controller (
`ifdef USE_POWER_PINS
	.vccd1     (vccd1       ),
	.vssd1     (vssd1       ),
`endif
    .rst_n     (rst_n       ),
    .clk       (wb_clk_i    ),

    .wbs_cyc_i (wbs_cyc_i),
    .wbs_stb_i (wbs_stb_i),
    .wbs_adr_i (wbs_adr_i),
    .wbs_we_i  (wbs_we_i),
    .wbs_dat_i (wbs_dat_i),
    .wbs_sel_i (wbs_sel_i),
    .wbs_dat_o (wbs_dat_o),
    .wbs_ack_o (wbs_ack_o),

    .irq       (irq[1]      )
  );

endmodule
