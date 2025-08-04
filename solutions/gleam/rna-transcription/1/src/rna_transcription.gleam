import gleam/io
import gleam/iterator
import gleam/list
import gleam/result
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.to_graphemes
  |> list.map(translate_nucleotide)
  |> result.all
  |> result.map(string.concat)
}

fn translate_nucleotide(s: String) -> Result(String, Nil) {
  case s {
    "G" -> Ok("C")
    "C" -> Ok("G")
    "T" -> Ok("A")
    "A" -> Ok("U")
    _ -> Error(Nil)
  }
}

pub fn main() {
  todo
}
