import gleam/string

pub fn is_paired(value: String) -> Bool {
  value
  |> string.to_graphemes
  |> check_brackets([])
}

fn closing_bracket(for value: String) -> String {
  case value {
    "(" -> ")"
    "[" -> "]"
    "{" -> "}"
    _ -> panic
  }
}

fn check_brackets(values: List(String), stack: List(String)) -> Bool {
  case values {
    // no more values to check: stack must be empty
    [] -> stack == []
    // opening bracket: push required closing bracket on the stack
    [x, ..xs] if x == "(" || x == "{" || x == "[" ->
      check_brackets(xs, [closing_bracket(for: x), ..stack])

    // closing bracket: pop required closing bracket from stack and compare
    [x, ..xs] if x == ")" || x == "}" || x == "]" ->
      case stack {
        [y, ..ys] if x == y -> check_brackets(xs, ys)
        _ -> False
      }
    // non-bracket: ignore
    [_, ..xs] -> check_brackets(xs, stack)
  }
}
