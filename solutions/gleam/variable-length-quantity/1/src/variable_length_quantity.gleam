import gleam/int
import gleam/list

pub type Error {
  IncompleteSequence
}

pub fn encode(integers: List(Int)) -> BitArray {
  integers |> list.fold(from: <<>>, with: do_encode)
}

fn do_encode(acc: BitArray, integer: Int) -> BitArray {
  case integer {
    0 -> <<acc:bits, 0>>
    _ -> <<acc:bits, encode_int(integer, 0, <<>>):bits>>
  }
}

fn encode_int(integer: Int, sign_bit: Int, acc: BitArray) -> BitArray {
  case integer {
    0 -> acc
    _ ->
      integer
      |> int.bitwise_shift_right(7)
      |> encode_int(1, <<sign_bit:1, integer:7, acc:bits>>)
  }
}

pub fn decode(string: BitArray) -> Result(List(Int), Error) {
  do_decode(string, [], 0)
}

fn do_decode(
  string: BitArray,
  acc: List(Int),
  acc0: Int,
) -> Result(List(Int), Error) {
  case string {
    <<>> -> Ok(acc |> list.reverse)
    <<1:1, _:7>> -> Error(IncompleteSequence)
    <<1:1, x:7, xs:bits>> -> do_decode(xs, acc, acc0 * 128 + x)
    <<0:1, x:7, xs:bits>> -> do_decode(xs, [acc0 * 128 + x, ..acc], 0)
    _ -> panic as "invalid bit array"
  }
}
