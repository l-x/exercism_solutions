import gleam/dict.{type Dict}
import gleam/list
import gleam/string

const alphabet = "abcdefghijklmnopqrstuvwxyz"

const numbers = "0123456789"

fn translate(char: String, tbl: Dict(String, String)) -> String {
  case dict.get(tbl, char) {
    Ok(x) -> x
    _ ->
      case string.contains(numbers, char) {
        True -> char
        False -> ""
      }
  }
}

pub fn encode(phrase: String) -> String {
  let tbl = {
    let chars = string.split(alphabet, "")
    list.zip(chars, list.reverse(chars)) |> dict.from_list
  }

  phrase
  |> string.lowercase
  |> string.to_graphemes
  |> list.map(with: fn(char) { translate(char, tbl) })
  |> list.filter(keeping: fn(char) { !string.is_empty(char) })
  |> list.sized_chunk(into: 5)
  |> list.map(with: string.concat)
  |> string.join(with: " ")
}

pub fn decode(phrase: String) -> String {
  let tbl = {
    let chars = string.split(alphabet, "")
    list.zip(list.reverse(chars), chars) |> dict.from_list
  }

  phrase
  |> string.lowercase
  |> string.to_graphemes
  |> list.map(with: fn(char) { translate(char, tbl) })
  |> list.filter(keeping: fn(char) { !string.is_empty(char) })
  |> string.concat
}
