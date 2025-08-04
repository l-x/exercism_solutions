import gleam/bool.{guard}
import gleam/int.{base_parse}
import gleam/list.{fold}
import gleam/result.{try}
import gleam/string.{
  drop_right, length, lowercase, replace, slice, starts_with, uppercase,
}

type Number =
  #(String, String, String, String)

fn to_string(n: Number) -> String {
  n.1 <> n.2 <> n.3
}

fn from_string(input: String) -> Number {
  let s = fn(o, s) { input |> drop_right(o) |> slice(-s, s) }

  #(s(10, 1), s(7, 3), s(4, 3), s(0, 4))
}

// Remove all valid non-numbers and a leading `+`
fn clean_up(input: String) {
  let remove = ["(", ")", ".", "-", " "]
  let r = fn(f, c) { replace(f, c, "") }

  case fold(remove, input, r) {
    "+" <> n -> n
    n -> n
  }
}

// Validate a given string does not start with `0` or `1`
fn validate_prefix(c: String, t: String) -> Result(Nil, String) {
  use <- guard(starts_with(c, "0"), Error(t <> " code cannot start with zero"))
  use <- guard(starts_with(c, "1"), Error(t <> " code cannot start with one"))

  Ok(Nil)
}

// Make sure that the string contains only digits - and if not, 
// distinguish whether it contains letters or punctuations
fn validate_block(b: String) -> Result(Nil, String) {
  case base_parse(b, 10) {
    Ok(_) -> Ok(Nil)
    Error(_) ->
      case uppercase(b) == lowercase(b) {
        True -> Error("punctuations not permitted")
        False -> Error("letters not permitted")
      }
  }
}

pub fn clean(input: String) -> Result(String, String) {
  let clean = clean_up(input)
  let n = from_string(clean)

  // length constraints
  use <- guard(length(clean) > 11, Error("must not be greater than 11 digits"))
  use <- guard(length(n.1) < 3, Error("must not be fewer than 10 digits"))

  // country code
  use <- guard(n.0 != "" && n.0 != "1", Error("11 digits must start with 1"))

  // area code
  use _ <- try(validate_block(n.1))
  use _ <- try(validate_prefix(n.1, "area"))

  // exchange code
  use _ <- try(validate_block(n.2))
  use _ <- try(validate_prefix(n.2, "exchange"))

  // rest
  use _ <- try(validate_block(n.3))

  Ok(n |> to_string)
}
