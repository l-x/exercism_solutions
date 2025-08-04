import gleam/int
import gleam/list
import gleam/pair

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

const allergens = [
  #(Eggs, 1), #(Peanuts, 2), #(Shellfish, 4), #(Strawberries, 8),
  #(Tomatoes, 16), #(Chocolate, 32), #(Pollen, 64), #(Cats, 128),
]

fn get_score(for allergen: Allergen) -> Int {
  let assert Ok(#(_, score)) =
    list.find(allergens, fn(p) { pair.first(p) == allergen })

  score
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  int.bitwise_and(score, get_score(for: allergen)) != 0
}

pub fn list(score: Int) -> List(Allergen) {
  allergens
  |> list.map(pair.first)
  |> list.filter(allergic_to(_, score))
}
