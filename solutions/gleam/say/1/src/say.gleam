import gleam/int.{digits}
import gleam/list.{index_map, map, reverse, sized_chunk}
import gleam/result.{then, unwrap}
import gleam/string.{join, trim}

pub type Error {
  OutOfRange
}

fn concat(s1: String, s2: String, sep: String) -> String {
  case s2 {
    "" -> s1
    _ -> s1 <> sep <> s2
  }
}

fn say_digit(digit: Int) -> String {
  case digit {
    0 -> ""
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    _ -> panic
  }
}

fn say_hundrets(hundrets: Int, tens: Int, ones: Int) -> String {
  case hundrets {
    0 -> ""
    d -> say_digit(d) <> " hundred"
  }
  |> concat(say_tens(tens, ones), " ")
}

fn say_tens(tens: Int, ones: Int) -> String {
  case tens, ones {
    0, _ -> say_digit(ones)
    1, _ ->
      case ones {
        0 -> "ten"
        1 -> "eleven"
        2 -> "twelve"
        3 -> "thirteen"
        4 -> "fourteen"
        5 -> "fifteen"
        6 -> "sixteen"
        7 -> "seventeen"
        8 -> "eighteen"
        9 -> "nineteen"
        _ -> panic
      }
    _, _ -> {
      case tens {
        2 -> "twenty"
        3 -> "thirty"
        4 -> "forty"
        5 -> "fifty"
        6 -> "sixty"
        7 -> "seventy"
        8 -> "eighty"
        9 -> "ninety"
        _ -> panic
      }
      |> concat(say_digit(ones), "-")
    }
  }
}

fn validate_range(number: Int) -> Result(Int, Error) {
  case number >= 0 && number <= 999_999_999_999 {
    True -> Ok(number)
    False -> Error(OutOfRange)
  }
}

fn group_by_thousands(number: Int) -> Result(List(List(Int)), Error) {
  Ok(
    number
    |> digits(10)
    |> unwrap([])
    |> reverse
    |> sized_chunk(3)
    |> map(reverse)
    |> map(pad_group),
  )
}

fn pad_group(l: List(Int)) -> List(Int) {
  case l {
    [_, _, _] -> l
    _ -> pad_group([0, ..l])
  }
}

fn say_numbers(numbers: List(List(Int))) -> Result(List(String), Error) {
  let text = case numbers {
    [[0, 0, 0]] -> ["zero"]
    _ ->
      map(numbers, fn(digits) {
        case digits {
          [0, 0, o] -> say_digit(o)
          [0, t, o] -> say_tens(t, o)
          [h, t, o] -> say_hundrets(h, t, o)
          _ -> panic
        }
      })
  }

  Ok(text)
}

fn append_unit(number: String, index: Int) -> String {
  case index, number {
    0, "" -> ""
    _, "" -> ""
    1, _ -> number <> " thousand"
    2, _ -> number <> " million"
    3, _ -> number <> " billion"
    _, _ -> number
  }
}

fn append_units(numbers: List(String)) -> Result(List(String), Error) {
  Ok(
    numbers
    |> index_map(append_unit),
  )
}

fn join_numbers(numbers: List(String)) -> Result(String, Error) {
  Ok(
    numbers
    |> reverse
    |> join(" ")
    |> trim,
  )
}

pub fn say(number: Int) -> Result(String, Error) {
  number
  |> validate_range
  |> then(group_by_thousands)
  |> then(say_numbers)
  |> then(append_units)
  |> then(join_numbers)
}
