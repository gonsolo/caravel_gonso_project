module Honzales(
  input         clock,
  input         reset,
  input  [19:0] io_input,
  input         io_valid,
  input         io_strobe,
  output [19:0] io_output,
  output [7:0]  io_unused,
  input  [7:0]  io_color_in,
  output [7:0]  io_color_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] counterValue; // @[Counter.scala 61:40]
  wire [7:0] _wrap_value_T_1 = counterValue + 8'h1; // @[Counter.scala 77:24]
  assign io_output = io_input + 20'h1; // @[Honzales.scala 24:25]
  assign io_unused = counterValue; // @[Honzales.scala 29:19]
  assign io_color_out = io_color_in + 8'h80; // @[Honzales.scala 31:31]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 61:40]
      counterValue <= 8'h0; // @[Counter.scala 61:40]
    end else begin
      counterValue <= _wrap_value_T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  counterValue = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Testbench(
  input         clock,
  input         reset,
  input  [19:0] io_input,
  input         io_valid,
  input         io_strobe,
  output [19:0] io_output,
  output [7:0]  io_unused,
  input  [7:0]  io_color_in,
  output [7:0]  io_color_out
);
  wire  honzales_clock; // @[Testbench.scala 24:24]
  wire  honzales_reset; // @[Testbench.scala 24:24]
  wire [19:0] honzales_io_input; // @[Testbench.scala 24:24]
  wire  honzales_io_valid; // @[Testbench.scala 24:24]
  wire  honzales_io_strobe; // @[Testbench.scala 24:24]
  wire [19:0] honzales_io_output; // @[Testbench.scala 24:24]
  wire [7:0] honzales_io_unused; // @[Testbench.scala 24:24]
  wire [7:0] honzales_io_color_in; // @[Testbench.scala 24:24]
  wire [7:0] honzales_io_color_out; // @[Testbench.scala 24:24]
  Honzales honzales ( // @[Testbench.scala 24:24]
    .clock(honzales_clock),
    .reset(honzales_reset),
    .io_input(honzales_io_input),
    .io_valid(honzales_io_valid),
    .io_strobe(honzales_io_strobe),
    .io_output(honzales_io_output),
    .io_unused(honzales_io_unused),
    .io_color_in(honzales_io_color_in),
    .io_color_out(honzales_io_color_out)
  );
  assign io_output = honzales_io_output; // @[Testbench.scala 33:15]
  assign io_unused = honzales_io_unused; // @[Testbench.scala 33:15]
  assign io_color_out = honzales_io_color_out; // @[Testbench.scala 33:15]
  assign honzales_clock = clock;
  assign honzales_reset = reset;
  assign honzales_io_input = io_input; // @[Testbench.scala 33:15]
  assign honzales_io_valid = io_valid; // @[Testbench.scala 33:15]
  assign honzales_io_strobe = io_strobe; // @[Testbench.scala 33:15]
  assign honzales_io_color_in = io_color_in; // @[Testbench.scala 33:15]
endmodule
