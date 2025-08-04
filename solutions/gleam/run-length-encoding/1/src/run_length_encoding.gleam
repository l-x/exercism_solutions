import gleam/int
import gleam/list
import gleam/option.{type Option}
import gleam/regex
import gleam/result
import gleam/string

pub fn encode(plaintext: String) -> String {
  let assert Ok(pattern) = regex.from_string("(.)\\1*")

  pattern
  |> regex.scan(plaintext)
  |> list.map(fn(m) { encode_one(m.content) })
  |> string.concat
}

fn encode_one(seq: String) -> String {
  case string.length(seq) {
    1 -> ""
    s -> int.to_string(s)
  }
  <> string.first(seq)
  |> result.unwrap("")
}

pub fn decode(ciphertext: String) -> String {
  let assert Ok(pattern) = regex.from_string("(\\d*)(.)")

  pattern
  |> regex.scan(ciphertext)
  |> list.map(fn(m) { decode_one(m.submatches) })
  |> string.concat
}

fn decode_one(pair: List(Option(String))) -> String {
  let assert [m, l] = pair

  string.repeat(
    option.unwrap(l, ""),
    option.unwrap(m, "1")
      |> int.base_parse(10)
      |> result.unwrap(0),
  )
}
