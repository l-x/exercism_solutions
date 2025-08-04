import gleam/list

pub fn new_list() -> List(String) {
  []
}

pub fn existing_list() -> List(String) {
  ["Gleam", "Go", "TypeScript"]
}

pub fn add_language(languages: List(String), language: String) -> List(String) {
  list.prepend(languages, language)
}

pub fn count_languages(languages: List(String)) -> Int {
  list.length(languages)
}

pub fn reverse_list(languages: List(String)) -> List(String) {
  list.reverse(languages)
}

pub fn exciting_list(languages: List(String)) -> Bool {
  case languages {
    [l, ..] if l == "Gleam" -> True
    [_, l, ..] if l == "Gleam" -> list.length(languages) <= 3
    _ -> False
  }
}
