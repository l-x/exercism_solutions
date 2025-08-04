import gleam/int.{modulo}
import gleam/list.{filter, find, map, range}
import gleam/option.{type Option, None, Some}
import gleam/pair

type Number =
  #(Int, Bool)

fn new(value: Int) -> Number {
  pair.new(value, False)
}

fn value(of number: Number) -> Int {
  pair.first(number)
}

fn unmarked(number: Number) -> Bool {
  pair.second(number) == False
}

fn is_greater_than(number: Number, than: Number) -> Bool {
  value(number) > value(than)
}

fn is_multiple(number: Number, of: Number) -> Bool {
  let number = value(number)
  let of = value(of)

  case modulo(number, of) {
    Ok(0) -> number != of
    _ -> False
  }
}

fn mark(number: Number) -> Number {
  pair.new(value(number), True)
}

fn prepare_numbers(upper_bound: Int) -> List(Number) {
  case upper_bound >= 2 {
    True -> range(2, upper_bound) |> map(new)
    False -> []
  }
}

fn mark_multiple_of(of: Number) -> fn(Number) -> Number {
  fn(number) {
    case number |> is_multiple(of) {
      True -> mark(number)
      False -> number
    }
  }
}

fn mark_multiples_of(numbers: List(Number), number: Number) -> List(Number) {
  numbers |> map(mark_multiple_of(number))
}

fn next_unmarked(numbers: List(Number), last: Number) -> Option(Number) {
  numbers
  |> find(fn(x) { is_greater_than(x, last) && unmarked(x) })
  |> option.from_result
}

fn sieve(numbers: List(Number), last: Number) -> List(Number) {
  case next_unmarked(numbers, last) {
    Some(n) ->
      numbers
      |> mark_multiples_of(n)
      |> sieve(n)
    None -> numbers
  }
}

pub fn primes_up_to(upper_bound: Int) -> List(Int) {
  prepare_numbers(upper_bound)
  |> sieve(new(0))
  |> filter(unmarked)
  |> map(value)
}
