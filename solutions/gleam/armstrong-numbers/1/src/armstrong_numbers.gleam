import gleam/int
import gleam/list
import gleam/result

pub fn is_armstrong_number(number: Int) -> Bool {
  number
  == number
  |> get_the_digits
  |> do_the_math
  |> get_the_number
}

fn get_the_digits(number: Int) -> List(Int) {
  number
  |> int.digits(10)
  |> result.unwrap([])
}

fn get_the_number(digits: List(Int)) -> Int {
  digits
  |> int.sum
}

fn int_pow(n: Int, x: Int) -> Int {
  n
  |> list.repeat(x)
  |> int.product
}

fn do_the_math(digits: List(Int)) -> List(Int) {
  digits
  |> list.map(int_pow(_, list.length(digits)))
}
