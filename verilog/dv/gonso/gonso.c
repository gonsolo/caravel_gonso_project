/*
 * SPDX-FileCopyrightText: 2022 Andreas Wendleder
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 * SPDX-FileContributor: Created by Andreas Wendleder <andreas.wendleder@gmail.com>
 */

#include <defs.h>
//#include <stub.c>

struct point {
        float x;
        float y;
        float z;
};

struct triangle {
        struct point a;
        struct point b;
        struct point c;
};

// Cornell box triangles
struct triangle triangles[34] =  {
{  { -1.0 ,  1.74846e-07 ,  -1.0 }, { -1.0 ,  1.74846e-07 ,  1.0 }, { 1.0 ,  -1.74846e-07 ,  1.0 }  },
{  { -1.0 ,  1.74846e-07 ,  -1.0 }, { 1.0 ,  -1.74846e-07 ,  1.0 }, { 1.0 ,  -1.74846e-07 ,  -1.0 }  },
{  { 1.0 ,  2.0 ,  1.0 }, { -1.0 ,  2.0 ,  1.0 }, { -1.0 ,  2.0 ,  -1.0 }  },
{  { 1.0 ,  2.0 ,  1.0 }, { -1.0 ,  2.0 ,  -1.0 }, { 1.0 ,  2.0 ,  -1.0 }  },
{  { -1.0 ,  0.0 ,  -1.0 }, { -1.0 ,  2.0 ,  -1.0 }, { 1.0 ,  2.0 ,  -1.0 }  },
{  { -1.0 ,  0.0 ,  -1.0 }, { 1.0 ,  2.0 ,  -1.0 }, { 1.0 ,  0.0 ,  -1.0 }  },
{  { 1.0 ,  0.0 ,  -1.0 }, { 1.0 ,  2.0 ,  -1.0 }, { 1.0 ,  2.0 ,  1.0 }  },
{  { 1.0 ,  0.0 ,  -1.0 }, { 1.0 ,  2.0 ,  1.0 }, { 1.0 ,  0.0 ,  1.0 }  },
{  { -1.0 ,  0.0 ,  1.0 }, { -1.0 ,  2.0 ,  1.0 }, { -1.0 ,  2.0 ,  -1.0 }  },
{  { -1.0 ,  0.0 ,  1.0 }, { -1.0 ,  2.0 ,  -1.0 }, { -1.0 ,  0.0 ,  -1.0 }  },
{  { -0.0460751 ,  0.6 ,  0.573007 }, { 0.124253 ,  0.0 ,  0.00310463 }, { -0.0460751 ,  -2.98023e-08 ,  0.573007 }  },
{  { -0.0460751 ,  0.6 ,  0.573007 }, { 0.124253 ,  0.6 ,  0.00310463 }, { 0.124253 ,  0.0 ,  0.00310463 }  },
{  { 0.533009 ,  0.0 ,  0.746079 }, { 0.703337 ,  0.6 ,  0.176177 }, { 0.533009 ,  0.6 ,  0.746079 }  },
{  { 0.533009 ,  0.0 ,  0.746079 }, { 0.703337 ,  2.98023e-08 ,  0.176177 }, { 0.703337 ,  0.6 ,  0.176177 }  },
{  { 0.533009 ,  0.6 ,  0.746079 }, { 0.124253 ,  0.6 ,  0.00310463 }, { -0.0460751 ,  0.6 ,  0.573007 }  },
{  { 0.533009 ,  0.6 ,  0.746079 }, { 0.703337 ,  0.6 ,  0.176177 }, { 0.124253 ,  0.6 ,  0.00310463 }  },
{  { 0.703337 ,  2.98023e-08 ,  0.176177 }, { -0.0460751 ,  -2.98023e-08 ,  0.573007 }, { 0.124253 ,  0.0 ,  0.00310463 }  },
{  { 0.703337 ,  2.98023e-08 ,  0.176177 }, { 0.533009 ,  0.0 ,  0.746079 }, { -0.0460751 ,  -2.98023e-08 ,  0.573007 }  },
{  { 0.533009 ,  0.0 ,  0.746079 }, { -0.0460751 ,  0.6 ,  0.573007 }, { -0.0460751 ,  -2.98023e-08 ,  0.573007 }  },
{  { 0.533009 ,  0.0 ,  0.746079 }, { 0.533009 ,  0.6 ,  0.746079 }, { -0.0460751 ,  0.6 ,  0.573007 }  },
{  { 0.703337 ,  0.6 ,  0.176177 }, { 0.124253 ,  0.0 ,  0.00310463 }, { 0.124253 ,  0.6 ,  0.00310463 }  },
{  { 0.703337 ,  0.6 ,  0.176177 }, { 0.703337 ,  2.98023e-08 ,  0.176177 }, { 0.124253 ,  0.0 ,  0.00310463 }  },
{  { -0.720444 ,  1.2 ,  -0.473882 }, { -0.146892 ,  0.0 ,  -0.673479 }, { -0.720444 ,  0.0 ,  -0.473882 }  },
{  { -0.720444 ,  1.2 ,  -0.473882 }, { -0.146892 ,  1.2 ,  -0.673479 }, { -0.146892 ,  0.0 ,  -0.673479 }  },
{  { -0.523986 ,  0.0 ,  0.0906493 }, { 0.0495656 ,  1.2 ,  -0.108948 }, { -0.523986 ,  1.2 ,  0.0906492 }  },
{  { -0.523986 ,  0.0 ,  0.0906493 }, { 0.0495656 ,  0.0 ,  -0.108948 }, { 0.0495656 ,  1.2 ,  -0.108948 }  },
{  { -0.523986 ,  1.2 ,  0.0906492 }, { -0.146892 ,  1.2 ,  -0.673479 }, { -0.720444 ,  1.2 ,  -0.473882 }  },
{  { -0.523986 ,  1.2 ,  0.0906492 }, { 0.0495656 ,  1.2 ,  -0.108948 }, { -0.146892 ,  1.2 ,  -0.673479 }  },
{  { 0.0495656 ,  0.0 ,  -0.108948 }, { -0.720444 ,  0.0 ,  -0.473882 }, { -0.146892 ,  0.0 ,  -0.673479 }  },
{  { 0.0495656 ,  0.0 ,  -0.108948 }, { -0.523986 ,  0.0 ,  0.0906493 }, { -0.720444 ,  0.0 ,  -0.473882 }  },
{  { -0.523986 ,  0.0 ,  0.0906493 }, { -0.720444 ,  1.2 ,  -0.473882 }, { -0.720444 ,  0.0 ,  -0.473882 }  },
{  { -0.523986 ,  0.0 ,  0.0906493 }, { -0.523986 ,  1.2 ,  0.0906492 }, { -0.720444 ,  1.2 ,  -0.473882 }  },
{  { 0.0495656 ,  1.2 ,  -0.108948 }, { -0.146892 ,  0.0 ,  -0.673479 }, { -0.146892 ,  1.2 ,  -0.673479 }  },
{  { 0.0495656 ,  1.2 ,  -0.108948 }, { 0.0495656 ,  0.0 ,  -0.108948 }, { -0.146892 ,  0.0 ,  -0.673479 }  },
};

