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

module gonso (
        `ifdef USE_POWER_PINS
        inout  wire        vccd1                ,
        inout  wire        vssd1                ,
        `endif

        input  wire        rst_n                ,       // Asynchronous reset (active low)
        input  wire        clk                  ,

        // Wishbone bus
        input  wire        wbs_cyc_i            ,
        input  wire        wbs_stb_i            ,
        input  wire [31:0] wishbone_address     ,
        input  wire        wbs_we_i             ,       // Wishbone write (1:write, 0:read)
        input  wire [31:0] wbs_dat_i            ,
        input  wire [3:0]  wbs_sel_i            ,
        output reg  [31:0] wbs_dat_o            ,
        output wire        wbs_ack_o
);

        wire            valid                   ;
        wire [31:0]     wstrb                   ;
        wire [19:0]     gonso_plus_wire         ;
        wire [7:0]      gonso_color_out_wire    ;

        reg  [19:0]     gonso                   ;
        reg  [19:0]     gonso_plus              ;
        reg  [7:0]      gonso_color             ;
        reg             ready                   ;
        reg             start                   ;
        reg [5:0]       addr0                   ;
        reg [7:0]       wdata0                  ;
        reg [7:0]       gonso_color_in_wire     ;

        localparam      gonso_reg_addr              = 32'h30030004;
        localparam      gonso_plus_reg_addr         = 32'h30030008;
        localparam      gonso_color_reg_addr        = 32'h3003000c;

        integer i = 0;

        assign valid     = wbs_cyc_i && wbs_stb_i;
        assign wstrb     = {{8{wbs_sel_i[3]}}, {8{wbs_sel_i[2]}}, {8{wbs_sel_i[1]}}, {8{wbs_sel_i[0]}}} & {32{wbs_we_i}};
        assign wbs_ack_o = ready;

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
                gonso_color_in_wire <= 8'h00;
                gonso_color <= gonso_color_out_wire;
        end

        always @(negedge rst_n or posedge clk) begin
                if (rst_n == 1'b0) begin
                        addr0          <= {(6){1'b0}};
                        wdata0         <= 8'h00;
                        ready         <= 1'b0;
                        wbs_dat_o     <= 32'h00000000;
                        gonso         <= {(20){1'b0}};
                        gonso_plus    <= {(20){1'b0}};
                        gonso_color   <= {(8){1'b0}};
                        start         <= 1'b0;
                end else begin

                        if (valid && !ready) begin
                                case (wishbone_address)
                                        gonso_reg_addr : begin
                                                for (i = 0; i < 32; i = i + 1) begin
                                                        if (i >= 20) begin
                                                                wbs_dat_o[i] <= 1'b0 ;
                                                        end else begin
                                                                wbs_dat_o[i] <= gonso[i] ; if (wstrb[i]) gonso[i] <= wbs_dat_i[i];

                                                        end
                                                end
                                        end
                                        gonso_plus_reg_addr : begin
                                                for (i = 0; i < 32; i = i + 1) begin
                                                        if (i >= 20) begin
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
                                ready     <= 1'b1;
                        end else begin
                                ready     <= 1'b0;
                        end
                end
        end
endmodule

