import gleam/dict.{type Dict}
import gleam/function
import gleam/list
import gleam/regex
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(pattern) = regex.from_string("(?>\\w+(?>'\\w)?)+")

  pattern
  |> regex.scan(input)
  |> list.map(fn(m) { m.content |> string.lowercase })
  |> list.group(function.identity)
  |> dict.map_values(fn(_, v) { v |> list.length })
}
