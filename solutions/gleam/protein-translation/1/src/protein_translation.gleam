import gleam/iterator.{type Iterator}
import gleam/list
import gleam/result
import gleam/string

fn split_codons(rna: String) -> Iterator(String) {
  let yield = fn(rna) {
    case rna |> string.slice(0, 3) {
      "" -> iterator.Done
      codon -> iterator.Next(codon, rna |> string.drop_left(3))
    }
  }

  rna |> iterator.unfold(with: yield)
}

fn translate_codon(codon: String) -> Result(String, Nil) {
  [
    #(["AUG"], "Methionine"),
    #(["UUU", "UUC"], "Phenylalanine"),
    #(["UUA", "UUG"], "Leucine"),
    #(["UCU", "UCC", "UCA", "UCG"], "Serine"),
    #(["UAU", "UAC"], "Tyrosine"),
    #(["UGU", "UGC"], "Cysteine"),
    #(["UGG"], "Tryptophan"),
    #(["UAA", "UAG", "UGA"], "STOP"),
  ]
  |> list.find(fn(c) { list.contains(c.0, codon) })
  |> result.map(fn(c) { c.1 })
}

fn non_stop_codon(r: Result(String, Nil)) -> Bool {
  result.unwrap(r, "") != "STOP"
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  rna
  |> split_codons
  |> iterator.map(translate_codon)
  |> iterator.take_while(non_stop_codon)
  |> iterator.to_list
  |> result.all
}
