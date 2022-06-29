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
  output [31:0] io_float_output_value,
  output [7:0]  io_pixel0_red,
  output [7:0]  io_pixel0_green,
  output [7:0]  io_pixel0_blue,
  output [7:0]  io_pixel0_alpha
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] honzales_io_input_value; // @[Testbench.scala 22:24]
  wire [31:0] honzales_io_output_value; // @[Testbench.scala 22:24]
  reg [7:0] colorMemory_red [0:1]; // @[Testbench.scala 25:32]
  wire  colorMemory_red_io_pixel0_MPORT_en; // @[Testbench.scala 25:32]
  wire  colorMemory_red_io_pixel0_MPORT_addr; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_red_io_pixel0_MPORT_data; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_red_MPORT_data; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_en; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_red_MPORT_1_data; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_1_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_1_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_red_MPORT_1_en; // @[Testbench.scala 25:32]
  reg  colorMemory_red_io_pixel0_MPORT_en_pipe_0;
  reg  colorMemory_red_io_pixel0_MPORT_addr_pipe_0;
  reg [7:0] colorMemory_green [0:1]; // @[Testbench.scala 25:32]
  wire  colorMemory_green_io_pixel0_MPORT_en; // @[Testbench.scala 25:32]
  wire  colorMemory_green_io_pixel0_MPORT_addr; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_green_io_pixel0_MPORT_data; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_green_MPORT_data; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_en; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_green_MPORT_1_data; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_1_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_1_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_green_MPORT_1_en; // @[Testbench.scala 25:32]
  reg  colorMemory_green_io_pixel0_MPORT_en_pipe_0;
  reg  colorMemory_green_io_pixel0_MPORT_addr_pipe_0;
  reg [7:0] colorMemory_blue [0:1]; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_io_pixel0_MPORT_en; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_io_pixel0_MPORT_addr; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_blue_io_pixel0_MPORT_data; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_blue_MPORT_data; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_en; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_blue_MPORT_1_data; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_1_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_1_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_blue_MPORT_1_en; // @[Testbench.scala 25:32]
  reg  colorMemory_blue_io_pixel0_MPORT_en_pipe_0;
  reg  colorMemory_blue_io_pixel0_MPORT_addr_pipe_0;
  reg [7:0] colorMemory_alpha [0:1]; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_io_pixel0_MPORT_en; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_io_pixel0_MPORT_addr; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_alpha_io_pixel0_MPORT_data; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_alpha_MPORT_data; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_en; // @[Testbench.scala 25:32]
  wire [7:0] colorMemory_alpha_MPORT_1_data; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_1_addr; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_1_mask; // @[Testbench.scala 25:32]
  wire  colorMemory_alpha_MPORT_1_en; // @[Testbench.scala 25:32]
  reg  colorMemory_alpha_io_pixel0_MPORT_en_pipe_0;
  reg  colorMemory_alpha_io_pixel0_MPORT_addr_pipe_0;
  Honzales honzales ( // @[Testbench.scala 22:24]
    .io_input_value(honzales_io_input_value),
    .io_output_value(honzales_io_output_value)
  );
  assign colorMemory_red_io_pixel0_MPORT_en = colorMemory_red_io_pixel0_MPORT_en_pipe_0;
  assign colorMemory_red_io_pixel0_MPORT_addr = colorMemory_red_io_pixel0_MPORT_addr_pipe_0;
  assign colorMemory_red_io_pixel0_MPORT_data = colorMemory_red[colorMemory_red_io_pixel0_MPORT_addr]; // @[Testbench.scala 25:32]
  assign colorMemory_red_MPORT_data = 8'hff;
  assign colorMemory_red_MPORT_addr = 1'h0;
  assign colorMemory_red_MPORT_mask = 1'h1;
  assign colorMemory_red_MPORT_en = 1'h1;
  assign colorMemory_red_MPORT_1_data = 8'h0;
  assign colorMemory_red_MPORT_1_addr = 1'h1;
  assign colorMemory_red_MPORT_1_mask = 1'h1;
  assign colorMemory_red_MPORT_1_en = 1'h1;
  assign colorMemory_green_io_pixel0_MPORT_en = colorMemory_green_io_pixel0_MPORT_en_pipe_0;
  assign colorMemory_green_io_pixel0_MPORT_addr = colorMemory_green_io_pixel0_MPORT_addr_pipe_0;
  assign colorMemory_green_io_pixel0_MPORT_data = colorMemory_green[colorMemory_green_io_pixel0_MPORT_addr]; // @[Testbench.scala 25:32]
  assign colorMemory_green_MPORT_data = 8'h0;
  assign colorMemory_green_MPORT_addr = 1'h0;
  assign colorMemory_green_MPORT_mask = 1'h1;
  assign colorMemory_green_MPORT_en = 1'h1;
  assign colorMemory_green_MPORT_1_data = 8'hff;
  assign colorMemory_green_MPORT_1_addr = 1'h1;
  assign colorMemory_green_MPORT_1_mask = 1'h1;
  assign colorMemory_green_MPORT_1_en = 1'h1;
  assign colorMemory_blue_io_pixel0_MPORT_en = colorMemory_blue_io_pixel0_MPORT_en_pipe_0;
  assign colorMemory_blue_io_pixel0_MPORT_addr = colorMemory_blue_io_pixel0_MPORT_addr_pipe_0;
  assign colorMemory_blue_io_pixel0_MPORT_data = colorMemory_blue[colorMemory_blue_io_pixel0_MPORT_addr]; // @[Testbench.scala 25:32]
  assign colorMemory_blue_MPORT_data = 8'h0;
  assign colorMemory_blue_MPORT_addr = 1'h0;
  assign colorMemory_blue_MPORT_mask = 1'h1;
  assign colorMemory_blue_MPORT_en = 1'h1;
  assign colorMemory_blue_MPORT_1_data = 8'h0;
  assign colorMemory_blue_MPORT_1_addr = 1'h1;
  assign colorMemory_blue_MPORT_1_mask = 1'h1;
  assign colorMemory_blue_MPORT_1_en = 1'h1;
  assign colorMemory_alpha_io_pixel0_MPORT_en = colorMemory_alpha_io_pixel0_MPORT_en_pipe_0;
  assign colorMemory_alpha_io_pixel0_MPORT_addr = colorMemory_alpha_io_pixel0_MPORT_addr_pipe_0;
  assign colorMemory_alpha_io_pixel0_MPORT_data = colorMemory_alpha[colorMemory_alpha_io_pixel0_MPORT_addr]; // @[Testbench.scala 25:32]
  assign colorMemory_alpha_MPORT_data = 8'hff;
  assign colorMemory_alpha_MPORT_addr = 1'h0;
  assign colorMemory_alpha_MPORT_mask = 1'h1;
  assign colorMemory_alpha_MPORT_en = 1'h1;
  assign colorMemory_alpha_MPORT_1_data = 8'hff;
  assign colorMemory_alpha_MPORT_1_addr = 1'h1;
  assign colorMemory_alpha_MPORT_1_mask = 1'h1;
  assign colorMemory_alpha_MPORT_1_en = 1'h1;
  assign io_float_output_value = honzales_io_output_value; // @[Testbench.scala 23:15]
  assign io_pixel0_red = colorMemory_red_io_pixel0_MPORT_data; // @[Testbench.scala 29:13]
  assign io_pixel0_green = colorMemory_green_io_pixel0_MPORT_data; // @[Testbench.scala 29:13]
  assign io_pixel0_blue = colorMemory_blue_io_pixel0_MPORT_data; // @[Testbench.scala 29:13]
  assign io_pixel0_alpha = colorMemory_alpha_io_pixel0_MPORT_data; // @[Testbench.scala 29:13]
  assign honzales_io_input_value = io_float_input_value; // @[Testbench.scala 23:15]
  always @(posedge clock) begin
    if (colorMemory_red_MPORT_en & colorMemory_red_MPORT_mask) begin
      colorMemory_red[colorMemory_red_MPORT_addr] <= colorMemory_red_MPORT_data; // @[Testbench.scala 25:32]
    end
    if (colorMemory_red_MPORT_1_en & colorMemory_red_MPORT_1_mask) begin
      colorMemory_red[colorMemory_red_MPORT_1_addr] <= colorMemory_red_MPORT_1_data; // @[Testbench.scala 25:32]
    end
    colorMemory_red_io_pixel0_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      colorMemory_red_io_pixel0_MPORT_addr_pipe_0 <= 1'h0;
    end
    if (colorMemory_green_MPORT_en & colorMemory_green_MPORT_mask) begin
      colorMemory_green[colorMemory_green_MPORT_addr] <= colorMemory_green_MPORT_data; // @[Testbench.scala 25:32]
    end
    if (colorMemory_green_MPORT_1_en & colorMemory_green_MPORT_1_mask) begin
      colorMemory_green[colorMemory_green_MPORT_1_addr] <= colorMemory_green_MPORT_1_data; // @[Testbench.scala 25:32]
    end
    colorMemory_green_io_pixel0_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      colorMemory_green_io_pixel0_MPORT_addr_pipe_0 <= 1'h0;
    end
    if (colorMemory_blue_MPORT_en & colorMemory_blue_MPORT_mask) begin
      colorMemory_blue[colorMemory_blue_MPORT_addr] <= colorMemory_blue_MPORT_data; // @[Testbench.scala 25:32]
    end
    if (colorMemory_blue_MPORT_1_en & colorMemory_blue_MPORT_1_mask) begin
      colorMemory_blue[colorMemory_blue_MPORT_1_addr] <= colorMemory_blue_MPORT_1_data; // @[Testbench.scala 25:32]
    end
    colorMemory_blue_io_pixel0_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      colorMemory_blue_io_pixel0_MPORT_addr_pipe_0 <= 1'h0;
    end
    if (colorMemory_alpha_MPORT_en & colorMemory_alpha_MPORT_mask) begin
      colorMemory_alpha[colorMemory_alpha_MPORT_addr] <= colorMemory_alpha_MPORT_data; // @[Testbench.scala 25:32]
    end
    if (colorMemory_alpha_MPORT_1_en & colorMemory_alpha_MPORT_1_mask) begin
      colorMemory_alpha[colorMemory_alpha_MPORT_1_addr] <= colorMemory_alpha_MPORT_1_data; // @[Testbench.scala 25:32]
    end
    colorMemory_alpha_io_pixel0_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      colorMemory_alpha_io_pixel0_MPORT_addr_pipe_0 <= 1'h0;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    colorMemory_red[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    colorMemory_green[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    colorMemory_blue[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    colorMemory_alpha[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  colorMemory_red_io_pixel0_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  colorMemory_red_io_pixel0_MPORT_addr_pipe_0 = _RAND_2[0:0];
  _RAND_4 = {1{`RANDOM}};
  colorMemory_green_io_pixel0_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  colorMemory_green_io_pixel0_MPORT_addr_pipe_0 = _RAND_5[0:0];
  _RAND_7 = {1{`RANDOM}};
  colorMemory_blue_io_pixel0_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  colorMemory_blue_io_pixel0_MPORT_addr_pipe_0 = _RAND_8[0:0];
  _RAND_10 = {1{`RANDOM}};
  colorMemory_alpha_io_pixel0_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  colorMemory_alpha_io_pixel0_MPORT_addr_pipe_0 = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
