import gleam/list.{map}
import gleam/result.{unwrap}
import gleam/string.{first, join, replace, split, uppercase}

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> replace("-", " ")
  |> replace("_", " ")
  |> split(" ")
  |> map(fn(w) { w |> first |> unwrap("") })
  |> join("")
  |> uppercase
}
