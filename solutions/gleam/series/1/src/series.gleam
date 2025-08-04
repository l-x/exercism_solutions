import gleam/bool
import gleam/list
import gleam/string

fn window(input: String, size: Int, acc: List(String)) -> List(String) {
  let slice = input |> string.slice(0, size)

  case string.length(slice) == size {
    True -> window(input |> string.drop_left(1), size, [slice, ..acc])
    False -> list.reverse(acc)
  }
}

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  use <- bool.guard(when: input == "", return: Error(EmptySeries))
  use <- bool.guard(when: size == 0, return: Error(SliceLengthZero))
  use <- bool.guard(when: size < 0, return: Error(SliceLengthNegative))
  use <- bool.guard(
    when: string.length(input) < size,
    return: Error(SliceLengthTooLarge),
  )

  Ok(window(input, size, []))
}

pub type Error {
  EmptySeries
  SliceLengthZero
  SliceLengthNegative
  SliceLengthTooLarge
}
