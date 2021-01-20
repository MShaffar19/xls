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

#include "xls/dslx/command_line_utils.h"

#include "absl/strings/str_split.h"
#include "absl/types/span.h"
#include "xls/common/logging/logging.h"
#include "xls/common/status/ret_check.h"
#include "xls/dslx/cpp_bindings.h"
#include "xls/dslx/cpp_pos.h"
#include "xls/dslx/error_printer.h"

namespace xls::dslx {

bool TryPrintError(const absl::Status& status) {
  if (status.ok()) {
    return false;
  }
  absl::StatusOr<std::pair<Span, std::string>> data_or =
      ParseErrorGetData(status);
  if (!data_or.ok()) {
    XLS_LOG(ERROR)
        << "Could not extract a textual position from error message: " << status
        << ": " << data_or.status();
    return false;
  }
  auto& data = data_or.value();
  absl::Status print_status =
      PrintPositionalError(data.first, data.second, std::cerr);
  if (!print_status.ok()) {
    XLS_LOG(ERROR) << "Could not print positional error: " << print_status;
  }
  return print_status.ok();
}

absl::StatusOr<std::string> PathToName(absl::string_view path) {
  std::vector<absl::string_view> pieces = absl::StrSplit(path, '/');
  if (pieces.empty()) {
    return absl::InvalidArgumentError(
        absl::StrFormat("Could not determine module name from path: %s", path));
  }
  absl::string_view last = pieces.back();
  std::vector<absl::string_view> dot_pieces = absl::StrSplit(last, '.');
  XLS_RET_CHECK(!dot_pieces.empty());
  return std::string(dot_pieces[0]);
}

}  // namespace xls::dslx
