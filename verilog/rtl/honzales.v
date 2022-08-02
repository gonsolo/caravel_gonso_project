module Honzales(
  input  [19:0] io_input,
  output [19:0] io_output
);
  assign io_output = io_input + 20'h1; // @[Honzales.scala 13:25]
endmodule
module Testbench(
  input         clock,
  input         reset,
  input  [19:0] io_input,
  output [19:0] io_output
);
  wire [19:0] honzales_io_input; // @[Testbench.scala 14:24]
  wire [19:0] honzales_io_output; // @[Testbench.scala 14:24]
  Honzales honzales ( // @[Testbench.scala 14:24]
    .io_input(honzales_io_input),
    .io_output(honzales_io_output)
  );
  assign io_output = honzales_io_output; // @[Testbench.scala 16:22]
  assign honzales_io_input = io_input; // @[Testbench.scala 15:21]
endmodule
