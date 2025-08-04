import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  list.try_fold(
    string.to_graphemes(dna),
    dict.from_list([#("A", 0), #("C", 0), #("G", 0), #("T", 0)]),
    fn(counts, nucleotide) {
      case dict.get(counts, nucleotide) {
        Error(_) -> Error(Nil)
        Ok(n) -> Ok(dict.insert(counts, nucleotide, n + 1))
      }
    },
  )
}
