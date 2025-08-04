import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case path |> simplifile.read {
    Ok(body) -> Ok(body |> string.trim |> string.split("\n"))
    Error(err) -> {
      io.debug(err)
      Error(Nil)
    }
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case path |> simplifile.create_file {
    Ok(Nil) -> Ok(Nil)
    // Error(simplifile.Eexist) -> Ok(Nil)
    Error(err) -> {
      io.debug(err)
      Error(Nil)
    }
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case path |> simplifile.append(email <> "\n") {
    Ok(Nil) -> Ok(Nil)
    Error(err) -> {
      io.debug(err)
      Error(Nil)
    }
  }
}

fn send_and_log(
  email: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  result.try(send_email(email), fn(_) { log_sent_email(log_path, email) })
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  use _ <- result.try(create_log_file(log_path))
  use emails <- result.try(read_emails(emails_path))

  list.each(emails, send_and_log(_, log_path, send_email))

  Ok(Nil)
}
