import gleam/list
import gleam/string

const vowels = ["a", "e", "i", "o", "u"]

pub fn translate(phrase: String) -> String {
  string.split(phrase, " ")
  |> list.map(translate_word)
  |> string.join(" ")
}

fn translate_word(word: String) -> String {
  use <- rule1(word)
  use <- rule2(word)
  use <- rule3(word)

  word
}

fn starts_with(word: String, prefixes: List(String)) -> Bool {
  list.filter(prefixes, string.starts_with(word, _)) != []
}

fn split_at_first_consonant(word: String, acc: String) -> #(String, String) {
  case string.pop_grapheme(word) {
    Error(_) -> #(acc, "")
    Ok(#(x, xs)) ->
      case list.contains(vowels, x) || x == "y" && acc != "" {
        True -> #(acc, word)
        False -> split_at_first_consonant(xs, acc <> x)
      }
  }
}

fn ay(word: String) -> String {
  word <> "ay"
}

fn rule1(word: String, continue: fn() -> String) -> String {
  case starts_with(word, ["xr", "yt", ..vowels]) {
    True -> ay(word)
    _ -> continue()
  }
}

fn rule2(word: String, continue: fn() -> String) -> String {
  let #(x, xs) = split_at_first_consonant(word, "")

  case x == "" || string.ends_with(x, "q") && string.starts_with(xs, "u") {
    False -> ay(xs <> x)
    _ -> continue()
  }
}

fn rule3(word: String, continue: fn() -> String) -> String {
  case string.split_once(word, "qu") {
    Ok(#(x, xs)) -> ay(xs <> x <> "qu")
    _ -> continue()
  }
}
