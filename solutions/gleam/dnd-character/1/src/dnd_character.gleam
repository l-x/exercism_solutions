import gleam/int

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let constituion = ability()

  Character(
    charisma: ability(),
    constitution: constituion,
    dexterity: ability(),
    hitpoints: 10 + modifier(constituion),
    intelligence: ability(),
    strength: ability(),
    wisdom: ability(),
  )
}

pub fn modifier(score: Int) -> Int {
  let assert Ok(m) = int.floor_divide(score - 10, 2)

  m
}

pub fn ability() -> Int {
  int.random(16) + 3
}
