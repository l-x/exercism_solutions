import gleam/list
import gleam/string

fn normalize(word: String) -> String {
  word
  |> string.split("")
  |> list.sort(by: string.compare)
  |> string.join("")
}

fn is_anagram(word: String) -> fn(String) -> Bool {
  let word = string.lowercase(word)
  let normalized_word = normalize(word)

  fn(candidate: String) -> Bool {
    let candidate = string.lowercase(candidate)

    candidate != word && normalize(candidate) == normalized_word
  }
}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  list.filter(candidates, is_anagram(word))
}
