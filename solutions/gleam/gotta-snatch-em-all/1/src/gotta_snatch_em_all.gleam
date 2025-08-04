import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  #(
    set.contains(collection, my_card) && !set.contains(collection, their_card),
    collection
      |> set.delete(my_card)
      |> set.insert(their_card),
  )
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case list.reduce(collections, set.intersection) {
    Ok(cards) -> set.to_list(cards)
    _ -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  case list.reduce(collections, set.union) {
    Ok(cards) -> set.size(cards)
    _ -> 0
  }
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, string.starts_with(_, "Shiny "))
}
