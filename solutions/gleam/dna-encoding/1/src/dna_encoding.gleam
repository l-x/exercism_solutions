import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  case dna {
    [] -> <<>>
    [x, ..xs] -> <<encode_nucleotide(x):2, encode(xs):bits>>
  }
}

fn do_decode(dna: BitArray) -> List(Result(Nucleotide, Nil)) {
  case dna {
    <<x:2>> -> [decode_nucleotide(x)]
    <<x:2, xs:bits>> -> [decode_nucleotide(x), ..do_decode(xs)]
    _ -> [Error(Nil)]
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  dna
  |> do_decode
  |> result.all
}
