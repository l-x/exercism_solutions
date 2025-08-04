import gleam/string.{ends_with, is_empty, lowercase, trim, uppercase}

pub fn hey(remark: String) -> String {
  let trimmed = trim(remark)

  let yell = remark == uppercase(trimmed) && remark != lowercase(trimmed)
  let ask = ends_with(trimmed, "?")
  let silence = is_empty(trimmed)

  case silence {
    True -> "Fine. Be that way!"
    False ->
      case ask, yell {
        True, False -> "Sure."
        True, True -> "Calm down, I know what I'm doing!"
        False, True -> "Whoa, chill out!"
        _, _ -> "Whatever."
      }
  }
}
