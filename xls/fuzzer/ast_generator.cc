// Copyright 2021 The XLS Authors
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

#include "xls/fuzzer/ast_generator.h"

#include "absl/strings/match.h"
#include "xls/common/status/ret_check.h"
#include "xls/ir/bits_ops.h"

namespace xls::dslx {

/* static */ std::pair<std::vector<Expr*>, std::vector<TypeAnnotation*>>
AstGenerator::Unzip(absl::Span<const TypedExpr> typed_exprs) {
  std::vector<Expr*> exprs;
  std::vector<TypeAnnotation*> types;
  for (auto& typed_expr : typed_exprs) {
    exprs.push_back(typed_expr.expr);
    types.push_back(typed_expr.type);
  }
  return std::make_pair(std::move(exprs), std::move(types));
}

/* static */ bool AstGenerator::IsUBits(TypeAnnotation* t) {
  if (auto* bits = dynamic_cast<BuiltinTypeAnnotation*>(t)) {
    return !bits->GetSignedness();
  }
  if (auto* array = dynamic_cast<ArrayTypeAnnotation*>(t)) {
    if (auto* builtin =
            dynamic_cast<BuiltinTypeAnnotation*>(array->element_type())) {
      switch (builtin->builtin_type()) {
        case BuiltinType::kBits:
          return true;
        case BuiltinType::kUN:
          return true;
        default:
          return false;
      }
    }
  }
  return false;
}

/* static */ bool AstGenerator::IsBits(TypeAnnotation* t) {
  if (dynamic_cast<BuiltinTypeAnnotation*>(t) != nullptr) {
    return true;
  }
  if (auto* array = dynamic_cast<ArrayTypeAnnotation*>(t)) {
    if (auto* builtin =
            dynamic_cast<BuiltinTypeAnnotation*>(array->element_type())) {
      switch (builtin->builtin_type()) {
        case BuiltinType::kBits:
          return true;
        case BuiltinType::kUN:
          return true;
        case BuiltinType::kSN:
          return true;
        default:
          return false;
      }
    }
  }
  return false;
}

/* static */ bool AstGenerator::IsArray(TypeAnnotation* t) {
  if (dynamic_cast<ArrayTypeAnnotation*>(t) != nullptr) {
    return !IsBits(t);
  }
  return false;
}

/* static */ bool AstGenerator::IsTuple(TypeAnnotation* t) {
  return dynamic_cast<TupleTypeAnnotation*>(t) != nullptr;
}

/* static */ bool AstGenerator::EnvContainsArray(const Env& e) {
  return std::any_of(e.begin(), e.end(), [](const auto& item) -> bool {
    return IsArray(item.second.type);
  });
}

/* static */ bool AstGenerator::EnvContainsTuple(const Env& e) {
  return std::any_of(e.begin(), e.end(), [](const auto& item) -> bool {
    return IsTuple(item.second.type);
  });
}

absl::StatusOr<Param*> AstGenerator::GenerateParam() {
  std::string identifier = GenSym();
  XLS_ASSIGN_OR_RETURN(TypeAnnotation * type, GenerateBitsType());
  NameDef* name_def = module_->Make<NameDef>(fake_span_, std::move(identifier),
                                             /*definer=*/nullptr);
  Param* param = module_->Make<Param>(name_def, type);
  name_def->set_definer(param);
  return param;
}

absl::StatusOr<std::vector<Param*>> AstGenerator::GenerateParams(int64 count) {
  std::vector<Param*> params;
  for (int64 i = 0; i < count; ++i) {
    XLS_ASSIGN_OR_RETURN(Param * p, GenerateParam());
    params.push_back(p);
  }
  return params;
}

TypeAnnotation* AstGenerator::MakeTypeAnnotation(bool is_signed, int64 width) {
  XLS_CHECK_GT(width, 0);
  if (width <= 64) {
    return module_->Make<BuiltinTypeAnnotation>(
        fake_span_, GetBuiltinType(is_signed, width).value());
  }
  auto* element_type = module_->Make<BuiltinTypeAnnotation>(
      fake_span_, is_signed ? BuiltinType::kSN : BuiltinType::kUN);
  Number* dim = MakeNumber(width);
  return module_->Make<ArrayTypeAnnotation>(fake_span_, element_type, dim);
}

absl::StatusOr<Expr*> AstGenerator::GenerateUmin(TypedExpr arg, int64 other) {
  Number* rhs = MakeNumber(other, arg.type);
  Expr* test = MakeGe(arg.expr, rhs);
  return MakeSel(test, rhs, arg.expr);
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateCompare(Env* env) {
  BinopKind op = RandomSetChoice<BinopKind>(GetBinopComparisonKinds());
  XLS_ASSIGN_OR_RETURN(auto pair, ChooseEnvValueBitsPair(env));
  TypedExpr lhs = pair.first;
  TypedExpr rhs = pair.second;
  Binop* binop = module_->Make<Binop>(fake_span_, op, lhs.expr, rhs.expr);
  return TypedExpr{binop, MakeTypeAnnotation(false, 1)};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateShift(Env* env) {
  BinopKind op = RandomSetChoice<BinopKind>(GetBinopShifts());
  XLS_ASSIGN_OR_RETURN(auto pair, ChooseEnvValueBitsPair(env));
  TypedExpr lhs = pair.first;
  TypedExpr rhs = pair.second;
  if (RandomFloat() < 0.8) {
    // Clamp the shift rhs to be in range most of the time.
    int64 bit_count = GetTypeBitCount(rhs.type);
    int64 new_upper = RandRange(bit_count);
    XLS_ASSIGN_OR_RETURN(rhs.expr, GenerateUmin(rhs, new_upper));
  }
  return TypedExpr{module_->Make<Binop>(fake_span_, op, lhs.expr, rhs.expr),
                   lhs.type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateBinop(Env* env) {
  XLS_ASSIGN_OR_RETURN(auto pair, ChooseEnvValueBitsPair(env));
  TypedExpr lhs = pair.first;
  TypedExpr rhs = pair.second;
  BinopKind op = RandomSetChoice(binops_);
  return TypedExpr{module_->Make<Binop>(fake_span_, op, lhs.expr, rhs.expr),
                   lhs.type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateLogicalOp(Env* env) {
  XLS_ASSIGN_OR_RETURN(auto pair, ChooseEnvValueBitsPair(env, /*bit_count=*/1));
  TypedExpr lhs = pair.first;
  TypedExpr rhs = pair.second;

  // Pick some operation to do.
  BinopKind op = RandomChoice<BinopKind>(
      {BinopKind::kAnd, BinopKind::kOr, BinopKind::kXor});
  return TypedExpr{module_->Make<Binop>(fake_span_, op, lhs.expr, rhs.expr),
                   lhs.type};
}

Number* AstGenerator::MakeNumber(int64 value, TypeAnnotation* type) {
  if (IsBuiltinBool(type)) {
    XLS_CHECK(value == 0 || value == 1) << value;
    return module_->Make<Number>(fake_span_, value ? "true" : "false",
                                 NumberKind::kBool, type);
  }
  return module_->Make<Number>(fake_span_, absl::StrFormat("%d", value),
                               NumberKind::kOther, type);
}

Number* AstGenerator::MakeNumberFromBits(const Bits& value,
                                         TypeAnnotation* type) {
  return module_->Make<Number>(fake_span_,
                               value.ToString(FormatPreference::kHex),
                               NumberKind::kOther, type);
}

int64 AstGenerator::GetTypeBitCount(TypeAnnotation* type) {
  std::string type_str = type->ToString();
  if (type_str == "uN" || type_str == "sN" || type_str == "bits") {
    // These types are not valid alone, but as the element type of an array
    // (e.g. uN[42]) where they effectively have a width of one bit.
    return 1;
  }

  if (auto* builtin = dynamic_cast<BuiltinTypeAnnotation*>(type)) {
    return builtin->GetBitCount();
  }
  if (auto* array = dynamic_cast<ArrayTypeAnnotation*>(type)) {
    return GetArraySize(array) * GetTypeBitCount(array->element_type());
  }
  if (auto* tuple = dynamic_cast<TupleTypeAnnotation*>(type)) {
    int64 total = 0;
    for (TypeAnnotation* type : tuple->members()) {
      total += GetTypeBitCount(type);
    }
    return total;
  }

  return type_bit_counts_.at(type_str);
}

int64 AstGenerator::GetArraySize(ArrayTypeAnnotation* type) {
  Expr* dim = type->dim();
  if (auto* number = dynamic_cast<Number*>(dim)) {
    return number->GetAsUint64().value();
  }
  auto* const_ref = dynamic_cast<ConstRef*>(dim);
  ConstantDef* const_def = constants_[const_ref->identifier()];
  Number* number = dynamic_cast<Number*>(const_def->value());
  XLS_CHECK(number != nullptr) << const_def->ToString();
  return number->GetAsUint64().value();
}

ArrayTypeAnnotation* AstGenerator::MakeArrayType(TypeAnnotation* element_type,
                                                 int64 array_size) {
  Expr* dim;
  if (RandomBool()) {
    // Get-or-create a module level constant for the array size.
    int64 width = std::max(
        int64{1}, static_cast<int64>(std::ceil(std::log2(array_size + 1))));
    std::string identifier = absl::StrFormat("W%d_V%d", width, array_size);
    ConstantDef* constant_def;
    if (auto it = constants_.find(identifier); it != constants_.end()) {
      constant_def = it->second;
    } else {
      TypeAnnotation* size_type = MakeTypeAnnotation(false, width);
      NameDef* name_def =
          module_->Make<NameDef>(fake_span_, identifier, /*definer=*/nullptr);
      constant_def = module_->Make<ConstantDef>(
          fake_span_, name_def, MakeNumber(array_size, size_type),
          /*is_public=*/false);
      name_def->set_definer(constant_def);
      constants_[identifier] = constant_def;
    }
    dim = module_->Make<ConstRef>(fake_span_, identifier,
                                  constant_def->name_def());
  } else {
    dim = MakeNumber(array_size);
  }

  return module_->Make<ArrayTypeAnnotation>(
      fake_span_, MakeTypeRefTypeAnnotation(element_type), dim);
}

Invocation* AstGenerator::MakeRange(Expr* zero, Expr* arg) {
  std::vector<Expr*> args = {zero, arg};
  return module_->Make<Invocation>(fake_span_,
                                   /*callee=*/MakeBuiltinNameRef("range"),
                                   /*args=*/args);
}

Bits AstGenerator::ChooseBitPattern(int64 bit_count) {
  if (bit_count == 0) {
    return Bits(0);
  }
  enum PatternKind {
    kZero,
    kAllOnes,
    // Just the high bit is unset, otherwise all ones.
    kAllButHighOnes,
    // Alternating 01 bit pattern.
    kOffOn,
    // Alternating 10 bit pattern.
    kOnOff,
    kOneHot,
    kRandom,
  };
  PatternKind choice = static_cast<PatternKind>(RandRange(kRandom + 1));
  switch (choice) {
    case kZero:
      return Bits(bit_count);
    case kAllOnes:
      return Bits::AllOnes(bit_count);
    case kAllButHighOnes:
      return bits_ops::ShiftRightLogical(Bits::AllOnes(bit_count), 1);
    case kOffOn: {
      InlineBitmap bitmap(bit_count);
      for (int64 i = 1; i < bit_count; i += 2) {
        bitmap.Set(i, 1);
      }
      return Bits::FromBitmap(std::move(bitmap));
    }
    case kOnOff: {
      InlineBitmap bitmap(bit_count);
      for (int64 i = 0; i < bit_count; i += 2) {
        bitmap.Set(i, 1);
      }
      return Bits::FromBitmap(std::move(bitmap));
    }
    case kOneHot: {
      InlineBitmap bitmap(bit_count);
      int64 index = RandRange(bit_count);
      bitmap.Set(index, 1);
      return Bits::FromBitmap(std::move(bitmap));
    }
    case kRandom: {
      InlineBitmap bitmap(bit_count);
      for (int64 i = 0; i < bit_count; ++i) {
        bitmap.Set(i, RandomBool());
      }
      return Bits::FromBitmap(std::move(bitmap));
    }
  }
  XLS_LOG(FATAL) << "Impossible choice: " << choice;
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateOneHotSelectBuiltin(Env* env) {
  // We need to choose a selector with a certain number of bits, then form an
  // array from that many values in the environment.
  constexpr int64 kMaxBitCount = 8;
  auto choose_value = [this](const TypedExpr& e) -> bool {
    TypeAnnotation* t = e.type;
    return IsUBits(t) && 0 <= GetTypeBitCount(t) &&
           GetTypeBitCount(t) <= kMaxBitCount;
  };

  absl::optional<TypedExpr> lhs =
      ChooseEnvValueOptional(env, /*take=*/choose_value);
  if (!lhs.has_value()) {
    // If there's no natural environment value to use as the LHS, make up a
    // number and number of bits.
    int64 bits = RandRange(1, kMaxBitCount);
    XLS_ASSIGN_OR_RETURN(lhs,
                         GenerateNumber(env, BitsAndSignedness{bits, false}));
  }

  XLS_ASSIGN_OR_RETURN(TypedExpr rhs, ChooseEnvValueBits(env));
  std::vector<Expr*> cases = {rhs.expr};
  int64 total_operands = GetTypeBitCount(lhs->type);
  for (int64 i = 0; i < total_operands - 1; ++i) {
    XLS_ASSIGN_OR_RETURN(TypedExpr e, ChooseEnvValue(env, rhs.type));
    cases.push_back(e.expr);
  }

  auto* cases_array =
      module_->Make<Array>(fake_span_, cases, /*has_ellipsis=*/false);
  auto* invocation =
      module_->Make<Invocation>(fake_span_, MakeBuiltinNameRef("one_hot_sel"),
                                std::vector<Expr*>{lhs->expr, cases_array});
  return TypedExpr{invocation, rhs.type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateArrayConcat(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr lhs, ChooseEnvValueArray(env));
  auto* lhs_array_type = dynamic_cast<ArrayTypeAnnotation*>(lhs.type);
  XLS_RET_CHECK(lhs_array_type != nullptr);

  auto array_compatible = [&](const TypedExpr& e) -> bool {
    TypeAnnotation* t = e.type;
    if (auto* array = dynamic_cast<ArrayTypeAnnotation*>(t)) {
      return array->element_type() == lhs_array_type->element_type() &&
             GetTypeBitCount(lhs.type) + GetTypeBitCount(t) <
                 options_.max_width_aggregate_types;
    }
    return false;
  };

  XLS_ASSIGN_OR_RETURN(TypedExpr rhs, ChooseEnvValue(env, array_compatible));
  auto* rhs_array_type = dynamic_cast<ArrayTypeAnnotation*>(rhs.type);
  XLS_RET_CHECK(rhs_array_type != nullptr);
  Binop* result =
      module_->Make<Binop>(fake_span_, BinopKind::kConcat, lhs.expr, rhs.expr);
  int64 result_size =
      GetArraySize(lhs_array_type) + GetArraySize(rhs_array_type);
  Number* dim = MakeNumber(result_size);
  auto* result_type = module_->Make<ArrayTypeAnnotation>(
      fake_span_, lhs_array_type->element_type(), dim);
  return TypedExpr{result, result_type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateConcat(Env* env) {
  XLS_RET_CHECK(env != nullptr);
  if (EnvContainsArray(*env) && RandomBool()) {
    return GenerateArrayConcat(env);
  }

  int64 count = GenerateNaryOperandCount(env) + 2;
  std::vector<TypedExpr> operands;
  for (int64 i = 0; i < count; ++i) {
    XLS_ASSIGN_OR_RETURN(TypedExpr e, ChooseEnvValueUBits(env));
    operands.push_back(e);
  }

  TypedExpr e = operands[0];
  int64 result_bits = GetTypeBitCount(e.type);
  Expr* result = e.expr;
  for (int64 i = 1; i < count; ++i) {
    int64 this_bits = GetTypeBitCount(operands[i].type);
    if (result_bits + this_bits > options_.max_width_bits_types) {
      break;
    }
    result = module_->Make<Binop>(fake_span_, BinopKind::kConcat, result,
                                  operands[i].expr);
    result_bits += this_bits;
  }
  TypeAnnotation* return_type = MakeTypeAnnotation(false, result_bits);
  return TypedExpr{result, return_type};
}

BuiltinTypeAnnotation* AstGenerator::GeneratePrimitiveType() {
  int64 integral = RandRange(kConcreteBuiltinTypeLimit);
  auto type = static_cast<BuiltinType>(integral);
  return module_->Make<BuiltinTypeAnnotation>(fake_span_, type);
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateNumber(
    Env* env, absl::optional<BitsAndSignedness> bas) {
  TypeAnnotation* type;
  if (bas.has_value()) {
    type = MakeTypeAnnotation(bas->signedness, bas->bits);
  } else {
    type = GeneratePrimitiveType();
  }
  int64 bit_count = GetTypeBitCount(type);
  Bits value = ChooseBitPattern(bit_count);
  return TypedExpr{MakeNumberFromBits(value, type), type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateRetval(Env* env) {
  int64 retval_count = GenerateNaryOperandCount(env);

  std::vector<TypedExpr> env_params;
  std::vector<TypedExpr> env_non_params;
  for (auto& item : *env) {
    if (auto* name_ref = dynamic_cast<NameRef*>(item.second.expr);
        name_ref != nullptr && name_ref->DefinerIs<Param>()) {
      env_params.push_back(item.second);
    } else {
      env_non_params.push_back(item.second);
    }
  }

  XLS_RET_CHECK(!env_params.empty() || !env_non_params.empty());

  std::vector<TypedExpr> typed_exprs;
  int64 total_bit_count = 0;
  for (int64 i = 0; i < retval_count; ++i) {
    TypedExpr expr;
    float p = RandomFloat();
    if (env_non_params.empty() || (p < 0.1 && !env_params.empty())) {
      expr = RandomChoice<TypedExpr>(env_params);
    } else {
      expr = RandomChoice<TypedExpr>(env_non_params);
    }

    if (total_bit_count + GetTypeBitCount(expr.type) >
        options_.max_width_aggregate_types) {
      continue;
    }

    typed_exprs.push_back(expr);
    total_bit_count += GetTypeBitCount(expr.type);
  }

  // If only a single return value is selected, most of the time just return it
  // as a non-tuple value.
  if (RandomFloat() < 0.8 && typed_exprs.size() == 1) {
    return typed_exprs[0];
  }

  auto [exprs, types] = Unzip(typed_exprs);
  auto* tuple = module_->Make<XlsTuple>(fake_span_, exprs);
  return TypedExpr{tuple, MakeTupleType(types)};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateCountedFor(Env* env) {
  // Right now just generates the 'identity' for loop.
  // TODO(meheff): Generate more interesting loop bodies.
  TypeAnnotation* ivar_type = MakeTypeAnnotation(false, 4);
  Number* zero = MakeNumber(0, ivar_type);
  Number* trips = MakeNumber(RandRange(8), ivar_type);
  Expr* iterable = MakeRange(zero, trips);
  NameDef* x_def = MakeNameDef("x");
  NameDefTree* i_ndt = module_->Make<NameDefTree>(fake_span_, MakeNameDef("i"));
  NameDefTree* x_ndt = module_->Make<NameDefTree>(fake_span_, x_def);
  auto* name_def_tree = module_->Make<NameDefTree>(
      fake_span_, std::vector<NameDefTree*>{i_ndt, x_ndt});
  XLS_ASSIGN_OR_RETURN(TypedExpr e, ChooseEnvValueNotArray(env));
  NameRef* body = MakeNameRef(x_def);
  TupleTypeAnnotation* tree_type = MakeTupleType({ivar_type, e.type});
  For* for_ = module_->Make<For>(fake_span_, name_def_tree, tree_type, iterable,
                                 body, /*init=*/e.expr);
  return TypedExpr{for_, e.type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateTupleOrIndex(Env* env) {
  XLS_CHECK(env != nullptr);
  bool do_index = RandomBool() && EnvContainsTuple(*env);
  if (do_index) {
    TypedExpr e = ChooseEnvValueTuple(env).value();
    auto* tuple_type = dynamic_cast<TupleTypeAnnotation*>(e.type);
    int64 i = RandRange(tuple_type->size());
    Number* index_expr = MakeNumber(i);
    return TypedExpr{module_->Make<Index>(fake_span_, e.expr, index_expr),
                     tuple_type->members()[i]};
  }

  std::vector<TypedExpr> members;
  int64 total_bit_count = 0;
  for (int64 i = 0; i < GenerateNaryOperandCount(env); ++i) {
    XLS_ASSIGN_OR_RETURN(TypedExpr e, ChooseEnvValueNotArray(env));
    if (total_bit_count + GetTypeBitCount(e.type) >
        options_.max_width_aggregate_types) {
      continue;
    }
    members.push_back(e);
    total_bit_count += GetTypeBitCount(e.type);
  }

  auto [exprs, types] = Unzip(members);
  return TypedExpr{module_->Make<XlsTuple>(fake_span_, exprs),
                   MakeTupleType(types)};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateMap(int64 call_depth,
                                                    Env* env) {
  std::string map_fn_name = GenSym();

  // GenerateFunction(), in turn, can call GenerateMap(), so we need some way of
  // bounding the recursion. To limit explosion, return an EmptyEnvError (which
  // bails on creation of the map but continues with fuzzing) with exponentially
  // increasing probability depending on the call depth.
  if (RandomFloat() > pow(10.0, -call_depth)) {
    return absl::FailedPreconditionError("EmptyEnvError: Call depth too deep.");
  }

  XLS_ASSIGN_OR_RETURN(
      Function * map_fn,
      GenerateFunction(map_fn_name, call_depth + 1, /*param_count=*/1));
  functions_.push_back(map_fn);

  TypeAnnotation* map_arg_type = map_fn->params()[0]->type();
  XLS_RET_CHECK(IsBits(map_arg_type)) << map_arg_type->ToString();
  bool map_arg_signedness = !IsUBits(map_arg_type);
  int64 map_arg_bits = GetTypeBitCount(map_arg_type);
  int64 max_array_size = options_.max_width_aggregate_types /
                         GetTypeBitCount(map_fn->return_type());
  int64 array_size = RandRange(1, std::max(int64{2}, max_array_size));
  TypeAnnotation* return_type =
      MakeArrayType(map_fn->return_type(), array_size);

  // It's unlikely we'll have the exact array we need, so we'll just create one.
  // TODO(b/144724970): Consider creating arrays from values in the env.
  std::vector<Expr*> numbers;
  for (int64 i = 0; i < array_size; ++i) {
    XLS_ASSIGN_OR_RETURN(
        TypedExpr number,
        GenerateNumber(env,
                       BitsAndSignedness{map_arg_bits, map_arg_signedness}));
    numbers.push_back(number.expr);
  }
  ConstantArray* args = module_->Make<ConstantArray>(
      fake_span_, std::move(numbers), /*has_ellipsis=*/false);
  NameRef* fn_ref = MakeNameRef(MakeNameDef(map_fn_name));
  auto* invocation = module_->Make<Invocation>(
      fake_span_, MakeBuiltinNameRef("map"), std::vector<Expr*>{args, fn_ref});
  return TypedExpr{invocation, return_type};
}

absl::StatusOr<TypeAnnotation*> AstGenerator::GenerateBitsType() {
  if (options_.max_width_bits_types <= 64 || RandRange(1, 10) != 1) {
    return GeneratePrimitiveType();
  }
  // Generate a type wider than 64-bits. With smallish probability choose a
  // *really* wide type if the max_width_bits_types supports it, otherwise
  // choose a width up to 128 bits.
  int64 max_width = options_.max_width_bits_types;
  if (max_width > 128 && RandRange(1, 10) > 1) {
    max_width = 128;
  }
  bool sign = RandomBool();
  return MakeTypeAnnotation(sign, 64 + RandRange(1, max_width - 64));
}

absl::optional<TypedExpr> AstGenerator::ChooseEnvValueOptional(
    Env* env, std::function<bool(const TypedExpr&)> take) {
  if (take == nullptr) {
    // Fast path if there's no take function, we don't need to inspect/copy
    // things.
    int64 index = RandRange(env->size());
    auto it = env->begin();
    std::advance(it, index);
    return it->second;
  }

  std::vector<TypedExpr*> choices;
  for (auto& item : *env) {
    if (take(item.second)) {
      choices.push_back(&item.second);
    }
  }
  if (choices.empty()) {
    return absl::nullopt;
  }
  int64 index = RandRange(choices.size());
  return *choices[index];
}

absl::StatusOr<TypedExpr> AstGenerator::ChooseEnvValue(
    Env* env, std::function<bool(const TypedExpr&)> take) {
  auto result = ChooseEnvValueOptional(env, take);
  if (!result.has_value()) {
    return absl::FailedPreconditionError(
        "EmptyEnvError: No elements in the environment satisfy the predicate.");
  }
  return result.value();
}

absl::StatusOr<std::pair<TypedExpr, TypedExpr>>
AstGenerator::ChooseEnvValueBitsPair(Env* env,
                                     absl::optional<int64> bit_count) {
  XLS_ASSIGN_OR_RETURN(TypedExpr lhs, ChooseEnvValueBits(env, bit_count));
  XLS_ASSIGN_OR_RETURN(TypedExpr rhs, ChooseEnvValueBits(env, bit_count));
  if (lhs.type == rhs.type) {
    return std::pair{lhs, rhs};
  }
  if (RandomBool()) {
    rhs.expr = module_->Make<Cast>(fake_span_, rhs.expr, lhs.type);
    rhs.type = lhs.type;
  } else {
    lhs.expr = module_->Make<Cast>(fake_span_, lhs.expr, rhs.type);
    lhs.type = rhs.type;
  }
  return std::pair{lhs, rhs};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateUnop(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueBits(env));
  UnopKind op = RandomChoice<UnopKind>({UnopKind::kInvert, UnopKind::kNegate});
  return TypedExpr{module_->Make<Unop>(fake_span_, op, arg.expr), arg.type};
}

// Returns (start, width), resolving indices via DSLX bit slice semantics.
static std::pair<int64, int64> ResolveBitSliceIndices(
    int64 bit_count, absl::optional<int64> start, absl::optional<int64> limit) {
  if (!start.has_value()) {
    start = 0;
  }
  if (!limit.has_value()) {
    limit = bit_count;
  }
  if (*start < 0) {
    start = *start + bit_count;
  }
  if (*limit < 0) {
    limit = *limit + bit_count;
  }
  limit = std::min(std::max(*limit, int64{0}), bit_count);
  start = std::min(std::max(*start, int64{0}), *limit);
  XLS_CHECK_GE(*start, 0);
  XLS_CHECK_GE(*limit, *start);
  return {*start, *limit - *start};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateBitSlice(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueBits(env));
  int64 bit_count = GetTypeBitCount(arg.type);
  enum class SliceType {
    kBitSlice,
    kWidthSlice,
    kDynamicSlice,
  };
  SliceType which = RandomChoice<SliceType>(
      {SliceType::kBitSlice, SliceType::kWidthSlice, SliceType::kDynamicSlice});
  absl::optional<int64> start;
  absl::optional<int64> limit;
  int64 width = -1;
  while (true) {
    int64 start_low = (which == SliceType::kWidthSlice) ? 0 : -bit_count - 1;
    bool should_have_start = RandomBool();
    start = should_have_start
                ? absl::make_optional(RandRange(start_low, bit_count + 1))
                : absl::nullopt;
    bool should_have_limit = RandomBool();
    limit = should_have_limit
                ? absl::make_optional(RandRange(-bit_count - 1, bit_count + 1))
                : absl::nullopt;
    width = ResolveBitSliceIndices(bit_count, start, limit).second;
    if (width > 0) {  // Make sure we produce non-zero-width things.
      break;
    }
  }
  XLS_RET_CHECK_GT(width, 0);

  IndexRhs rhs;
  switch (which) {
    case SliceType::kBitSlice: {
      Number* start_num = start.has_value() ? MakeNumber(*start) : nullptr;
      Number* limit_num = limit.has_value() ? MakeNumber(*limit) : nullptr;
      rhs = module_->Make<Slice>(fake_span_, start_num, limit_num);
      break;
    }
    case SliceType::kWidthSlice: {
      int64 start_int = start.has_value() ? *start : 0;
      rhs = module_->Make<WidthSlice>(fake_span_, MakeNumber(start_int),
                                      MakeTypeAnnotation(false, width));
      break;
    }
    case SliceType::kDynamicSlice: {
      XLS_ASSIGN_OR_RETURN(TypedExpr start, ChooseEnvValueUBits(env));
      rhs = module_->Make<WidthSlice>(fake_span_, start.expr,
                                      MakeTypeAnnotation(false, width));
      break;
    }
  }
  TypeAnnotation* type = MakeTypeAnnotation(false, width);
  auto* expr = module_->Make<Index>(fake_span_, arg.expr, rhs);
  return TypedExpr{expr, type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateBitwiseReduction(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueUBits(env));
  absl::string_view op = RandomChoice<absl::string_view>(
      {"and_reduce", "or_reduce", "xor_reduce"});
  NameRef* callee = MakeBuiltinNameRef(std::string(op));
  TypeAnnotation* type = MakeTypeAnnotation(false, 1);
  return TypedExpr{module_->Make<Invocation>(fake_span_, callee,
                                             std::vector<Expr*>{arg.expr}),
                   type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateCastBitsToArray(Env* env) {
  // Get a random bits-typed element from the environment.
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueUBits(env));

  // Next, find factors of the bit count and select one pair.
  int64 bit_count = GetTypeBitCount(arg.type);
  std::vector<std::pair<int64, int64>> factors;
  for (int64 i = 1; i < bit_count + 1; ++i) {
    if (bit_count % i == 0) {
      factors.push_back({i, bit_count / i});
    }
  }

  auto [element_size, array_size] = RandomChoice(absl::MakeConstSpan(factors));
  TypeAnnotation* element_type = MakeTypeAnnotation(false, element_size);
  ArrayTypeAnnotation* outer_array_type =
      MakeArrayType(element_type, array_size);
  Cast* expr = module_->Make<Cast>(fake_span_, arg.expr, outer_array_type);
  return TypedExpr{expr, outer_array_type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateBitSliceUpdate(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueUBits(env));
  XLS_ASSIGN_OR_RETURN(TypedExpr start, ChooseEnvValueUBits(env));
  XLS_ASSIGN_OR_RETURN(TypedExpr update_value, ChooseEnvValueUBits(env));

  auto* invocation = module_->Make<Invocation>(
      fake_span_, MakeBuiltinNameRef("bit_slice_update"),
      std::vector<Expr*>{arg.expr, start.expr, update_value.expr});
  return TypedExpr{invocation, arg.type};
}

namespace {

enum OpChoice {
  kBinop,
  kBitSlice,
  kBitSliceUpdate,
  kBitwiseReduction,
  kCastToBitsArray,
  kCompareOp,
  kConcat,
  kCountedFor,
  kLogical,
  kMap,
  kNumber,
  kOneHotSelectBuiltin,
  kShiftOp,
  kTupleOrIndex,
  kUnop,
  kUnopBuiltin,

  // Sentinel denoting last element of enum.
  kEndSentinel
};

// Returns the relative probability of the given op being generated.
int OpProbability(OpChoice op) {
  switch (op) {
    case kBinop:
      return 10;
    case kBitSlice:
      return 10;
    case kBitSliceUpdate:
      return 2;
    case kBitwiseReduction:
      return 3;
    case kCastToBitsArray:
      return 1;
    case kCompareOp:
      return 3;
    case kConcat:
      return 5;
    case kCountedFor:
      return 1;
    case kLogical:
      return 3;
    case kMap:
      return 1;
    case kNumber:
      return 3;
    case kOneHotSelectBuiltin:
      return 1;
    case kShiftOp:
      return 3;
    case kTupleOrIndex:
      return 3;
    case kUnop:
      return 10;
    case kUnopBuiltin:
      return 5;
    case kEndSentinel:
      return 0;
  }
}

std::discrete_distribution<int>& GetOpDistribution() {
  static std::discrete_distribution<int> dist = []() {
    std::vector<int> tmp;
    tmp.reserve(int{kEndSentinel});
    for (int i = 0; i < int{kEndSentinel}; ++i) {
      tmp.push_back(OpProbability(static_cast<OpChoice>(i)));
    }
    return std::discrete_distribution<int>(tmp.begin(), tmp.end());
  }();
  return dist;
}

}  // namespace

absl::StatusOr<TypedExpr> AstGenerator::GenerateExpr(int64 expr_size,
                                                     int64 call_depth,
                                                     Env* env) {
  if (!ShouldNest(expr_size, call_depth)) {
    // Should not nest any more, select return values.
    return GenerateRetval(env);
  }

  TypedExpr rhs;
  while (true) {
    absl::StatusOr<TypedExpr> generated;

    // With particularly low probability we generate a map -- if maps recurse
    // with equal probability then the output will grow exponentially with
    // level, so we need to scale inversely.
    int choice = GetOpDistribution()(rng_);
    switch (static_cast<OpChoice>(choice)) {
      case kCountedFor:
        generated = GenerateCountedFor(env);
        break;
      case kTupleOrIndex:
        generated = GenerateTupleOrIndex(env);
        break;
      case kConcat:
        generated = GenerateConcat(env);
        break;
      case kBinop:
        generated = GenerateBinop(env);
        break;
      case kCompareOp:
        generated = GenerateCompare(env);
        break;
      case kShiftOp:
        generated = GenerateShift(env);
        break;
      case kLogical:
        generated = GenerateLogicalOp(env);
        break;
      case kMap:
        generated = GenerateMap(call_depth, env);
        break;
      case kUnop:
        generated = GenerateUnop(env);
        break;
      case kUnopBuiltin:
        generated = GenerateUnopBuiltin(env);
        break;
      case kOneHotSelectBuiltin:
        generated = GenerateOneHotSelectBuiltin(env);
        break;
      case kNumber:
        generated = GenerateNumber(env);
        break;
      case kBitwiseReduction:
        generated = GenerateBitwiseReduction(env);
        break;
      case kBitSlice:
        generated = GenerateBitSlice(env);
        break;
      case kCastToBitsArray:
        generated = GenerateCastBitsToArray(env);
        break;
      case kBitSliceUpdate:
        generated = GenerateBitSliceUpdate(env);
        break;
      case kEndSentinel:
        XLS_LOG(FATAL) << "Should not have selected end sentinel";
    }

    if (generated.ok()) {
      rhs = generated.value();
      break;
    }

    // We expect the Generate* routines might try to sample things that don't
    // exist in the envs, so we keep going if we see one of those errors.
    if (absl::StartsWith(generated.status().message(), "EmptyEnvError")) {
      continue;
    }

    // Any other error is unexpected, though.
    return generated.status();
  }
  std::string identifier = GenSym();

  // What we place into the environment is a NameRef that refers to this RHS
  // value -- this way rules will pick up the expression names instead of
  // picking up the expression ASTs directly (which would cause duplication).
  auto* name_def =
      module_->Make<NameDef>(fake_span_, identifier, /*definer=*/nullptr);
  auto* name_ref = MakeNameRef(name_def);
  (*env)[identifier] = TypedExpr{name_ref, rhs.type};

  XLS_ASSIGN_OR_RETURN(TypedExpr body,
                       GenerateExpr(expr_size + 1, call_depth, env));
  auto* ndt = module_->Make<NameDefTree>(fake_span_, name_def);
  auto* let = module_->Make<Let>(fake_span_, /*name_def_tree=*/ndt,
                                 /*type=*/rhs.type, /*rhs=*/rhs.expr,
                                 /*body=*/body.expr, /*const_def=*/nullptr);
  return TypedExpr{let, body.type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateUnopBuiltin(Env* env) {
  XLS_ASSIGN_OR_RETURN(TypedExpr arg, ChooseEnvValueUBits(env));
  enum UnopBuiltin {
    kClz,
    kCtz,
    kRev,
    kOneHot,
  };
  auto to_string = [](UnopBuiltin kind) -> std::string {
    switch (kind) {
      case kClz:
        return "clz";
      case kCtz:
        return "ctz";
      case kRev:
        return "rev";
      case kOneHot:
        return "one_hot";
    }
    XLS_LOG(FATAL) << "Invalid kind: " << kind;
  };

  std::vector<UnopBuiltin> choices = {kClz, kCtz, kRev};
  // Since one_hot adds a bit, only use it when we have head room beneath
  // max_width_bits_types to add another bit.
  if (GetTypeBitCount(arg.type) < options_.max_width_bits_types) {
    choices.push_back(kOneHot);
  }

  Invocation* invocation = nullptr;
  auto which = RandomChoice<UnopBuiltin>(choices);
  NameRef* name_ref = MakeBuiltinNameRef(to_string(which));
  int64 result_bits = -1;
  switch (which) {
    case kClz:
    case kCtz:
    case kRev:
      invocation = module_->Make<Invocation>(fake_span_, name_ref,
                                             std::vector<Expr*>{arg.expr});
      result_bits = GetTypeBitCount(arg.type);
      break;
    case kOneHot: {
      bool lsb_or_msb = RandomBool();
      invocation = module_->Make<Invocation>(
          fake_span_, name_ref,
          std::vector<Expr*>{arg.expr, MakeBool(lsb_or_msb)});
      result_bits = GetTypeBitCount(arg.type) + 1;
      break;
    }
  }

  TypeAnnotation* result_type = MakeTypeAnnotation(false, result_bits);
  return TypedExpr{invocation, result_type};
}

absl::StatusOr<TypedExpr> AstGenerator::GenerateBody(
    int64 call_depth, absl::Span<Param* const> params) {
  Env env;
  for (Param* param : params) {
    env[param->identifier()] =
        TypedExpr{MakeNameRef(param->name_def()), param->type()};
  }
  return GenerateExpr(/*expr_size=*/0, call_depth, &env);
}

absl::StatusOr<Function*> AstGenerator::GenerateFunction(
    std::string name, int64 call_depth, absl::optional<int64> param_count) {
  if (!param_count.has_value()) {
    param_count = static_cast<int64>(std::ceil(RandomWeibull(1.0, 1.15) * 4));
  }
  XLS_ASSIGN_OR_RETURN(std::vector<Param*> params,
                       GenerateParams(*param_count));
  XLS_ASSIGN_OR_RETURN(TypedExpr retval, GenerateBody(call_depth, params));
  NameDef* name_def =
      module_->Make<NameDef>(fake_span_, name, /*definer=*/nullptr);
  Function* f = module_->Make<Function>(
      fake_span_, name_def,
      /*parametric_bindings=*/std::vector<ParametricBinding*>{},
      /*params=*/params,
      /*return_type=*/retval.type, /*body=*/retval.expr, /*is_public=*/false);
  name_def->set_definer(f);
  return f;
}

absl::StatusOr<std::pair<Function*, std::unique_ptr<Module>>>
AstGenerator::GenerateFunctionInModule(std::string fn_name,
                                       std::string module_name) {
  module_ = absl::make_unique<Module>(module_name);
  XLS_ASSIGN_OR_RETURN(Function * f, GenerateFunction(fn_name));
  for (auto& item : constants_) {
    module_->AddTop(item.second);
  }
  for (auto& item : type_defs_) {
    module_->AddTop(item);
  }
  for (auto& item : functions_) {
    module_->AddTop(item);
  }
  module_->AddTop(f);
  return std::make_pair(f, std::move(module_));
}

AstGenerator::AstGenerator(AstGeneratorOptions options, std::mt19937* rng)
    : rng_(*XLS_DIE_IF_NULL(rng)),
      options_(options),
      fake_pos_("<fake>", 0, 0),
      fake_span_(fake_pos_, fake_pos_),
      binops_(options.binop_allowlist.has_value()
                  ? options.binop_allowlist.value()
                  : GetBinopSameTypeKinds()) {
  binops_.erase(BinopKind::kDiv);
}

}  // namespace xls::dslx
