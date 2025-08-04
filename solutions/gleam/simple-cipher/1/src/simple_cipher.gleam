import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn encode(plaintext plaintext: String, key key: String) -> String {
  plaintext
  |> string.to_utf_codepoints
  |> list.index_map(fn(c, o) { c |> shift(key_offset(key, o)) })
  |> string.from_utf_codepoints
}

pub fn decode(ciphertext ciphertext: String, key key: String) -> String {
  ciphertext
  |> string.to_utf_codepoints
  |> list.index_map(fn(c, o) { c |> shift(key_offset(key, o) * -1) })
  |> string.from_utf_codepoints
}

pub fn generate_key() -> String {
  list.repeat(0, 64)
  |> list.map(fn(_) {
    let assert Ok(c) = string.utf_codepoint(int.random(26) + 97)

    c
  })
  |> string.from_utf_codepoints
}

fn shift(char: UtfCodepoint, offset: Int) -> UtfCodepoint {
  let x = case string.utf_codepoint_to_int(char) + offset {
    x if x < 97 -> x + 26
    x if x > 122 -> x - 26
    x -> x
  }

  let assert Ok(r) = string.utf_codepoint(x)

  r
}

fn key_offset(in key: String, at index: Int) -> Int {
  let char = string.slice(key, index % string.length(key), 1)
  let assert [i] = string.to_utf_codepoints(char)

  string.utf_codepoint_to_int(i) - 97
}

pub fn main() {
  key_offset("abc", 1) |> io.debug
}
