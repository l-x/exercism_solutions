// Please define the TreasureChest generic custom type
pub type TreasureChest(a) {
  TreasureChest(password: String, treasure: a)
}

// Please define the UnlockResult generic custom type
pub type UnlockResult(a) {
  Unlocked(treasure: a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest.password == password {
    True -> Unlocked(chest.treasure)
    _ -> WrongPassword
  }
}
