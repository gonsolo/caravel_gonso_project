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

module gonso #(
  parameter TECHNO =  1        , // TECHNO RAM (0:inferred, 1:SkyWater)
  parameter ASIZE  = 32        , // Size of memory buffer bus (bits)
  parameter PSIZE  = 32          // Size of prescaler counter(bits)
)(
`ifdef USE_POWER_PINS
  inout  wire        vccd1     , // User area 1 1.8V supply
  inout  wire        vssd1     , // User area 1 digital ground
`endif

  input  wire        rst_n     , // Asynchronous reset (active low)
  input  wire        clk       , // Clock (rising edge)

  // Wishbone bus
  input  wire        wbs_cyc_i , // Wishbone strobe/request
  input  wire        wbs_stb_i , // Wishbone strobe/request
  input  wire [31:0] wishbone_address,
  input  wire        wbs_we_i  , // Wishbone write (1:write, 0:read)
  input  wire [31:0] wbs_dat_i , // Wishbone data output
  input  wire [3:0]  wbs_sel_i , // Wishbone byte enable
  output wire [31:0] wbs_dat_o , // Wishbone data input
  output wire        wbs_ack_o , // Wishbone acknowlegement

  // Interrupt
  output wire        irq         // Interrupt
);

  wire             controller_en   ;
  wire [PSIZE-1:0] gonso;
  wire [PSIZE-1:0] gonso_plus;
  wire [7:0]       gonso_color;
  wire             tick            ;
  wire             valid           ;
  wire             polarity        ;
  wire             bit_value       ;
  wire             ready           ;
  wire [3:0]       w_count         ;
  wire [ASIZE-1:0] w_first         ;
  wire [ASIZE-1:0] w_last          ;
  wire             start           ;
  wire             progress        ;

  wire             cs0_n           ;
  wire             we0_n           ;
  wire [ASIZE-1:0] addr0           ;
  wire [7:0]       wdata0          ;
  wire [7:0]       rdata0          ;
  wire             cs1_n           ;
  wire [ASIZE-1:0] addr1           ;
  wire [7:0]       rdata1          ;

  generic_sram_1rw1r #(
    .TECHNO(TECHNO),
    .ASIZE (ASIZE ),
    .DSIZE (8     )
  ) i_memory (
  `ifdef USE_POWER_PINS
    .vccd1    (vccd1 ),
    .vssd1    (vssd1 ),
  `endif
    .clk      (clk   ),

    // Port 0 (R/W)
    .cs0_n    (cs0_n ),
    .we0_n    (we0_n ),
    .addr0    (addr0 ),
    .wdata0   (wdata0),
    .rdata0   (rdata0),

    // Port 1 (R/W)
    .cs1_n    (cs1_n ),
    .addr1    (addr1 ),
    .rdata1   (rdata1)
  );

  gonso_registers #(
    .ASIZE(ASIZE),
    .PSIZE(PSIZE)
  ) i_registers (
    .rst_n           (rst_n        ),
    .clk             (clk          ),
    .controller_en   (controller_en),
    .gonso           (gonso),
    .gonso_plus      (gonso_plus),
    .gonso_color     (gonso_color),
    .polarity        (polarity     ),
    .w_count         (w_count      ),
    .w_first         (w_first      ),
    .w_last          (w_last       ),
    .start           (start        ),
    .progress        (progress     ),
    .wbs_cyc_i       (wbs_cyc_i    ),
    .wbs_stb_i       (wbs_stb_i    ),
    .wishbone_address   (wishbone_address),
    .wbs_we_i        (wbs_we_i     ),
    .wbs_dat_i       (wbs_dat_i    ),
    .wbs_sel_i       (wbs_sel_i    ),
    .wbs_dat_o       (wbs_dat_o    ),
    .wbs_ack_o       (wbs_ack_o    ),
    .irq             (irq          ),
    .cs_n            (cs0_n        ),
    .we_n            (we0_n        ),
    .addr            (addr0        ),
    .wdata           (wdata0       ),
    .rdata           (rdata0       )
  );

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Registers
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gonso_registers #(
  parameter ASIZE = 32                    , // Size of memory buffer bus (bits)
  parameter PSIZE = 32                      // Size of prescaler counter(bits)
)(

  input                   rst_n           , // Asynchronous reset (active low)
  input                   clk             , // Clock (rising edge)

  // Configuration
  output reg              controller_en   , // Controller enable (active high)
  output reg  [PSIZE-1:0] gonso,            // gonso
  output reg  [PSIZE-1:0] gonso_plus      , // gonso plus
  output reg  [7:0] gonso_color           , // gonso color
  output reg              polarity        , // Polarity of output signal

  // Sequencer
  output reg  [3:0]       w_count         , // Number of iteration
  output reg  [ASIZE-1:0] w_first         , // First word index
  output reg  [ASIZE-1:0] w_last          , // Last word index
  output reg              start           , // Start strobe (active high)
  input  wire             progress        , // Progress status

  // Wishbone bus
  input  wire             wbs_cyc_i       , // Wishbone strobe/request
  input  wire             wbs_stb_i       , // Wishbone strobe/request
  input  wire [31:0]      wishbone_address,
  input  wire             wbs_we_i        , // Wishbone write (1:write, 0:read)
  input  wire [31:0]      wbs_dat_i       , // Wishbone data output
  input  wire [ 3:0]      wbs_sel_i       , // Wishbone byte enable
  output reg  [31:0]      wbs_dat_o       , // Wishbone data input
  output wire             wbs_ack_o       , // Wishbone acknowlegement

  // Interrupt
  output reg              irq             , // Interrupt

  // Memory
  output reg              cs_n            , // Chip select (active low)
  output wire             we_n            , // Write enable (active low)
  output reg  [ASIZE-1:0] addr            , // Adress bus
  output reg  [7:0]       wdata           , // Data bus (write)
  input  wire [7:0]       rdata             // Data bus (read)
 );

  localparam gonso_reg_addr              = 32'h30030004;
  localparam gonso_plus_reg_addr         = 32'h30030008;
  localparam gonso_color_reg_addr        = 32'h3003000c;

  wire        valid;
  wire [31:0] wstrb;
  //wire [1:0]  wbs_addr;

  reg         irq_en;
  reg         ready;
  reg         last_progress;

  integer i = 0;

  assign valid     = wbs_cyc_i && wbs_stb_i;
  assign wstrb     = {{8{wbs_sel_i[3]}}, {8{wbs_sel_i[2]}}, {8{wbs_sel_i[1]}}, {8{wbs_sel_i[0]}}} & {32{wbs_we_i}};
  assign wbs_ack_o = ready;
  assign we_n      = 1'b0;

  wire [PSIZE-1:0]      gonso_plus_wire;
  reg [7:0]            gonso_color_in_wire;
  wire [7:0]            gonso_color_out_wire;

  Honzales honzales (
    .clock(clk),
    .reset(rst_n),
    .io_input(gonso),
    .io_output(gonso_plus_wire),
    .io_color_in(gonso_color_in_wire),
    .io_color_out(gonso_color_out_wire)
  );

  always @(posedge clk) begin
        gonso_plus <= gonso_plus_wire;
        //gonso_color <= 8'h80;
        gonso_color_in_wire <= 8'h00;
        gonso_color <= gonso_color_out_wire;
  end

  always @(negedge rst_n or posedge clk) begin
    if (rst_n == 1'b0) begin
      cs_n          <= 1'b1;
      addr          <= {(ASIZE){1'b0}};
      wdata         <= 8'h00;
      ready         <= 1'b0;
      wbs_dat_o     <= 32'h00000000;
      controller_en <= 1'b0;
      irq_en        <= 1'b0;
      polarity      <= 1'b0;
      gonso         <= {(PSIZE){1'b0}};
      gonso_plus    <= {(PSIZE){1'b0}};
      gonso_color   <= {(8){1'b0}};
      w_count       <= 4'b0000;
      w_first       <= {(ASIZE){1'b0}};
      w_last        <= {(ASIZE){1'b0}};
      start         <= 1'b0;
      irq           <= 1'b0;
      last_progress <= 1'b0;
    end else begin

      if (valid && !ready) begin
        if (wishbone_address[12] == 1'b0) begin // Register access
          case (wishbone_address)
            gonso_reg_addr : begin
              for (i = 0; i < 32; i = i + 1) begin
                if (i >= PSIZE) begin
                  wbs_dat_o[i] <= 1'b0 ;
                end else begin
                  wbs_dat_o[i] <= gonso[i] ; if (wstrb[i]) gonso[i] <= wbs_dat_i[i];

                end
              end
            end
            gonso_plus_reg_addr : begin
              for (i = 0; i < 32; i = i + 1) begin
                if (i >= PSIZE) begin
                  wbs_dat_o[i] <= 1'b0 ;
                end else begin
                  wbs_dat_o[i] <= gonso_plus[i] ; if (wstrb[i]) gonso_plus[i] <= wbs_dat_i[i];
                end
              end
            end
            gonso_color_reg_addr : begin
              for (i = 0; i < 32; i = i + 1) begin
                if (i >= 8) begin
                  wbs_dat_o[i] <= 1'b0 ;
                end else begin
                  wbs_dat_o[i] <= gonso_color[i] ; if (wstrb[i]) gonso_color[i] <= wbs_dat_i[i];
                end
              end
            end
          endcase

          cs_n <= 1'b1;

        end
	ready     <= 1'b1;
      end else begin
        cs_n      <= 1'b1;
        ready     <= 1'b0;
      end

      if ((irq_en == 1'b1) && (last_progress == 1'b1) && (progress == 1'b0)) begin
        irq <= 1'b1;
      end else begin
        irq <= 1'b0;
      end

      last_progress <= progress;

    end
  end

endmodule