//#define reg_mprj_led_config       (*(volatile uint32_t*)0x30030000)
#define reg_mprj_gonso            (*(volatile uint32_t*)0x30030004)
#define reg_mprj_gonso_plus       (*(volatile uint32_t*)0x30030008)
#define reg_mprj_gonso_color      (*(volatile uint32_t*)0x3003000C)
//#define reg_mprj_led_control      (*(volatile uint32_t*)0x3003000C)
//#define reg_mprj_led_data_0       (*(volatile uint32_t*)0x30031000)
//#define reg_mprj_led_data_1       (*(volatile uint32_t*)0x30031004)
//#define reg_mprj_led_data_2       (*(volatile uint32_t*)0x30031008)
//#define reg_mprj_led_data_3       (*(volatile uint32_t*)0x3003100C)

void main() {

  // Enable WishBone bus
  reg_wb_enable = 1;

  // I/Os is used by software
  reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_29 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_28 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_27 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_26 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_25 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_24 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_23 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_22 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_21 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_20 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_13 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_12 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_11 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_10 = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_9  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_8  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_7  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_6  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_5  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_4  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_3  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_2  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_1  = GPIO_MODE_MGMT_STD_OUTPUT;
  reg_mprj_io_0  = GPIO_MODE_MGMT_STD_OUTPUT;

  // Apply configuration
  reg_mprj_xfer = 1;
  while (reg_mprj_xfer == 1);

  // Flag start of the test
  reg_mprj_datal = 0xAB600000;

  reg_mprj_gonso_plus   = 0x00000000;
  reg_mprj_gonso        = 0x00000042;

  // Test reading back data from chip where it is incremented by one
  int data;
  int color;
  do {
        data = reg_mprj_gonso_plus;
  } while (data != 0x00000043);

  // Read color and write it to output
  color = reg_mprj_gonso_color;
  reg_mprj_datal = 0xAB610000 | color;

  // Write again for testbench
  reg_mprj_datal = 0xAB620000;
  reg_mprj_datal = 0xAB630000;
}
