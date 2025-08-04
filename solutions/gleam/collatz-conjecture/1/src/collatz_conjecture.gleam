import gleam/bool

pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  do_steps(number, 0)
}

fn do_steps(number: Int, acc: Int) -> Result(Int, Error) {
  use <- bool.guard(when: number < 1, return: Error(NonPositiveNumber))

  case number {
    1 -> Ok(acc)
    n ->
      case n % 2 {
        0 -> do_steps(n / 2, acc + 1)
        _ -> do_steps(n * 3 + 1, acc + 1)
      }
  }
}
