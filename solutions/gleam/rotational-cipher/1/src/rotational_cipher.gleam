import gleam/list
import gleam/result
import gleam/string

pub fn rotate(shift_key: Int, text: String) -> String {
  text
  |> string.to_utf_codepoints
  |> list.map(rotate_codepoint(_, shift_key))
  |> string.from_utf_codepoints
}

fn shift_char(base: Int, n: Int) -> Int {
  base + { n - base } % 26
}

fn rotate_codepoint(codepoint: UtfCodepoint, offset: Int) -> UtfCodepoint {
  case codepoint |> string.utf_codepoint_to_int {
    c if c >= 97 && c <= 97 + 26 ->
      string.utf_codepoint(shift_char(97, c + offset))
      |> result.unwrap(codepoint)
    c if c >= 65 && c <= 65 + 26 ->
      string.utf_codepoint(shift_char(65, c + offset))
      |> result.unwrap(codepoint)
    _ -> codepoint
  }
}
