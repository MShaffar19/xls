// Copyright 2020 Google LLC
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

// options: {"input_is_dslx": true, "convert_to_ir": true, "optimize_ir": true, "codegen": true, "codegen_args": ["--generator=pipeline", "--pipeline_stages=3"], "simulate": false, "simulator": null}
// args: bits[1]:0x1; bits[19]:0x767d0; bits[29]:0xa8679fb
// args: bits[1]:0x0; bits[19]:0x32f56; bits[29]:0x6c44113
// args: bits[1]:0x1; bits[19]:0x800; bits[29]:0xa8615a0
// args: bits[1]:0x1; bits[19]:0x6f2e4; bits[29]:0x1ba375d0
// args: bits[1]:0x0; bits[19]:0x3313b; bits[29]:0xcb7f2ba
// args: bits[1]:0x0; bits[19]:0x10000; bits[29]:0xdc05ad5
// args: bits[1]:0x0; bits[19]:0x56823; bits[29]:0x29fdcce
// args: bits[1]:0x1; bits[19]:0x8000; bits[29]:0x1873cfb9
// args: bits[1]:0x0; bits[19]:0x61367; bits[29]:0x6555742
// args: bits[1]:0x0; bits[19]:0x909b; bits[29]:0x1a9da445
// args: bits[1]:0x0; bits[19]:0x73bc6; bits[29]:0x11bcdfaf
// args: bits[1]:0x1; bits[19]:0x4134; bits[29]:0x2de6217
// args: bits[1]:0x1; bits[19]:0x133c3; bits[29]:0x3b70114
// args: bits[1]:0x0; bits[19]:0x329f5; bits[29]:0x92684b
// args: bits[1]:0x1; bits[19]:0x672fa; bits[29]:0x80000
// args: bits[1]:0x0; bits[19]:0x3e8d2; bits[29]:0xb08028a
// args: bits[1]:0x1; bits[19]:0x1; bits[29]:0x20ef9b8
// args: bits[1]:0x0; bits[19]:0x64ca5; bits[29]:0x181074ed
// args: bits[1]:0x1; bits[19]:0x6c81a; bits[29]:0x11088a16
// args: bits[1]:0x1; bits[19]:0xff3b; bits[29]:0xff9fd5e
// args: bits[1]:0x0; bits[19]:0x3ad8a; bits[29]:0x1f8218d
// args: bits[1]:0x0; bits[19]:0x12e36; bits[29]:0x10b51ec8
// args: bits[1]:0x0; bits[19]:0x9543; bits[29]:0x8000000
// args: bits[1]:0x1; bits[19]:0x74556; bits[29]:0x6f8a697
// args: bits[1]:0x1; bits[19]:0x3a85d; bits[29]:0xb55370f
// args: bits[1]:0x1; bits[19]:0x63875; bits[29]:0x38c9780
// args: bits[1]:0x0; bits[19]:0x12463; bits[29]:0x39f301d
// args: bits[1]:0x1; bits[19]:0x30176; bits[29]:0x45055f6
// args: bits[1]:0x0; bits[19]:0x3ecca; bits[29]:0x11a9a3d7
// args: bits[1]:0x1; bits[19]:0x10fef; bits[29]:0x7c3203f
// args: bits[1]:0x0; bits[19]:0x71658; bits[29]:0x7a6c43
// args: bits[1]:0x0; bits[19]:0xaf6b; bits[29]:0xd5da0d6
// args: bits[1]:0x1; bits[19]:0x2cbe7; bits[29]:0x9a2e61
// args: bits[1]:0x1; bits[19]:0x3ffff; bits[29]:0x184a4511
// args: bits[1]:0x0; bits[19]:0xdba0; bits[29]:0x131d3414
// args: bits[1]:0x1; bits[19]:0x605e9; bits[29]:0x130e3bfb
// args: bits[1]:0x1; bits[19]:0x11d38; bits[29]:0x1f370ff8
// args: bits[1]:0x1; bits[19]:0x8000; bits[29]:0xce5cc32
// args: bits[1]:0x0; bits[19]:0x2bfa4; bits[29]:0x7989d9b
// args: bits[1]:0x1; bits[19]:0x82ee; bits[29]:0x1f8e32c3
// args: bits[1]:0x1; bits[19]:0x5e09d; bits[29]:0x1210f285
// args: bits[1]:0x0; bits[19]:0x2f6e5; bits[29]:0x1b23ef59
// args: bits[1]:0x0; bits[19]:0x7182c; bits[29]:0xb5913ce
// args: bits[1]:0x1; bits[19]:0x62437; bits[29]:0x12f009d9
// args: bits[1]:0x0; bits[19]:0x4b2df; bits[29]:0x1fc443a5
// args: bits[1]:0x1; bits[19]:0x6a15b; bits[29]:0x20
// args: bits[1]:0x0; bits[19]:0x4649; bits[29]:0x40
// args: bits[1]:0x0; bits[19]:0x1bbab; bits[29]:0xdc988e8
// args: bits[1]:0x1; bits[19]:0x2; bits[29]:0xf15341
// args: bits[1]:0x0; bits[19]:0x7aaf3; bits[29]:0x4000
// args: bits[1]:0x0; bits[19]:0x78fc8; bits[29]:0xcf2585f
// args: bits[1]:0x0; bits[19]:0x580a4; bits[29]:0xbf5872e
// args: bits[1]:0x0; bits[19]:0x3e24e; bits[29]:0xd6a1523
// args: bits[1]:0x0; bits[19]:0x3082c; bits[29]:0xc3634ad
// args: bits[1]:0x0; bits[19]:0x18090; bits[29]:0xd4dd927
// args: bits[1]:0x1; bits[19]:0x800; bits[29]:0x40000
// args: bits[1]:0x1; bits[19]:0x10d44; bits[29]:0xddabf81
// args: bits[1]:0x1; bits[19]:0x54da5; bits[29]:0x83e8b1
// args: bits[1]:0x1; bits[19]:0x5ea5a; bits[29]:0x62c04e2
// args: bits[1]:0x0; bits[19]:0x3c3d9; bits[29]:0x13b92124
// args: bits[1]:0x1; bits[19]:0x599b7; bits[29]:0x184aee3d
// args: bits[1]:0x1; bits[19]:0x7e57; bits[29]:0x3029b40
// args: bits[1]:0x1; bits[19]:0x5aac3; bits[29]:0xf34de40
// args: bits[1]:0x0; bits[19]:0x6ff85; bits[29]:0x1798b343
// args: bits[1]:0x0; bits[19]:0x40d95; bits[29]:0x112f57aa
// args: bits[1]:0x0; bits[19]:0x683bc; bits[29]:0xc38460a
// args: bits[1]:0x0; bits[19]:0x2c2d7; bits[29]:0x1d73c298
// args: bits[1]:0x0; bits[19]:0x52d8; bits[29]:0x8c38e65
// args: bits[1]:0x0; bits[19]:0x7a0b1; bits[29]:0x6a7aecd
// args: bits[1]:0x1; bits[19]:0xac33; bits[29]:0xea28d3a
// args: bits[1]:0x1; bits[19]:0x55c1b; bits[29]:0xc525f7d
// args: bits[1]:0x1; bits[19]:0x292ff; bits[29]:0x159249e0
// args: bits[1]:0x1; bits[19]:0x7d18c; bits[29]:0x20000
// args: bits[1]:0x1; bits[19]:0xbfe9; bits[29]:0x2929053
// args: bits[1]:0x1; bits[19]:0x66942; bits[29]:0x1818b6a3
// args: bits[1]:0x1; bits[19]:0x100; bits[29]:0x1601e476
// args: bits[1]:0x0; bits[19]:0x561f1; bits[29]:0x15555555
// args: bits[1]:0x1; bits[19]:0x17666; bits[29]:0x126e926d
// args: bits[1]:0x0; bits[19]:0x25642; bits[29]:0x20
// args: bits[1]:0x0; bits[19]:0x3dae6; bits[29]:0x1f9e2b90
// args: bits[1]:0x1; bits[19]:0x15931; bits[29]:0x1000000
// args: bits[1]:0x0; bits[19]:0x4961; bits[29]:0x10d6ebc9
// args: bits[1]:0x0; bits[19]:0x3c69d; bits[29]:0x78fe1ea
// args: bits[1]:0x1; bits[19]:0x34ae; bits[29]:0x601f78c
// args: bits[1]:0x1; bits[19]:0x6602a; bits[29]:0x15ef6a4c
// args: bits[1]:0x0; bits[19]:0x2f61d; bits[29]:0x1f0397af
// args: bits[1]:0x1; bits[19]:0x2cfaf; bits[29]:0x11d550c3
// args: bits[1]:0x0; bits[19]:0x272dc; bits[29]:0x160cf7d3
// args: bits[1]:0x1; bits[19]:0xf2be; bits[29]:0x6aa3786
// args: bits[1]:0x1; bits[19]:0x8f3e; bits[29]:0x103c7fc
// args: bits[1]:0x0; bits[19]:0x1b586; bits[29]:0x1eb276df
// args: bits[1]:0x0; bits[19]:0x2f32e; bits[29]:0x23193fd
// args: bits[1]:0x0; bits[19]:0x9579; bits[29]:0x13c601ee
// args: bits[1]:0x0; bits[19]:0x2b004; bits[29]:0x18639cb
// args: bits[1]:0x1; bits[19]:0x6b322; bits[29]:0x71f06eb
// args: bits[1]:0x0; bits[19]:0x691ad; bits[29]:0x920d1a9
// args: bits[1]:0x0; bits[19]:0x62aa2; bits[29]:0x2
// args: bits[1]:0x0; bits[19]:0x378ca; bits[29]:0x19ca259
// args: bits[1]:0x1; bits[19]:0x7449a; bits[29]:0x1571a7e7
// args: bits[1]:0x1; bits[19]:0x40ea3; bits[29]:0x1129515a
// args: bits[1]:0x0; bits[19]:0x733b0; bits[29]:0x1cfe6fa4
// args: bits[1]:0x0; bits[19]:0xd6f; bits[29]:0x447157
// args: bits[1]:0x0; bits[19]:0x1cba6; bits[29]:0x1b225342
// args: bits[1]:0x0; bits[19]:0x7c23f; bits[29]:0x523f0f1
// args: bits[1]:0x1; bits[19]:0x52dc7; bits[29]:0x1fffffff
// args: bits[1]:0x1; bits[19]:0xb78a; bits[29]:0x1f4f08d0
// args: bits[1]:0x1; bits[19]:0x585c1; bits[29]:0xec7dbb0
// args: bits[1]:0x1; bits[19]:0x78ead; bits[29]:0x911163f
// args: bits[1]:0x0; bits[19]:0x10; bits[29]:0x1782164b
// args: bits[1]:0x0; bits[19]:0x51ee1; bits[29]:0xe16baa6
// args: bits[1]:0x1; bits[19]:0x61472; bits[29]:0x1fb9e58
// args: bits[1]:0x1; bits[19]:0x4a678; bits[29]:0x1b47d39c
// args: bits[1]:0x0; bits[19]:0xb53e; bits[29]:0x1bc6b7e3
// args: bits[1]:0x1; bits[19]:0x39671; bits[29]:0xb95829e
// args: bits[1]:0x1; bits[19]:0x355d2; bits[29]:0x48236f3
// args: bits[1]:0x1; bits[19]:0x47d5a; bits[29]:0x1b167f19
// args: bits[1]:0x0; bits[19]:0x62395; bits[29]:0x590ebc5
// args: bits[1]:0x1; bits[19]:0x7d35e; bits[29]:0x620ad23
// args: bits[1]:0x0; bits[19]:0x3df0a; bits[29]:0xf4c43fc
// args: bits[1]:0x1; bits[19]:0x1000; bits[29]:0x20000
// args: bits[1]:0x1; bits[19]:0x60320; bits[29]:0x13762d06
// args: bits[1]:0x1; bits[19]:0x62a2f; bits[29]:0x32edd09
// args: bits[1]:0x0; bits[19]:0x70ea1; bits[29]:0x153d1026
// args: bits[1]:0x0; bits[19]:0x5cf2e; bits[29]:0x4000
// args: bits[1]:0x1; bits[19]:0x5385f; bits[29]:0x11ff3dad
// args: bits[1]:0x1; bits[19]:0x4b76d; bits[29]:0xd611395
// args: bits[1]:0x1; bits[19]:0x74c0d; bits[29]:0x180aecb1
// args: bits[1]:0x1; bits[19]:0x665e5; bits[29]:0x13ce0716
// args: bits[1]:0x1; bits[19]:0x6109; bits[29]:0x18f605ec
// args: bits[1]:0x0; bits[19]:0x1c267; bits[29]:0x92c7
// args: bits[1]:0x1; bits[19]:0x75e5e; bits[29]:0x8000
// args: bits[1]:0x1; bits[19]:0xa212; bits[29]:0xaaaaaaa
// args: bits[1]:0x1; bits[19]:0x10000; bits[29]:0x400
// args: bits[1]:0x0; bits[19]:0x39958; bits[29]:0x1073a674
// args: bits[1]:0x0; bits[19]:0x67eff; bits[29]:0x8d4f61d
// args: bits[1]:0x1; bits[19]:0x2698b; bits[29]:0x192e87a2
// args: bits[1]:0x1; bits[19]:0x5b83c; bits[29]:0x1cff74a9
// args: bits[1]:0x1; bits[19]:0x713fe; bits[29]:0xf02591d
// args: bits[1]:0x1; bits[19]:0x76505; bits[29]:0x910391b
// args: bits[1]:0x0; bits[19]:0xdf9d; bits[29]:0xd862235
// args: bits[1]:0x0; bits[19]:0x5469f; bits[29]:0x1b6c133f
// args: bits[1]:0x0; bits[19]:0x5685e; bits[29]:0x1d8e0827
// args: bits[1]:0x0; bits[19]:0x1896f; bits[29]:0x8935af9
// args: bits[1]:0x1; bits[19]:0x4f6d0; bits[29]:0x9d39b25
// args: bits[1]:0x0; bits[19]:0x7e9ca; bits[29]:0x1838d3e
// args: bits[1]:0x1; bits[19]:0x67815; bits[29]:0x52fc899
// args: bits[1]:0x1; bits[19]:0x722b3; bits[29]:0x98df8e2
// args: bits[1]:0x0; bits[19]:0x368dd; bits[29]:0x1e8803e4
// args: bits[1]:0x1; bits[19]:0x2359; bits[29]:0xb6ac207
// args: bits[1]:0x1; bits[19]:0x21715; bits[29]:0x1868ebdd
// args: bits[1]:0x1; bits[19]:0x451d3; bits[29]:0x1259c4db
// args: bits[1]:0x1; bits[19]:0x2278e; bits[29]:0x5b658ae
// args: bits[1]:0x0; bits[19]:0x663cf; bits[29]:0xf9038d3
// args: bits[1]:0x0; bits[19]:0x656cf; bits[29]:0x2370b36
// args: bits[1]:0x0; bits[19]:0x60c32; bits[29]:0xf768a00
// args: bits[1]:0x0; bits[19]:0x5d3ed; bits[29]:0x183b77f
// args: bits[1]:0x1; bits[19]:0x3f323; bits[29]:0x196153dc
// args: bits[1]:0x0; bits[19]:0x1e1a2; bits[29]:0xdb95492
// args: bits[1]:0x0; bits[19]:0x4a9db; bits[29]:0x512106c
// args: bits[1]:0x0; bits[19]:0x3966f; bits[29]:0x200
// args: bits[1]:0x1; bits[19]:0x19042; bits[29]:0xde456af
// args: bits[1]:0x1; bits[19]:0x18d5f; bits[29]:0x4810d1a
// args: bits[1]:0x0; bits[19]:0x250f9; bits[29]:0x263dc35
// args: bits[1]:0x1; bits[19]:0x3ffff; bits[29]:0x400
// args: bits[1]:0x1; bits[19]:0x5e0c7; bits[29]:0x160c7b9a
// args: bits[1]:0x0; bits[19]:0x74e04; bits[29]:0x123a7a90
// args: bits[1]:0x0; bits[19]:0x683c5; bits[29]:0xfffffff
// args: bits[1]:0x1; bits[19]:0x4cebb; bits[29]:0x8a4075
// args: bits[1]:0x1; bits[19]:0x45f57; bits[29]:0x1971f5c9
// args: bits[1]:0x0; bits[19]:0x5be2e; bits[29]:0x1ef28c3f
// args: bits[1]:0x1; bits[19]:0x4b117; bits[29]:0xfca6e5c
// args: bits[1]:0x0; bits[19]:0x7dd9; bits[29]:0x5ae413a
// args: bits[1]:0x0; bits[19]:0x69861; bits[29]:0x75cb6c2
// args: bits[1]:0x0; bits[19]:0x57c23; bits[29]:0xee44ce1
// args: bits[1]:0x1; bits[19]:0x238ce; bits[29]:0xb686024
// args: bits[1]:0x0; bits[19]:0x13362; bits[29]:0xa7732e8
// args: bits[1]:0x0; bits[19]:0x8b33; bits[29]:0x1b344885
// args: bits[1]:0x0; bits[19]:0x7c445; bits[29]:0x1f33a1e6
// args: bits[1]:0x0; bits[19]:0x3b270; bits[29]:0x2693b97
// args: bits[1]:0x0; bits[19]:0x59328; bits[29]:0x138235fe
// args: bits[1]:0x1; bits[19]:0x2d031; bits[29]:0xe99cfa0
// args: bits[1]:0x1; bits[19]:0x40; bits[29]:0x121e50
// args: bits[1]:0x0; bits[19]:0x13ba7; bits[29]:0x10a3a2c8
// args: bits[1]:0x0; bits[19]:0x1582d; bits[29]:0x15bd4d3a
// args: bits[1]:0x0; bits[19]:0x2f820; bits[29]:0x105c2bc4
// args: bits[1]:0x0; bits[19]:0x75f70; bits[29]:0x400
// args: bits[1]:0x1; bits[19]:0x5fa1; bits[29]:0x1
// args: bits[1]:0x1; bits[19]:0x53db1; bits[29]:0x1d957a8
// args: bits[1]:0x0; bits[19]:0xfc6d; bits[29]:0x13e650d1
// args: bits[1]:0x1; bits[19]:0x7ffff; bits[29]:0x10cf40a8
// args: bits[1]:0x1; bits[19]:0x5b7ef; bits[29]:0x6088559
// args: bits[1]:0x0; bits[19]:0xfd8c; bits[29]:0xad966e3
// args: bits[1]:0x1; bits[19]:0x6a7b0; bits[29]:0x10198b98
// args: bits[1]:0x0; bits[19]:0x22b2f; bits[29]:0x8000
// args: bits[1]:0x0; bits[19]:0x55555; bits[29]:0x10af6114
// args: bits[1]:0x0; bits[19]:0x212ae; bits[29]:0x19fabff0
// args: bits[1]:0x1; bits[19]:0x78ef5; bits[29]:0x43566cb
// args: bits[1]:0x0; bits[19]:0x34c1; bits[29]:0x8d4f6db
// args: bits[1]:0x1; bits[19]:0x4f04d; bits[29]:0x2
// args: bits[1]:0x1; bits[19]:0x4000; bits[29]:0x134f4b52
// args: bits[1]:0x1; bits[19]:0x80; bits[29]:0x900d2d2
// args: bits[1]:0x1; bits[19]:0x10b76; bits[29]:0x1939d978
// args: bits[1]:0x1; bits[19]:0x6b96d; bits[29]:0xf687ee7
// args: bits[1]:0x0; bits[19]:0x1cb83; bits[29]:0x97799f2
// args: bits[1]:0x1; bits[19]:0x3c102; bits[29]:0x10000
// args: bits[1]:0x0; bits[19]:0x2e4c4; bits[29]:0x3825782
// args: bits[1]:0x0; bits[19]:0x44197; bits[29]:0x172dcab9
// args: bits[1]:0x0; bits[19]:0x3ea2d; bits[29]:0xe595285
// args: bits[1]:0x1; bits[19]:0x232fb; bits[29]:0x1ea1ec0
// args: bits[1]:0x1; bits[19]:0x25682; bits[29]:0x1498d572
// args: bits[1]:0x1; bits[19]:0x6f39b; bits[29]:0xd2ed4e8
// args: bits[1]:0x0; bits[19]:0x7c79d; bits[29]:0x8b0d9fa
// args: bits[1]:0x0; bits[19]:0x6bfbe; bits[29]:0x9d9cf65
// args: bits[1]:0x1; bits[19]:0xad7e; bits[29]:0xffde33e
// args: bits[1]:0x1; bits[19]:0x1662f; bits[29]:0x6c57700
// args: bits[1]:0x1; bits[19]:0x20; bits[29]:0x909133a
// args: bits[1]:0x0; bits[19]:0x2d9b0; bits[29]:0x19b8562
// args: bits[1]:0x0; bits[19]:0x2000; bits[29]:0xcb54d06
// args: bits[1]:0x0; bits[19]:0x4f841; bits[29]:0x1ee922e7
// args: bits[1]:0x1; bits[19]:0x4efa4; bits[29]:0x723a135
// args: bits[1]:0x1; bits[19]:0x100; bits[29]:0x19897a87
// args: bits[1]:0x1; bits[19]:0x8000; bits[29]:0x166b2875
// args: bits[1]:0x0; bits[19]:0x5dfa; bits[29]:0x1aafcdf
// args: bits[1]:0x0; bits[19]:0x44791; bits[29]:0x6dec5df
// args: bits[1]:0x0; bits[19]:0x1c127; bits[29]:0xb4c68d2
// args: bits[1]:0x0; bits[19]:0x718f; bits[29]:0x0
// args: bits[1]:0x1; bits[19]:0x3ffff; bits[29]:0x10000
// args: bits[1]:0x0; bits[19]:0x2fc5e; bits[29]:0x1fa24368
// args: bits[1]:0x1; bits[19]:0x2ea8c; bits[29]:0x1b0332bb
// args: bits[1]:0x0; bits[19]:0x19f6e; bits[29]:0x11aca786
// args: bits[1]:0x1; bits[19]:0x36127; bits[29]:0x155aca61
// args: bits[1]:0x1; bits[19]:0xf18a; bits[29]:0x1eeb97b7
// args: bits[1]:0x0; bits[19]:0x5128; bits[29]:0x149998b4
// args: bits[1]:0x0; bits[19]:0x6f829; bits[29]:0xb5e84ff
// args: bits[1]:0x1; bits[19]:0x469bc; bits[29]:0x1e317fdf
// args: bits[1]:0x1; bits[19]:0x564d; bits[29]:0x19848507
// args: bits[1]:0x1; bits[19]:0x3c1af; bits[29]:0xdcc79c6
// args: bits[1]:0x0; bits[19]:0x4; bits[29]:0xfda1d9e
// args: bits[1]:0x0; bits[19]:0x4932; bits[29]:0xea3c399
// args: bits[1]:0x0; bits[19]:0x1c695; bits[29]:0x132c1f0c
// args: bits[1]:0x1; bits[19]:0x28895; bits[29]:0x40
// args: bits[1]:0x1; bits[19]:0x79f8f; bits[29]:0x2e4194a
// args: bits[1]:0x0; bits[19]:0x3e936; bits[29]:0x12cf5965
// args: bits[1]:0x1; bits[19]:0x2aaaa; bits[29]:0x1d6cf142
// args: bits[1]:0x1; bits[19]:0x3c85b; bits[29]:0x116b76ca
// args: bits[1]:0x0; bits[19]:0x3b5b0; bits[29]:0x11f88022
// args: bits[1]:0x0; bits[19]:0x2041b; bits[29]:0x1011c9e2
// args: bits[1]:0x0; bits[19]:0x1000; bits[29]:0x14c99455
// args: bits[1]:0x1; bits[19]:0x11af5; bits[29]:0x43033f0
// args: bits[1]:0x1; bits[19]:0x6c6e0; bits[29]:0x116ff864
// args: bits[1]:0x0; bits[19]:0x1bbe5; bits[29]:0x400000
// args: bits[1]:0x0; bits[19]:0x2d3af; bits[29]:0x62abf99
// args: bits[1]:0x0; bits[19]:0x4687e; bits[29]:0x189ecd29
// args: bits[1]:0x1; bits[19]:0x52ea; bits[29]:0x107c5778
// args: bits[1]:0x1; bits[19]:0x8000; bits[29]:0x10
// args: bits[1]:0x0; bits[19]:0x7d91d; bits[29]:0x27e183
// args: bits[1]:0x0; bits[19]:0x37a27; bits[29]:0x8fdf9ec
// args: bits[1]:0x1; bits[19]:0x27a59; bits[29]:0x7030f36
// args: bits[1]:0x1; bits[19]:0x55d2d; bits[29]:0x21ab28f
// args: bits[1]:0x0; bits[19]:0x10dbc; bits[29]:0x2c8969f
// args: bits[1]:0x1; bits[19]:0x55555; bits[29]:0x2c02606
// args: bits[1]:0x0; bits[19]:0x3edb5; bits[29]:0xdc4aca3
// args: bits[1]:0x0; bits[19]:0x5e92b; bits[29]:0x3d7abf9
// args: bits[1]:0x0; bits[19]:0x420f3; bits[29]:0x185dcb2a
// args: bits[1]:0x1; bits[19]:0x59f50; bits[29]:0x1eb9fb3b
// args: bits[1]:0x1; bits[19]:0x18e53; bits[29]:0x1a5e0ac
// args: bits[1]:0x1; bits[19]:0x6072a; bits[29]:0x4
// args: bits[1]:0x0; bits[19]:0x57234; bits[29]:0xfaa5a3
// args: bits[1]:0x0; bits[19]:0x476af; bits[29]:0x1789aa9
// args: bits[1]:0x0; bits[19]:0x47928; bits[29]:0x91ad283
// args: bits[1]:0x1; bits[19]:0x1a36; bits[29]:0xee4c023
// args: bits[1]:0x1; bits[19]:0x7de9; bits[29]:0x1ad01673
// args: bits[1]:0x1; bits[19]:0x60090; bits[29]:0x16d9fd33
// args: bits[1]:0x0; bits[19]:0x5a2a3; bits[29]:0x1c5f1593
// args: bits[1]:0x1; bits[19]:0x44694; bits[29]:0xff1c81e
// args: bits[1]:0x0; bits[19]:0xd618; bits[29]:0xa6bf227
// args: bits[1]:0x0; bits[19]:0x421d2; bits[29]:0x10cacec4
// args: bits[1]:0x1; bits[19]:0x3a03b; bits[29]:0xfb2f9f1
// args: bits[1]:0x0; bits[19]:0x80; bits[29]:0xc917c58
// args: bits[1]:0x0; bits[19]:0x1766a; bits[29]:0x6c4c913
// args: bits[1]:0x1; bits[19]:0x128b1; bits[29]:0x12230874
// args: bits[1]:0x1; bits[19]:0x5f59; bits[29]:0x174f8cbf
// args: bits[1]:0x0; bits[19]:0x2364f; bits[29]:0x1d445c9e
// args: bits[1]:0x1; bits[19]:0xe185; bits[29]:0x4000000
// args: bits[1]:0x0; bits[19]:0x3f6ff; bits[29]:0x149714d1
// args: bits[1]:0x0; bits[19]:0x5af89; bits[29]:0x1d76a929
// args: bits[1]:0x0; bits[19]:0x64da4; bits[29]:0x1165d33d
// args: bits[1]:0x1; bits[19]:0xef17; bits[29]:0x1b6acdfe
// args: bits[1]:0x0; bits[19]:0x2aaaa; bits[29]:0xfcdc0fb
// args: bits[1]:0x1; bits[19]:0x21096; bits[29]:0x1adff947
// args: bits[1]:0x0; bits[19]:0x100; bits[29]:0x9de29c2
// args: bits[1]:0x1; bits[19]:0x47cd8; bits[29]:0x10
// args: bits[1]:0x1; bits[19]:0x7704c; bits[29]:0xffbdee9
// args: bits[1]:0x0; bits[19]:0x538f2; bits[29]:0xc44d36e
// args: bits[1]:0x1; bits[19]:0x4ec90; bits[29]:0xf4e3543
// args: bits[1]:0x0; bits[19]:0x7a225; bits[29]:0xb14bb54
// args: bits[1]:0x1; bits[19]:0x9156; bits[29]:0x9240128
// args: bits[1]:0x1; bits[19]:0x7d486; bits[29]:0x15a1658e
// args: bits[1]:0x1; bits[19]:0x1ebfb; bits[29]:0x40000
// args: bits[1]:0x1; bits[19]:0x4ab32; bits[29]:0x1adaf72a
// args: bits[1]:0x1; bits[19]:0x232d7; bits[29]:0x14864d6e
// args: bits[1]:0x1; bits[19]:0x260a1; bits[29]:0xde79a22
// args: bits[1]:0x1; bits[19]:0x5a775; bits[29]:0x1087475a
// args: bits[1]:0x1; bits[19]:0x6ca34; bits[29]:0xcc2ea59
// args: bits[1]:0x1; bits[19]:0x7a750; bits[29]:0x100
// args: bits[1]:0x1; bits[19]:0x63158; bits[29]:0x1a234f1b
// args: bits[1]:0x1; bits[19]:0x3c8da; bits[29]:0xdad5e6f
// args: bits[1]:0x1; bits[19]:0x1ef0; bits[29]:0x141a894d
// args: bits[1]:0x0; bits[19]:0x7f852; bits[29]:0x122ac319
// args: bits[1]:0x0; bits[19]:0x2b01c; bits[29]:0x2031717
// args: bits[1]:0x1; bits[19]:0x1d3d6; bits[29]:0x5423aed
// args: bits[1]:0x0; bits[19]:0x2b284; bits[29]:0x1e774372
// args: bits[1]:0x0; bits[19]:0x100; bits[29]:0x3f889fd
// args: bits[1]:0x1; bits[19]:0x3ad51; bits[29]:0x17787ddd
// args: bits[1]:0x0; bits[19]:0x2d246; bits[29]:0x15aa3fd7
// args: bits[1]:0x1; bits[19]:0x56dd7; bits[29]:0x17699232
// args: bits[1]:0x1; bits[19]:0xe23; bits[29]:0xcc9165
// args: bits[1]:0x0; bits[19]:0x6c3df; bits[29]:0x174cbaac
// args: bits[1]:0x0; bits[19]:0x6b165; bits[29]:0x7cfbeb8
// args: bits[1]:0x1; bits[19]:0x4e9a1; bits[29]:0x1e8034d
// args: bits[1]:0x1; bits[19]:0x74aa0; bits[29]:0x72583dd
// args: bits[1]:0x1; bits[19]:0x6ed10; bits[29]:0x1f9e428a
// args: bits[1]:0x0; bits[19]:0x34bc9; bits[29]:0x1fdab51b
// args: bits[1]:0x0; bits[19]:0x90e; bits[29]:0xc786455
// args: bits[1]:0x0; bits[19]:0x4a4f0; bits[29]:0x1e67efc2
// args: bits[1]:0x0; bits[19]:0x2; bits[29]:0x1bdc578b
// args: bits[1]:0x1; bits[19]:0x79ccc; bits[29]:0x1115a83d
// args: bits[1]:0x0; bits[19]:0x25f2f; bits[29]:0x1000
// args: bits[1]:0x1; bits[19]:0x6437d; bits[29]:0x261538f
// args: bits[1]:0x0; bits[19]:0x4299f; bits[29]:0xa8ced34
// args: bits[1]:0x1; bits[19]:0x4f847; bits[29]:0xd02de7d
// args: bits[1]:0x0; bits[19]:0x1000; bits[29]:0x189d7375
// args: bits[1]:0x1; bits[19]:0x26412; bits[29]:0x464c3cb
// args: bits[1]:0x1; bits[19]:0x20811; bits[29]:0x37b02ec
// args: bits[1]:0x1; bits[19]:0x206b5; bits[29]:0x914cf4b
// args: bits[1]:0x1; bits[19]:0x40fd4; bits[29]:0xe8f6925
// args: bits[1]:0x0; bits[19]:0x5fa32; bits[29]:0x4ff62e2
// args: bits[1]:0x1; bits[19]:0x5cf29; bits[29]:0x1000
// args: bits[1]:0x1; bits[19]:0x4002c; bits[29]:0x3379131
// args: bits[1]:0x1; bits[19]:0x4aad3; bits[29]:0x13e1c237
// args: bits[1]:0x1; bits[19]:0x559c; bits[29]:0xcecfd28
// args: bits[1]:0x0; bits[19]:0x71666; bits[29]:0x6e74ff0
// args: bits[1]:0x0; bits[19]:0x76dbb; bits[29]:0x341def2
// args: bits[1]:0x0; bits[19]:0x25bf8; bits[29]:0xaaaaaaa
// args: bits[1]:0x1; bits[19]:0x50de6; bits[29]:0x14167183
// args: bits[1]:0x1; bits[19]:0x6a4c2; bits[29]:0x11de3f2c
// args: bits[1]:0x0; bits[19]:0x6e3ce; bits[29]:0x4142203
// args: bits[1]:0x0; bits[19]:0x72b0d; bits[29]:0x0
// args: bits[1]:0x0; bits[19]:0x754b1; bits[29]:0x1288f9b7
// args: bits[1]:0x0; bits[19]:0x5b17; bits[29]:0x10fc47b0
// args: bits[1]:0x1; bits[19]:0x5738c; bits[29]:0x17d32856
// args: bits[1]:0x1; bits[19]:0x35b6; bits[29]:0xbd64309
// args: bits[1]:0x0; bits[19]:0x75b3; bits[29]:0x107fa81
// args: bits[1]:0x0; bits[19]:0x6d3e4; bits[29]:0x16a33af8
// args: bits[1]:0x0; bits[19]:0x5fef5; bits[29]:0x1478dcff
// args: bits[1]:0x0; bits[19]:0x1f4e6; bits[29]:0x19aedb0c
// args: bits[1]:0x0; bits[19]:0x1b00a; bits[29]:0x10ea8153
// args: bits[1]:0x0; bits[19]:0x6887; bits[29]:0x1ebc1c23
// args: bits[1]:0x0; bits[19]:0x65a5; bits[29]:0xfdfa15e
// args: bits[1]:0x1; bits[19]:0x70d84; bits[29]:0xb625567
// args: bits[1]:0x0; bits[19]:0xb810; bits[29]:0x10e92bbf
// args: bits[1]:0x0; bits[19]:0xbcc; bits[29]:0x13041842
// args: bits[1]:0x0; bits[19]:0x51ae6; bits[29]:0xce170ba
// args: bits[1]:0x1; bits[19]:0x77ac9; bits[29]:0x129f7ae5
// args: bits[1]:0x1; bits[19]:0x2; bits[29]:0x10a715a2
// args: bits[1]:0x0; bits[19]:0x3aa73; bits[29]:0x40
// args: bits[1]:0x1; bits[19]:0x6c080; bits[29]:0x18feea18
// args: bits[1]:0x1; bits[19]:0x584da; bits[29]:0xaaaaaaa
// args: bits[1]:0x1; bits[19]:0x67356; bits[29]:0xec18c08
// args: bits[1]:0x0; bits[19]:0x1; bits[29]:0x16ed6392
// args: bits[1]:0x1; bits[19]:0x61ff7; bits[29]:0x9d5c0c9
// args: bits[1]:0x0; bits[19]:0x5a97a; bits[29]:0x20000
// args: bits[1]:0x0; bits[19]:0x51d9e; bits[29]:0x12e2b922
// args: bits[1]:0x0; bits[19]:0x800; bits[29]:0x1b44e068
// args: bits[1]:0x0; bits[19]:0x7499d; bits[29]:0xc4836d6
// args: bits[1]:0x0; bits[19]:0xc2; bits[29]:0x17241a22
// args: bits[1]:0x0; bits[19]:0x3ed31; bits[29]:0xec307ec
// args: bits[1]:0x1; bits[19]:0x3d4d0; bits[29]:0x1e08786d
// args: bits[1]:0x1; bits[19]:0x15970; bits[29]:0x15b4fe6c
// args: bits[1]:0x1; bits[19]:0x59488; bits[29]:0xff74bc8
// args: bits[1]:0x1; bits[19]:0x3236; bits[29]:0x32fb813
// args: bits[1]:0x0; bits[19]:0x36916; bits[29]:0x3f053b4
// args: bits[1]:0x0; bits[19]:0x4d6b6; bits[29]:0x987a7c
// args: bits[1]:0x1; bits[19]:0x8000; bits[29]:0xa367f97
// args: bits[1]:0x1; bits[19]:0x55555; bits[29]:0x9d11bf
// args: bits[1]:0x0; bits[19]:0x7ac0; bits[29]:0x609758f
// args: bits[1]:0x0; bits[19]:0x57901; bits[29]:0x8ce6c43
// args: bits[1]:0x0; bits[19]:0x28827; bits[29]:0x39957f
// args: bits[1]:0x0; bits[19]:0x25ce2; bits[29]:0x9ed501d
// args: bits[1]:0x1; bits[19]:0x2be93; bits[29]:0x19c527a5
// args: bits[1]:0x0; bits[19]:0x3c76b; bits[29]:0x3c36924
// args: bits[1]:0x0; bits[19]:0x22072; bits[29]:0x18efa4b6
// args: bits[1]:0x0; bits[19]:0x5aafc; bits[29]:0x11342305
// args: bits[1]:0x0; bits[19]:0xb84f; bits[29]:0x15d309e1
// args: bits[1]:0x0; bits[19]:0x13af2; bits[29]:0x3caaa2a
// args: bits[1]:0x1; bits[19]:0x1aeb0; bits[29]:0x66b935b
// args: bits[1]:0x1; bits[19]:0x1a02c; bits[29]:0x1ad17da0
// args: bits[1]:0x0; bits[19]:0x500f2; bits[29]:0x68ea8b2
// args: bits[1]:0x1; bits[19]:0xd712; bits[29]:0x115c2249
// args: bits[1]:0x1; bits[19]:0x4b5a0; bits[29]:0x4047a57
// args: bits[1]:0x1; bits[19]:0x4; bits[29]:0x509689
// args: bits[1]:0x0; bits[19]:0x346ca; bits[29]:0x10109df5
// args: bits[1]:0x0; bits[19]:0x28bf6; bits[29]:0xb5d873c
// args: bits[1]:0x0; bits[19]:0x4000; bits[29]:0x112d8793
// args: bits[1]:0x1; bits[19]:0x6b81e; bits[29]:0x1b3077d9
// args: bits[1]:0x0; bits[19]:0x4d133; bits[29]:0x1c7e86cf
// args: bits[1]:0x0; bits[19]:0x40496; bits[29]:0x25add7
// args: bits[1]:0x0; bits[19]:0x2fbcf; bits[29]:0x509eaa8
// args: bits[1]:0x1; bits[19]:0x27eb0; bits[29]:0x10c5103d
// args: bits[1]:0x1; bits[19]:0x13e1; bits[29]:0xd3effc2
// args: bits[1]:0x1; bits[19]:0x48849; bits[29]:0x8
// args: bits[1]:0x0; bits[19]:0x48ff9; bits[29]:0x1d6afa0
// args: bits[1]:0x1; bits[19]:0x4dd51; bits[29]:0xbb9e56b
// args: bits[1]:0x1; bits[19]:0x2aae6; bits[29]:0x1c876dfd
// args: bits[1]:0x0; bits[19]:0x3acbf; bits[29]:0xe5ac953
// args: bits[1]:0x1; bits[19]:0x3c258; bits[29]:0x1ffe10c2
// args: bits[1]:0x0; bits[19]:0x23a92; bits[29]:0x174af71
// args: bits[1]:0x1; bits[19]:0x20; bits[29]:0xdd2bf7
// args: bits[1]:0x1; bits[19]:0x6853e; bits[29]:0x19781821
// args: bits[1]:0x0; bits[19]:0x3565; bits[29]:0x45e8a9e
// args: bits[1]:0x1; bits[19]:0x228da; bits[29]:0xde57a3f
// args: bits[1]:0x1; bits[19]:0x99f4; bits[29]:0x15d3ba8e
// args: bits[1]:0x1; bits[19]:0x3f02f; bits[29]:0x1ee5a81a
// args: bits[1]:0x1; bits[19]:0x4210f; bits[29]:0x711c93e
// args: bits[1]:0x0; bits[19]:0xae19; bits[29]:0xebe5140
// args: bits[1]:0x0; bits[19]:0x660bd; bits[29]:0x35faa1
// args: bits[1]:0x0; bits[19]:0x5afc0; bits[29]:0x1b77ef7
// args: bits[1]:0x0; bits[19]:0x7e1ca; bits[29]:0x19b6ad6
// args: bits[1]:0x1; bits[19]:0xb2fa; bits[29]:0x1fffffff
// args: bits[1]:0x0; bits[19]:0x20730; bits[29]:0x14e8a886
// args: bits[1]:0x1; bits[19]:0x20f9f; bits[29]:0x135e94e3
// args: bits[1]:0x1; bits[19]:0x50507; bits[29]:0x8
// args: bits[1]:0x1; bits[19]:0x10; bits[29]:0xc7dc009
// args: bits[1]:0x0; bits[19]:0x3fca7; bits[29]:0xc97730c
// args: bits[1]:0x0; bits[19]:0x5e6ba; bits[29]:0xae3f3b0
// args: bits[1]:0x1; bits[19]:0x24592; bits[29]:0x162dc7bd
// args: bits[1]:0x1; bits[19]:0x674cc; bits[29]:0x200000
// args: bits[1]:0x0; bits[19]:0x554bd; bits[29]:0x96ec5ac
// args: bits[1]:0x0; bits[19]:0x4cd84; bits[29]:0xde74ff1
// args: bits[1]:0x1; bits[19]:0xcc10; bits[29]:0xa47f9a0
// args: bits[1]:0x0; bits[19]:0x7c5d9; bits[29]:0xd78ee2a
// args: bits[1]:0x1; bits[19]:0x2000; bits[29]:0x1cab7af
// args: bits[1]:0x0; bits[19]:0x14b07; bits[29]:0x10b4ac23
// args: bits[1]:0x1; bits[19]:0x1c13c; bits[29]:0x1f21878b
// args: bits[1]:0x1; bits[19]:0x1fe8b; bits[29]:0x11243003
// args: bits[1]:0x1; bits[19]:0xd991; bits[29]:0x24520b7
// args: bits[1]:0x0; bits[19]:0x20cb6; bits[29]:0x13a7dd63
// args: bits[1]:0x0; bits[19]:0x1274c; bits[29]:0x15f27540
// args: bits[1]:0x1; bits[19]:0x26984; bits[29]:0x1377083f
// args: bits[1]:0x0; bits[19]:0x220e2; bits[29]:0x93a7859
// args: bits[1]:0x0; bits[19]:0x2000; bits[29]:0x9fdcfb0
// args: bits[1]:0x1; bits[19]:0x78a84; bits[29]:0x5f3d7de
// args: bits[1]:0x1; bits[19]:0x800; bits[29]:0x2a2db3d
// args: bits[1]:0x1; bits[19]:0x10; bits[29]:0x5ea780b
// args: bits[1]:0x1; bits[19]:0x7d246; bits[29]:0x12b32336
// args: bits[1]:0x1; bits[19]:0x7a8ce; bits[29]:0x3bae7fa
// args: bits[1]:0x0; bits[19]:0x1000; bits[29]:0x32c5868
// args: bits[1]:0x1; bits[19]:0x20000; bits[29]:0x8b1f939
// args: bits[1]:0x1; bits[19]:0x2ecd3; bits[29]:0x1a1c80f6
// args: bits[1]:0x0; bits[19]:0x787e8; bits[29]:0x81e1222
// args: bits[1]:0x1; bits[19]:0xc9b3; bits[29]:0x1e1c0d24
// args: bits[1]:0x1; bits[19]:0x400; bits[29]:0x178757ca
// args: bits[1]:0x1; bits[19]:0x27bce; bits[29]:0x1604c854
// args: bits[1]:0x1; bits[19]:0x10104; bits[29]:0xb0049a0
// args: bits[1]:0x1; bits[19]:0x591d2; bits[29]:0x12706063
// args: bits[1]:0x1; bits[19]:0x77024; bits[29]:0xfffffff
// args: bits[1]:0x0; bits[19]:0x4fb8b; bits[29]:0x16758040
// args: bits[1]:0x0; bits[19]:0x5cd7; bits[29]:0x564f50f
// args: bits[1]:0x0; bits[19]:0x154c9; bits[29]:0x9cd6aff
// args: bits[1]:0x0; bits[19]:0x2000; bits[29]:0x53a2efa
// args: bits[1]:0x1; bits[19]:0x1bfb6; bits[29]:0x10000
// args: bits[1]:0x0; bits[19]:0x20000; bits[29]:0xaaaaaaa
// args: bits[1]:0x1; bits[19]:0x3791a; bits[29]:0x1095830c
// args: bits[1]:0x1; bits[19]:0x3598f; bits[29]:0x1000
// args: bits[1]:0x1; bits[19]:0x667df; bits[29]:0x1c90e6c3
// args: bits[1]:0x0; bits[19]:0x608dd; bits[29]:0x14208d48
// args: bits[1]:0x1; bits[19]:0x49bc3; bits[29]:0x14f19801
// args: bits[1]:0x0; bits[19]:0x3070a; bits[29]:0x10e1a018
// args: bits[1]:0x0; bits[19]:0x3b223; bits[29]:0x1700bcf7
// args: bits[1]:0x0; bits[19]:0xbb50; bits[29]:0x1c9cea71
// args: bits[1]:0x0; bits[19]:0x66b7c; bits[29]:0x100
// args: bits[1]:0x0; bits[19]:0x7c6b4; bits[29]:0xb54ed65
// args: bits[1]:0x0; bits[19]:0x493bc; bits[29]:0x8dc3e06
// args: bits[1]:0x1; bits[19]:0x75099; bits[29]:0x11e8cffe
// args: bits[1]:0x0; bits[19]:0x71069; bits[29]:0x0
// args: bits[1]:0x1; bits[19]:0x124a8; bits[29]:0x99d029
// args: bits[1]:0x0; bits[19]:0x34ac0; bits[29]:0x2aa8812
// args: bits[1]:0x1; bits[19]:0x7c727; bits[29]:0x122da703
// args: bits[1]:0x0; bits[19]:0x2fd92; bits[29]:0x8
// args: bits[1]:0x1; bits[19]:0x49049; bits[29]:0x124744b4
// args: bits[1]:0x0; bits[19]:0x734fd; bits[29]:0x31244ca
// args: bits[1]:0x0; bits[19]:0x8; bits[29]:0x154d559b
// args: bits[1]:0x0; bits[19]:0x5a59c; bits[29]:0x658302f
// args: bits[1]:0x0; bits[19]:0x4000; bits[29]:0xc41ccec
// args: bits[1]:0x0; bits[19]:0x340e9; bits[29]:0xd327142
// args: bits[1]:0x0; bits[19]:0x20; bits[29]:0x99b49
// args: bits[1]:0x0; bits[19]:0x40; bits[29]:0x1969d90c
// args: bits[1]:0x0; bits[19]:0x100; bits[29]:0x8a2524b
// args: bits[1]:0x1; bits[19]:0x7b121; bits[29]:0x1c109db
// args: bits[1]:0x1; bits[19]:0x40000; bits[29]:0x1dd3683e
// args: bits[1]:0x1; bits[19]:0x9847; bits[29]:0x11ebe83b
// args: bits[1]:0x1; bits[19]:0x301e7; bits[29]:0xbdcc5a5
// args: bits[1]:0x0; bits[19]:0x516fa; bits[29]:0x13e0c7b1
// args: bits[1]:0x1; bits[19]:0x304cb; bits[29]:0x10000
// args: bits[1]:0x1; bits[19]:0x67a0c; bits[29]:0x16c6eccf
// args: bits[1]:0x0; bits[19]:0x3bd7d; bits[29]:0xbcc7a32
// args: bits[1]:0x0; bits[19]:0x80; bits[29]:0x1000000
// args: bits[1]:0x0; bits[19]:0x19323; bits[29]:0x1dee1c01
// args: bits[1]:0x1; bits[19]:0x4042e; bits[29]:0x1d374108
// args: bits[1]:0x1; bits[19]:0x6b33d; bits[29]:0x11227a4f
// args: bits[1]:0x0; bits[19]:0x8; bits[29]:0x75e8488
// args: bits[1]:0x1; bits[19]:0x76f91; bits[29]:0x8f05d7
fn main(x10288: u1, x10289: u19, x10290: u29) -> (bool, u1, bool, bool, u29, u19) {
    let x10291: bool = ((x10289 as u29)) >= (x10290);
    let x10292: u19 = (x10290 as u19) * (x10289);
    let x10293: u1 = (x10291 as u1) ^ (x10288);
    let x10294: u19 = (x10289) * ((x10293 as u19));
    let x10295: u29 = !(x10290);
    let x10296: u20 = (u20:0x100);
    let x10297: bool = (x10291) - (x10291);
    (x10291, x10293, x10291, x10297, x10295, x10292)
}


