pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna |> do_to_rna("")
}

fn do_to_rna(dna: String, acc: String) -> Result(String, Nil) {
  case dna {
    "" -> Ok(acc)
    "G" <> rest -> rest |> do_to_rna(acc <> "C")
    "C" <> rest -> rest |> do_to_rna(acc <> "G")
    "T" <> rest -> rest |> do_to_rna(acc <> "A")
    "A" <> rest -> rest |> do_to_rna(acc <> "U")
    _ -> Error(Nil)
  }
}
