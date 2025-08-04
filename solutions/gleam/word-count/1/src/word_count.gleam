import gleam/dict.{type Dict}
import gleam/list
import gleam/regex
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(pattern) = regex.from_string("(\\w+('\\w)?)+")

  pattern
  |> regex.scan(input)
  |> list.map(fn(m) { string.lowercase(m.content) })
  |> list.group(fn(w) { w })
  |> dict.map_values(fn(_, v) { v |> list.length })
}
