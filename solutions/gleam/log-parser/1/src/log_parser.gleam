import gleam/option.{Some}
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(r) = regex.from_string("^\\[(DEBUG|INFO|WARNING|ERROR)\\]\\W*")

  r |> regex.check(line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(r) = regex.from_string("\\<[~*=-]*\\>")

  r |> regex.split(line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(r) = regex.from_string("\\sUser\\s+(.+?)($|\\s)")

  case r |> regex.scan(line) {
    [regex.Match(_, [Some(name), ..]), ..] -> "[USER] " <> name <> " " <> line
    _ -> line
  }
}
