import gleam/dict.{values}
import gleam/function.{identity}
import gleam/list.{filter, group, is_empty, length, map}
import gleam/string.{lowercase, to_utf_codepoints, utf_codepoint_to_int}

pub fn is_isogram(phrase phrase: String) -> Bool {
  phrase
  |> lowercase
  |> to_utf_codepoints
  |> map(utf_codepoint_to_int)
  |> filter(fn(i) { i >= 97 && i <= 122 })
  |> group(identity)
  |> values
  |> filter(fn(i) { length(i) > 1 })
  |> is_empty
}
