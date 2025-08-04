import gleam/option.{type Option, None, Some}
import gleam/string

fn get_message(log_line: String) -> Option(String) {
  log_line
  |> string.crop(before: " ")
  |> string.trim
  |> string.to_option
}

fn get_log_level(log_line: String) -> Option(String) {
  case log_line {
    "[INFO]" <> _ -> Some("info")
    "[WARNING]" <> _ -> Some("warning")
    "[ERROR]" <> _ -> Some("error")
    _ -> None
  }
}

pub fn message(log_line: String) -> String {
  let assert Some(msg) = get_message(log_line)

  msg
}

pub fn log_level(log_line: String) -> String {
  let assert Some(log_level) = get_log_level(log_line)

  log_level
}

pub fn reformat(log_line: String) -> String {
  let log_level = log_level(log_line)
  let msg = message(log_line)

  string.concat([msg, " (", log_level, ")"])
}
