// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
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

module Diffuse(	// <stdin>:633:10
  input         clock,
                reset,
                input_valid,
  input  [31:0] input_bits_reflectance,
  input         output_ready,
  output        input_ready,
                output_valid,
  output [31:0] output_bits_out);

  reg  busy;	// src/main/scala/bsdf/Diffuse.scala:22:21
  reg  resultValid;	// src/main/scala/bsdf/Diffuse.scala:23:28
  wire _T = output_ready & resultValid;	// src/main/scala/bsdf/Diffuse.scala:23:28, :39:23
  always @(posedge clock) begin
    if (reset) begin
      busy <= 1'h0;	// src/main/scala/bsdf/Diffuse.scala:22:21
      resultValid <= 1'h0;	// src/main/scala/bsdf/Diffuse.scala:22:21, :23:28
    end
    else if (busy) begin	// src/main/scala/bsdf/Diffuse.scala:22:21
      busy <= ~_T & busy;	// src/main/scala/bsdf/Diffuse.scala:22:21, :39:{23,39}, :40:12
      resultValid <= ~_T;	// src/main/scala/bsdf/Diffuse.scala:22:21, :23:28, :39:{23,39}, :40:12
    end
    else	// src/main/scala/bsdf/Diffuse.scala:22:21
      busy <= input_valid | busy;	// src/main/scala/bsdf/Diffuse.scala:22:21, :45:23, :49:12
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:633:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:633:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:633:10
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;	// <stdin>:633:10
    logic [31:0] _RANDOM_1;	// <stdin>:633:10
    initial begin	// <stdin>:633:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:633:10
        `INIT_RANDOM_PROLOG_	// <stdin>:633:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:633:10
        _RANDOM_0 = `RANDOM;	// <stdin>:633:10
        _RANDOM_1 = `RANDOM;	// <stdin>:633:10
        busy = _RANDOM_0[31];	// src/main/scala/bsdf/Diffuse.scala:22:21
        resultValid = _RANDOM_1[0];	// src/main/scala/bsdf/Diffuse.scala:23:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:633:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:633:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign input_ready = ~busy & input_valid | ~busy;	// <stdin>:633:10, src/main/scala/bsdf/Diffuse.scala:22:21, :26:{15,18}, :35:14, :45:23
  assign output_valid = resultValid;	// <stdin>:633:10, src/main/scala/bsdf/Diffuse.scala:23:28
  assign output_bits_out = 32'h29A;	// <stdin>:633:10, src/main/scala/bsdf/Diffuse.scala:37:21
endmodule

