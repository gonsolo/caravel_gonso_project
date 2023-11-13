// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// VCS coverage exclude_file
module memory_combMem(	// honzales/src/Honzales.scala:40:19
  input  [2:0] R0_addr,
  input        R0_en,
               R0_clk,
  input  [2:0] W0_addr,
  input        W0_en,
               W0_clk,
  input  [7:0] W0_data,
  output [7:0] R0_data);

  reg  [7:0] Memory[0:7];	// honzales/src/Honzales.scala:40:19
  wire [7:0] _GEN;	// honzales/src/Honzales.scala:40:19
  /* synopsys infer_mux_override */
  assign _GEN = Memory[R0_addr] /* cadence map_to_mux */;	// honzales/src/Honzales.scala:40:19
  always @(posedge W0_clk) begin	// honzales/src/Honzales.scala:40:19
    if (W0_en)	// honzales/src/Honzales.scala:40:19
      Memory[W0_addr] <= W0_data;	// honzales/src/Honzales.scala:40:19
  end // always @(posedge)
  `ifndef SYNTHESIS	// honzales/src/Honzales.scala:40:19
    `ifdef RANDOMIZE_MEM_INIT	// honzales/src/Honzales.scala:40:19
      integer initvar;	// honzales/src/Honzales.scala:40:19
      reg [31:0] _RANDOM_MEM;	// honzales/src/Honzales.scala:40:19
    `endif // RANDOMIZE_MEM_INIT
    initial begin	// honzales/src/Honzales.scala:40:19
      `INIT_RANDOM_PROLOG_	// honzales/src/Honzales.scala:40:19
      `ifdef RANDOMIZE_MEM_INIT	// honzales/src/Honzales.scala:40:19
        for (initvar = 0; initvar < 8; initvar = initvar + 1) begin
          _RANDOM_MEM = {`RANDOM};
          Memory[initvar] = _RANDOM_MEM[7:0];
        end	// honzales/src/Honzales.scala:40:19
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // not def SYNTHESIS
  assign R0_data = R0_en ? _GEN : 8'bx;	// honzales/src/Honzales.scala:40:19
endmodule

module Honzales(	// <stdin>:3:10
  input         clock,
                reset,
  input  [19:0] io_input,
  input         io_valid,
                io_strobe,
  input  [7:0]  io_color_in,
  input  [31:0] io_wishbone_address,
                io_wbs_dat_i,
  output [19:0] io_output,
  output [7:0]  io_color_out,
  output [31:0] io_wbs_dat_o);

  wire [7:0] _memory_ext_R0_data;	// honzales/src/Honzales.scala:40:19
  reg        state;	// honzales/src/Honzales.scala:41:22
  always @(posedge clock) begin
    if (reset)
      state <= 1'h1;	// <stdin>:3:10, honzales/src/Honzales.scala:41:22
    else
      state <= ~state;	// honzales/src/Honzales.scala:40:19, :41:22, :47:18
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:3:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:3:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:3:10
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;	// <stdin>:3:10
    initial begin	// <stdin>:3:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:3:10
        `INIT_RANDOM_PROLOG_	// <stdin>:3:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:3:10
        _RANDOM_0 = `RANDOM;	// <stdin>:3:10
        state = _RANDOM_0[0];	// honzales/src/Honzales.scala:41:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:3:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:3:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  memory_combMem memory_ext (	// honzales/src/Honzales.scala:40:19
    .R0_addr (3'h0),	// honzales/src/Honzales.scala:49:19
    .R0_en   (~state & ~state),	// honzales/src/Honzales.scala:40:19, :41:22, :47:18
    .R0_clk  (clock),
    .W0_addr (3'h0),	// honzales/src/Honzales.scala:49:19
    .W0_en   (state),	// honzales/src/Honzales.scala:41:22
    .W0_clk  (clock),
    .W0_data (8'h2A),	// honzales/src/Honzales.scala:49:19
    .R0_data (_memory_ext_R0_data)
  );
  assign io_output = state ? 20'h0 : {12'h0, _memory_ext_R0_data};	// <stdin>:3:10, honzales/src/Honzales.scala:40:19, :41:22, :43:13, :47:18, :53:17
  assign io_color_out = 8'h0;	// <stdin>:3:10, honzales/src/Honzales.scala:44:16
  assign io_wbs_dat_o = 32'h0;	// <stdin>:3:10, honzales/src/Honzales.scala:45:16
endmodule

