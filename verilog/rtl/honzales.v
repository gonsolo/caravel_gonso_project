module Honzales(
  input  [31:0] io_input_value,
  output [31:0] io_output_value
);
  assign io_output_value = io_input_value; // @[Honzales.scala 12:19]
endmodule
module Testbench(
  input         clock,
  input         reset,
  input  [31:0] io_float_input_value,
  output [31:0] io_float_output_value
);
  wire [31:0] honzales_io_input_value; // @[Testbench.scala 22:24]
  wire [31:0] honzales_io_output_value; // @[Testbench.scala 22:24]
  Honzales honzales ( // @[Testbench.scala 22:24]
    .io_input_value(honzales_io_input_value),
    .io_output_value(honzales_io_output_value)
  );
  assign io_float_output_value = honzales_io_output_value; // @[Testbench.scala 23:15]
  assign honzales_io_input_value = io_float_input_value; // @[Testbench.scala 23:15]
endmodule
