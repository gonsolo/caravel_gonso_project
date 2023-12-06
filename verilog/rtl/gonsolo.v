// SPDX-FileCopyrightText: 2020 Efabless Corporation
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

// gonsolo: Include Diffuse.v from pepe commit fc902

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

module MulFullRawFN(	// <stdin>:3:10
  input         io_a_isNaN,
                io_a_isInf,
                io_a_isZero,
                io_a_sign,
  input  [9:0]  io_a_sExp,
  input  [24:0] io_a_sig,
  output        io_invalidExc,
                io_rawOut_isNaN,
                io_rawOut_isInf,
                io_rawOut_isZero,
                io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [47:0] io_rawOut_sig);

  assign io_invalidExc = io_a_isNaN & ~(io_a_sig[22]);	// <stdin>:3:10, hardfloat/src/main/scala/common.scala:82:{46,49,56}
  assign io_rawOut_isNaN = io_a_isNaN;	// <stdin>:3:10
  assign io_rawOut_isInf = io_a_isInf;	// <stdin>:3:10
  assign io_rawOut_isZero = io_a_isZero;	// <stdin>:3:10
  assign io_rawOut_sign = io_a_sign;	// <stdin>:3:10
  assign io_rawOut_sExp = io_a_sExp - 10'h2;	// <stdin>:3:10, hardfloat/src/main/scala/MulRecFN.scala:62:48
  assign io_rawOut_sig = {23'h0, io_a_sig} * 48'hA2F983;	// <stdin>:3:10, hardfloat/src/main/scala/MulRecFN.scala:63:35
endmodule

module MulRawFN(	// <stdin>:37:10
  input         io_a_isNaN,
                io_a_isInf,
                io_a_isZero,
                io_a_sign,
  input  [9:0]  io_a_sExp,
  input  [24:0] io_a_sig,
  output        io_invalidExc,
                io_rawOut_isNaN,
                io_rawOut_isInf,
                io_rawOut_isZero,
                io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [26:0] io_rawOut_sig);

  wire [47:0] _mulFullRaw_io_rawOut_sig;	// hardfloat/src/main/scala/MulRecFN.scala:84:28
  MulFullRawFN mulFullRaw (	// hardfloat/src/main/scala/MulRecFN.scala:84:28
    .io_a_isNaN       (io_a_isNaN),
    .io_a_isInf       (io_a_isInf),
    .io_a_isZero      (io_a_isZero),
    .io_a_sign        (io_a_sign),
    .io_a_sExp        (io_a_sExp),
    .io_a_sig         (io_a_sig),
    .io_invalidExc    (io_invalidExc),
    .io_rawOut_isNaN  (io_rawOut_isNaN),
    .io_rawOut_isInf  (io_rawOut_isInf),
    .io_rawOut_isZero (io_rawOut_isZero),
    .io_rawOut_sign   (io_rawOut_sign),
    .io_rawOut_sExp   (io_rawOut_sExp),
    .io_rawOut_sig    (_mulFullRaw_io_rawOut_sig)
  );
  assign io_rawOut_sig =
    {_mulFullRaw_io_rawOut_sig[47:22], |(_mulFullRaw_io_rawOut_sig[21:0])};	// <stdin>:37:10, hardfloat/src/main/scala/MulRecFN.scala:84:28, :93:{10,15,37,55}
endmodule

module RoundAnyRawFNToRecFN(	// <stdin>:61:10
  input         io_invalidExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [26:0] io_in_sig,
  output [32:0] io_out);

  wire [8:0]  _roundMask_T_1 = ~(io_in_sExp[8:0]);	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:155:37, hardfloat/src/main/scala/primitives.scala:52:21
  wire [64:0] _GEN = {59'h0, _roundMask_T_1[5:0]};	// hardfloat/src/main/scala/primitives.scala:52:21, :59:26, :76:56
  wire [64:0] roundMask_shift = $signed(65'sh10000000000000000 >>> _GEN);	// hardfloat/src/main/scala/primitives.scala:76:56
  wire [64:0] roundMask_shift_1 = $signed(65'sh10000000000000000 >>> _GEN);	// hardfloat/src/main/scala/primitives.scala:76:56
  wire [24:0] _roundMask_T_74 =
    (_roundMask_T_1[8]
       ? (_roundMask_T_1[7]
            ? {~(_roundMask_T_1[6]
                   ? 22'h0
                   : ~{roundMask_shift[42],
                       roundMask_shift[43],
                       roundMask_shift[44],
                       roundMask_shift[45],
                       roundMask_shift[46],
                       roundMask_shift[47],
                       roundMask_shift[48],
                       roundMask_shift[49],
                       roundMask_shift[50],
                       roundMask_shift[51],
                       roundMask_shift[52],
                       roundMask_shift[53],
                       roundMask_shift[54],
                       roundMask_shift[55],
                       roundMask_shift[56],
                       roundMask_shift[57],
                       roundMask_shift[58],
                       roundMask_shift[59],
                       roundMask_shift[60],
                       roundMask_shift[61],
                       roundMask_shift[62],
                       roundMask_shift[63]}),
               3'h7}
            : {22'h0,
               _roundMask_T_1[6]
                 ? {roundMask_shift_1[0], roundMask_shift_1[1], roundMask_shift_1[2]}
                 : 3'h0})
       : 25'h0) | {24'h0, io_in_sig[26]};	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:119:57, :158:23, hardfloat/src/main/scala/primitives.scala:52:21, :58:25, :59:26, :62:24, :67:24, :68:58, :73:{17,21,32}, :76:56, :77:20, :78:22
  wire [25:0] _GEN_0 = {_roundMask_T_74, 1'h1};	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:158:{23,42}, :242:60
  wire [25:0] _GEN_1 = io_in_sig[26:1] & {1'h1, ~_roundMask_T_74} & _GEN_0;	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:158:{23,42}, :161:53, :162:28, :163:40, :242:60
  wire [25:0] roundedSig =
    (|_GEN_1)
      ? {1'h0, io_in_sig[26:2] | _roundMask_T_74} + 26'h1
        & ~((|_GEN_1) & (io_in_sig[25:0] & _GEN_0) == 26'h0
              ? {_roundMask_T_74, 1'h1}
              : 26'h0)
      : {1'h0, io_in_sig[26:2] & ~_roundMask_T_74};	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:57:16, :158:{23,42}, :162:28, :163:{40,56}, :164:{42,62}, :172:16, :173:{32,49,57}, :174:{21,25,64}, :176:35, :179:{30,47}, :180:24, :242:60
  wire [10:0] sRoundedExp = {io_in_sExp[9], io_in_sExp} + {9'h0, roundedSig[25:24]};	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:172:16, :184:{40,54}, :272:16
  wire        common_totalUnderflow = $signed(sRoundedExp) < 11'sh6B;	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:184:40, :199:31
  wire        isNaNOut = io_invalidExc | io_in_isNaN;	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:234:34
  wire        notNaN_isInfOut =
    io_in_isInf | ~isNaNOut & ~io_in_isInf & ~io_in_isZero
    & $signed(sRoundedExp[10:7]) > 4'sh2;	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:184:40, :195:{30,50}, :234:34, :236:{22,36,64}, :237:32, :247:32
  assign io_out =
    {~isNaNOut & io_in_sign,
     sRoundedExp[8:0] & ~(io_in_isZero | common_totalUnderflow ? 9'h1C0 : 9'h0)
       & {2'h3, ~notNaN_isInfOut, 6'h3F} | (notNaN_isInfOut ? 9'h180 : 9'h0)
       | (isNaNOut ? 9'h1C0 : 9'h0),
     isNaNOut | io_in_isZero | common_totalUnderflow
       ? {isNaNOut, 22'h0}
       : io_in_sig[26] ? roundedSig[23:1] : roundedSig[22:0]};	// <stdin>:61:10, hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:119:57, :158:42, :172:16, :184:40, :186:37, :188:16, :189:27, :190:27, :199:31, :234:34, :247:32, :249:22, :252:{14,18,32}, :263:17, :264:{14,18}, :272:16, :276:{16,73}, :277:16, :279:{12,38}, :280:16, :285:33, hardfloat/src/main/scala/primitives.scala:73:21
endmodule

module RoundRawFNToRecFN(	// <stdin>:309:10
  input         io_invalidExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [26:0] io_in_sig,
  output [32:0] io_out);

  RoundAnyRawFNToRecFN roundAnyRawFNToRecFN (	// hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:308:15
    .io_invalidExc (io_invalidExc),
    .io_in_isNaN   (io_in_isNaN),
    .io_in_isInf   (io_in_isInf),
    .io_in_isZero  (io_in_isZero),
    .io_in_sign    (io_in_sign),
    .io_in_sExp    (io_in_sExp),
    .io_in_sig     (io_in_sig),
    .io_out        (io_out)
  );
endmodule

module MulRecFN(	// <stdin>:326:10
  input  [32:0] io_a,
  output [32:0] io_out);

  wire        _mulRawFN_io_invalidExc;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire        _mulRawFN_io_rawOut_isNaN;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire        _mulRawFN_io_rawOut_isInf;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire        _mulRawFN_io_rawOut_isZero;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire        _mulRawFN_io_rawOut_sign;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire [9:0]  _mulRawFN_io_rawOut_sExp;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  wire [26:0] _mulRawFN_io_rawOut_sig;	// hardfloat/src/main/scala/MulRecFN.scala:113:26
  MulRawFN mulRawFN (	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_a_isNaN       ((&(io_a[31:30])) & io_a[29]),	// hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}
    .io_a_isInf       ((&(io_a[31:30])) & ~(io_a[29])),	// hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:{33,36}
    .io_a_isZero      (~(|(io_a[31:29]))),	// hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}
    .io_a_sign        (io_a[32]),	// hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25
    .io_a_sExp        ({1'h0, io_a[31:23]}),	// hardfloat/src/main/scala/MulRecFN.scala:102:16, hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :60:27
    .io_a_sig         ({1'h0, |(io_a[31:29]), io_a[22:0]}),	// hardfloat/src/main/scala/MulRecFN.scala:102:16, hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:{44,49}
    .io_invalidExc    (_mulRawFN_io_invalidExc),
    .io_rawOut_isNaN  (_mulRawFN_io_rawOut_isNaN),
    .io_rawOut_isInf  (_mulRawFN_io_rawOut_isInf),
    .io_rawOut_isZero (_mulRawFN_io_rawOut_isZero),
    .io_rawOut_sign   (_mulRawFN_io_rawOut_sign),
    .io_rawOut_sExp   (_mulRawFN_io_rawOut_sExp),
    .io_rawOut_sig    (_mulRawFN_io_rawOut_sig)
  );
  RoundRawFNToRecFN roundRawFNToRecFN (	// hardfloat/src/main/scala/MulRecFN.scala:121:15
    .io_invalidExc (_mulRawFN_io_invalidExc),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_isNaN   (_mulRawFN_io_rawOut_isNaN),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_isInf   (_mulRawFN_io_rawOut_isInf),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_isZero  (_mulRawFN_io_rawOut_isZero),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_sign    (_mulRawFN_io_rawOut_sign),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_sExp    (_mulRawFN_io_rawOut_sExp),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_in_sig     (_mulRawFN_io_rawOut_sig),	// hardfloat/src/main/scala/MulRecFN.scala:113:26
    .io_out        (io_out)
  );
endmodule

module Multiply(	// <stdin>:402:10
  input  [31:0] io_a,
  output [31:0] io_out);

  wire [32:0] _mul_io_out;	// src/main/scala/bsdf/Multiply.scala:23:19
  wire        mul_io_a_rawIn_isZeroExpIn = io_a[30:23] == 8'h0;	// hardfloat/src/main/scala/fNFromRecFN.scala:60:21, hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30
  wire [4:0]  mul_io_a_rawIn_normDist =
    io_a[22]
      ? 5'h0
      : io_a[21]
          ? 5'h1
          : io_a[20]
              ? 5'h2
              : io_a[19]
                  ? 5'h3
                  : io_a[18]
                      ? 5'h4
                      : io_a[17]
                          ? 5'h5
                          : io_a[16]
                              ? 5'h6
                              : io_a[15]
                                  ? 5'h7
                                  : io_a[14]
                                      ? 5'h8
                                      : io_a[13]
                                          ? 5'h9
                                          : io_a[12]
                                              ? 5'hA
                                              : io_a[11]
                                                  ? 5'hB
                                                  : io_a[10]
                                                      ? 5'hC
                                                      : io_a[9]
                                                          ? 5'hD
                                                          : io_a[8]
                                                              ? 5'hE
                                                              : io_a[7]
                                                                  ? 5'hF
                                                                  : io_a[6]
                                                                      ? 5'h10
                                                                      : io_a[5]
                                                                          ? 5'h11
                                                                          : io_a[4]
                                                                              ? 5'h12
                                                                              : io_a[3]
                                                                                  ? 5'h13
                                                                                  : io_a[2]
                                                                                      ? 5'h14
                                                                                      : io_a[1]
                                                                                          ? 5'h15
                                                                                          : 5'h16;	// hardfloat/src/main/scala/primitives.scala:91:52, hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, src/main/scala/chisel3/util/Mux.scala:50:70
  wire [53:0] _mul_io_a_rawIn_subnormFract_T =
    {31'h0, io_a[22:0]} << mul_io_a_rawIn_normDist;	// hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :52:33, src/main/scala/chisel3/util/Mux.scala:50:70
  wire [8:0]  mul_io_a_rawIn_adjustedExp =
    (mul_io_a_rawIn_isZeroExpIn ? {4'hF, ~mul_io_a_rawIn_normDist} : {1'h0, io_a[30:23]})
    + {7'h20, mul_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1};	// hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, :54:10, :55:18, :57:9, :58:14, src/main/scala/bsdf/Multiply.scala:21:14, src/main/scala/chisel3/util/Mux.scala:50:70
  wire        io_out_rawIn_isInf = (&(_mul_io_out[31:30])) & ~(_mul_io_out[29]);	// hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:{33,36}, src/main/scala/bsdf/Multiply.scala:23:19
  wire        io_out_isSubnormal = $signed({1'h0, _mul_io_out[31:23]}) < 10'sh82;	// hardfloat/src/main/scala/fNFromRecFN.scala:51:38, hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :60:27, src/main/scala/bsdf/Multiply.scala:21:14, :23:19
  wire [23:0] _io_out_denormFract_T_1 =
    {1'h0, |(_mul_io_out[31:29]), _mul_io_out[22:1]} >> 5'h1 - _mul_io_out[27:23];	// hardfloat/src/main/scala/fNFromRecFN.scala:52:{35,47}, :53:{38,42}, hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, src/main/scala/bsdf/Multiply.scala:21:14, :23:19, src/main/scala/chisel3/util/Mux.scala:50:70
  MulRecFN mul (	// src/main/scala/bsdf/Multiply.scala:23:19
    .io_a
      ({io_a[31],
        (mul_io_a_rawIn_isZeroExpIn & ~(|(io_a[22:0]))
           ? 3'h0
           : mul_io_a_rawIn_adjustedExp[8:6])
          | {2'h0, (&(mul_io_a_rawIn_adjustedExp[8:7])) & (|(io_a[22:0]))},
        mul_io_a_rawIn_adjustedExp[5:0],
        mul_io_a_rawIn_isZeroExpIn
          ? {_mul_io_a_rawIn_subnormFract_T[21:0], 1'h0}
          : io_a[22:0]}),	// hardfloat/src/main/scala/rawFloatFromFN.scala:44:18, :46:21, :48:30, :49:34, :52:{33,46,64}, :57:9, :60:30, :61:{32,57}, :64:28, :70:33, hardfloat/src/main/scala/recFNFromFN.scala:48:{15,50,76}, :50:{23,41}, src/main/scala/bsdf/Multiply.scala:21:14
    .io_out (_mul_io_out)
  );
  assign io_out =
    {_mul_io_out[32],
     (io_out_isSubnormal ? 8'h0 : _mul_io_out[30:23] + 8'h7F)
       | {8{(&(_mul_io_out[31:30])) & _mul_io_out[29] | io_out_rawIn_isInf}},
     io_out_isSubnormal
       ? _io_out_denormFract_T_1[22:0]
       : io_out_rawIn_isInf ? 23'h0 : _mul_io_out[22:0]};	// <stdin>:402:10, hardfloat/src/main/scala/fNFromRecFN.scala:51:38, :53:{42,60}, :56:16, :58:{27,45}, :60:{15,21,44}, :62:16, :64:20, :66:12, hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}, :57:33, :59:25, :61:49, src/main/scala/bsdf/Multiply.scala:23:19
endmodule

module Diffuse(	// <stdin>:633:10
  input         clock,
                reset,
                input_valid,
  input  [31:0] input_bits_reflectance,
  input         output_ready,
  output        input_ready,
                output_valid,
  output [31:0] output_bits_out);

  reg         busy;	// src/main/scala/bsdf/Diffuse.scala:22:21
  reg         resultValid;	// src/main/scala/bsdf/Diffuse.scala:23:28
  reg  [31:0] reflectance;	// src/main/scala/bsdf/Diffuse.scala:24:24
  wire        _T = output_ready & resultValid;	// src/main/scala/bsdf/Diffuse.scala:23:28, :38:23
  always @(posedge clock) begin
    if (reset) begin
      busy <= 1'h0;	// src/main/scala/bsdf/Diffuse.scala:22:21
      resultValid <= 1'h0;	// src/main/scala/bsdf/Diffuse.scala:22:21, :23:28
    end
    else if (busy) begin	// src/main/scala/bsdf/Diffuse.scala:22:21
      busy <= ~_T & busy;	// src/main/scala/bsdf/Diffuse.scala:22:21, :38:{23,39}, :39:12
      resultValid <= ~_T;	// src/main/scala/bsdf/Diffuse.scala:22:21, :23:28, :38:{23,39}, :39:12
    end
    else	// src/main/scala/bsdf/Diffuse.scala:22:21
      busy <= input_valid | busy;	// src/main/scala/bsdf/Diffuse.scala:22:21, :43:23, :47:12
    if (busy | ~input_valid) begin	// src/main/scala/bsdf/Diffuse.scala:22:21, :24:24, :35:14, :43:23
    end
    else	// src/main/scala/bsdf/Diffuse.scala:24:24, :35:14, :43:23
      reflectance <= input_bits_reflectance;	// src/main/scala/bsdf/Diffuse.scala:24:24
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:633:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:633:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:633:10
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;	// <stdin>:633:10
    logic [31:0] _RANDOM_1;	// <stdin>:633:10
    logic [31:0] _RANDOM_2;	// <stdin>:633:10
    initial begin	// <stdin>:633:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:633:10
        `INIT_RANDOM_PROLOG_	// <stdin>:633:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:633:10
        _RANDOM_0 = `RANDOM;	// <stdin>:633:10
        _RANDOM_1 = `RANDOM;	// <stdin>:633:10
        _RANDOM_2 = `RANDOM;	// <stdin>:633:10
        busy = _RANDOM_0[31];	// src/main/scala/bsdf/Diffuse.scala:22:21
        resultValid = _RANDOM_1[0];	// src/main/scala/bsdf/Diffuse.scala:23:28
        reflectance = {_RANDOM_1[31:1], _RANDOM_2[0]};	// src/main/scala/bsdf/Diffuse.scala:23:28, :24:24
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:633:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:633:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  Multiply multiply (	// src/main/scala/bsdf/Diffuse.scala:19:24
    .io_a   (reflectance),	// src/main/scala/bsdf/Diffuse.scala:24:24
    .io_out (output_bits_out)
  );
  assign input_ready = ~busy & input_valid | ~busy;	// <stdin>:633:10, src/main/scala/bsdf/Diffuse.scala:22:21, :26:{15,18}, :35:14, :43:23
  assign output_valid = resultValid;	// <stdin>:633:10, src/main/scala/bsdf/Diffuse.scala:23:28
endmodule

// gonsolo: End of Diffuse.v

`default_nettype none

module gonsolo #(
    parameter BITS = 16
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [BITS-1:0] io_in,
    output [BITS-1:0] io_out,
    output [BITS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [BITS-1:0] rdata; 
    wire [BITS-1:0] wdata;
    wire [BITS-1:0] count;

    wire valid;
    wire [3:0] wstrb;
    wire [BITS-1:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = {{(32-BITS){1'b0}}, rdata};
    assign wdata = wbs_dat_i[BITS-1:0];

    // IO
    assign io_out = count;
    assign io_oeb = {(BITS){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {{(128-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:64-BITS] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

    // dummies
    assign rdata = 1;
    assign wbs_ack_o = 1;

    // diffuse dummies
    wire output_ready;
    assign output_ready = 1;
    wire [31:0] input_bits_reflectance;
    //assign input_bits_reflectance = 1065353216; // 32 bit float   1.f as uint32
    assign input_bits_reflectance = 3255042048; // 32 bit float -33.f as uint32
    wire input_valid;
    assign input_valid = 1;
    wire input_ready;
    wire output_valid;
    wire [31:0] output_bits_out;
    wire _unused_ok = &{
        1'b0,
        input_ready,
        output_valid,
        output_bits_out,
        1'b0};

    Diffuse diffuse(
        .clock(clk),
        .reset(rst),
        .input_valid(input_valid),
        .input_ready(input_ready),
        .input_bits_reflectance(input_bits_reflectance),
        .output_valid(output_valid),
        .output_ready(output_ready),
        .output_bits_out(output_bits_out)
    );

    assign count = output_bits_out[15:0];

endmodule

module counter #(
    parameter BITS = 16
)(
    input clk,
    input reset,
    input valid,
    //input [3:0] wstrb,
    //input [BITS-1:0] wdata,
    //input [BITS-1:0] la_write,
    //input [BITS-1:0] la_input,
    output reg ready,
    //output reg [BITS-1:0] rdata,
    output reg [BITS-1:0] count
);

    always @(posedge clk) begin
        if (reset) begin
            count <= 16'b0;
            ready <= 1'b0;
        end else begin
            ready <= 1'b0;
            //if (~|la_write) begin
            //    count <= count + 1'b1;
            //end
	    count <= 16'h12;
            if (valid && !ready) begin
                ready <= 1'b1;
                //rdata <= count;
                //if (wstrb[0]) count[7:0]   <= wdata[7:0];
                //if (wstrb[1]) count[15:8]  <= wdata[15:8];
	    //end else if (|la_write) begin
            //    count <= la_write & la_input;
            end
        end
    end

endmodule

`default_nettype wire
