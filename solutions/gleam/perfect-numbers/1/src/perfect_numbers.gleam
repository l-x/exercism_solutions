import gleam/bool
import gleam/int
import gleam/io
import gleam/order.{Eq, Gt, Lt}

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

fn aliquot_sum(n: Int, divisor: Int) -> Int {
  case divisor {
    d if d > n / 2 -> 1
    _ ->
      case n % divisor {
        0 -> divisor + aliquot_sum(n, divisor + 1)
        _ -> aliquot_sum(n, divisor + 1)
      }
  }
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  use <- bool.guard(when: number < 1, return: Error(NonPositiveInt))
  use <- bool.guard(when: number == 1, return: Ok(Deficient))

  case number |> int.compare(aliquot_sum(number, 2)) {
    Eq -> Ok(Perfect)
    Lt -> Ok(Abundant)
    Gt -> Ok(Deficient)
  }
}

pub fn main() {
  aliquot_sum(24, 2)
  |> io.debug
}
