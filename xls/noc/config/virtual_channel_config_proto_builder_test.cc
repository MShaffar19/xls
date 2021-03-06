// Copyright 2020 The XLS Authors
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

#include "xls/noc/config/virtual_channel_config_proto_builder.h"

#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace xls::noc {

// Test field values for a virtual channel.
TEST(VirtualChannelConfigBuilderTest, FieldValues) {
  const char* kName = "Test";
  const int64 kFlitBitWidth = 42;
  const int64 kDepth = 1337;
  VirtualChannelConfigProto proto;
  VirtualChannelConfigProtoBuilder builder(&proto);
  builder.WithName(kName);
  builder.WithFlitBitWidth(kFlitBitWidth);
  builder.WithDepth(kDepth);

  EXPECT_TRUE(proto.has_name());
  EXPECT_TRUE(proto.has_flit_bit_width());
  EXPECT_TRUE(proto.has_depth());
  EXPECT_EQ(proto.name(), kName);
  EXPECT_EQ(proto.flit_bit_width(), kFlitBitWidth);
  EXPECT_EQ(proto.depth(), kDepth);
}

}  // namespace xls::noc
