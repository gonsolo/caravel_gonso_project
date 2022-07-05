module Honzales(
  input         clock,
  input         reset,
  input         io_input,
  output [31:0] io_output
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] counterValue; // @[Counter.scala 62:40]
  wire [7:0] _wrap_value_T_1 = counterValue + 8'h1; // @[Counter.scala 78:24]
  wire [7:0] _io_output_T = io_input ? counterValue : 8'h0; // @[Honzales.scala 15:19]
  assign io_output = {{24'd0}, _io_output_T}; // @[Honzales.scala 15:13]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      counterValue <= 8'h0; // @[Counter.scala 62:40]
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
  input         io_input,
  output [31:0] io_output
);
  wire  honzales_clock; // @[Testbench.scala 14:24]
  wire  honzales_reset; // @[Testbench.scala 14:24]
  wire  honzales_io_input; // @[Testbench.scala 14:24]
  wire [31:0] honzales_io_output; // @[Testbench.scala 14:24]
  Honzales honzales ( // @[Testbench.scala 14:24]
    .clock(honzales_clock),
    .reset(honzales_reset),
    .io_input(honzales_io_input),
    .io_output(honzales_io_output)
  );
  assign io_output = honzales_io_output; // @[Testbench.scala 16:22]
  assign honzales_clock = clock;
  assign honzales_reset = reset;
  assign honzales_io_input = io_input; // @[Testbench.scala 15:21]
endmodule
