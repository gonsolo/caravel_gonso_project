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

#define reg_mprj_gonso          (*(volatile uint32_t*)0x30030004)
#define reg_mprj_gonso_plus     (*(volatile uint32_t*)0x30030008)
#define reg_mprj_gonso_color    (*(volatile uint32_t*)0x3003000C)

//#define reg_mprj_gonso_float    (*(volatile uint32_t*)0x30030010)

#define register_triangle_a_x        (*(volatile uint32_t*)0x30030014)
#define register_triangle_a_y        (*(volatile uint32_t*)0x30030018)
#define register_triangle_a_z        (*(volatile uint32_t*)0x3003001C)
#define register_triangle_b_x        (*(volatile uint32_t*)0x30030020)
#define register_triangle_b_y        (*(volatile uint32_t*)0x30030024)
#define register_triangle_b_z        (*(volatile uint32_t*)0x30030028)
#define register_triangle_c_x        (*(volatile uint32_t*)0x3003002C)
#define register_triangle_c_y        (*(volatile uint32_t*)0x30030030)
#define register_triangle_c_z        (*(volatile uint32_t*)0x30030034)

void gonso_memcpy(void *dest, void *src, uint32_t n)
{
        char *csrc = (char *)src;
        char *cdest = (char *)dest;

        for (int i=0; i<n; i++)
                cdest[i] = csrc[i];
}

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

struct matrix {
        float storage[4][4];
};

struct transform {
        struct matrix matrix;
};

struct camera {
        struct transform object_to_world;
};

#if 0
// Cornell box triangles (Cornell box plus two boxes)
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
        {  { 0.0495656 ,  1.2 ,  -0.108948 }, { 0.0495656 ,  0.0 ,  -0.108948 }, { -0.146892 ,  0.0 ,  -0.673479 }  }
};
#endif

uint32_t float_as_uint32(float f) {
        uint32_t u;
        gonso_memcpy(&u, &f, sizeof(u));
        return u;
}

//void send_triangle(float a, float b, float c, float d, float e, float f, float g, float h, float i) {
void send_triangle(struct triangle triangle) {
        register_triangle_a_x = float_as_uint32(triangle.a.x);
        register_triangle_a_y = float_as_uint32(triangle.a.y);
        register_triangle_a_z = float_as_uint32(triangle.a.z);
        register_triangle_b_x = float_as_uint32(triangle.b.x);
        register_triangle_b_y = float_as_uint32(triangle.b.y);
        register_triangle_b_z = float_as_uint32(triangle.b.z);
        register_triangle_c_x = float_as_uint32(triangle.c.x);
        register_triangle_c_y = float_as_uint32(triangle.c.y);
        register_triangle_c_z = float_as_uint32(triangle.c.z);
}

void send_triangles() {
        struct point a = {-1.f, +0.f, -1.f};
        struct point b = {-1.f, +0.f, +1.f};
        struct point c = {+1.f, +0.f, +1.f};
        struct triangle triangle = {a, b, c};
        send_triangle(triangle);
        //send_triangle(-1.0, 1.74846e-07, -1.0,  -1.0 ,  1.74846e-07 ,  1.0 ,  1.0 ,  -1.74846e-07 ,  1.0 );
        //send_triangle(-1.0, 1.74846e-07, -1.0,  1.0 ,  -1.74846e-07 ,  1.0 ,  1.0 ,  -1.74846e-07 ,  -1.0 );
        //send_triangle( 1.0, 2.0 ,  1.0 ,  -1.0 ,  2.0 ,  1.0 ,  -1.0 ,  2.0 ,  -1.0 );
        //send_triangle( 1.0, 2.0 ,  1.0 ,  -1.0 ,  2.0 ,  -1.0 ,  1.0 ,  2.0 ,  -1.0 );
}
#if 0
// Cornell box triangles (Cornell box with tall box, no small box)
struct triangle triangles[22] = {
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
        {  { 0.0495656 ,  1.2 ,  -0.108948 }, { 0.0495656 ,  0.0 ,  -0.108948 }, { -0.146892 ,  0.0 ,  -0.673479 }  }
};
#endif

#if 0
// Area light
struct triangle area_light_triangles[2] = {
        {  { -0.24 ,  1.98 ,  -0.22 }, { 0.23 ,  1.98 ,  -0.22 }, { 0.23 ,  1.98 ,  0.16 }  },
        {  { -0.24 ,  1.98 ,  -0.22 }, { 0.23 ,  1.98 ,  0.16 }, { -0.24 ,  1.98 ,  0.16 }  }
};
#endif

#if 0
// Camera
struct camera camera = {
        .object_to_world = {
                .matrix = {
                        .storage = {
                                { 1.0, 0.0, 0.0, 0.0 },
                                { 0.0, 1.0, 1.4901161e-08, 0.99999994 },
                                { 0.0, 0.0, -0.99999994, 6.8 },
                                { 0.0, 0.0, 1.4901161e-08, 0.99999994 }
                        }
                }
        }
};
#endif

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

  //send_triangles();

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
