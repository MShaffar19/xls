# Lint as: python3
#
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Helper utilities for asserting DSLX interpreter/LLVM IR JIT equivalence."""

from typing import Tuple, Text, Optional, Dict
from xls.dslx import ast
from xls.ir.python import llvm_ir_jit
from xls.ir.python import value as ir_value
from xls.ir.python import bits as bits_mod
from xls.ir.python import number_parser
from xls.dslx import bit_helpers
from xls.dslx.concrete_type import ArrayType
from xls.dslx.concrete_type import BitsType
from xls.dslx.concrete_type import ConcreteType
from xls.dslx.concrete_type import EnumType
from xls.dslx.concrete_type import TupleType

class UnsupportedConversionError(Exception):
  pass

def convert_args_to_ir(args):
  ir_args = []
  for arg in args:
    if arg.is_bits():
      ir_args.append(
              ir_value.Value(int_to_bits(arg.get_bits_value_check_sign(),
                                         arg.get_bit_count())))
    else:
      raise UnsupportedConversionError

  return ir_args

def compare_return_values(return_type, interpreter_value, jit_value):
  if not isinstance(return_type, BitsType):
    raise UnsupportedConversionError

  assert jit_value.is_bits()
  jit_value = jit_value.get_bits()
  try:
    if not return_type.get_signedness():
      # print(ret_val.get_bit_count())
      interpreter_bits_value = interpreter_value.get_bits_value()
      jit_bits_value = jit_value.to_uint()
    else:
      interpreter_bits_value = interpreter_value.get_bits_value_signed()
      jit_bits_value = jit_value.to_int()
  except RuntimeError as _:
    raise UnsupportedConversionError

  assert interpreter_bits_value == jit_bits_value

def int_to_bits(value: int, bit_count: int) -> bits_mod.Bits:
  """Converts a Python arbitrary precision int to a Bits type."""
  if bit_count <= 64:
    return bits_mod.UBits(value, bit_count) if value >= 0 else bits_mod.SBits(
        value, bit_count)
  return number_parser.bits_from_string(
      bit_helpers.to_hex_string(value, bit_count), bit_count=bit_count)
