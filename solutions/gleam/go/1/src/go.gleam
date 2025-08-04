import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

fn change_player(game: Game) -> Game {
  Game(
    ..game,
    player: case game.player {
      Black -> White
      White -> Black
    },
  )
}

fn handle_rule_result(r: Result(Game, String), initial_game: Game) -> Game {
  case r {
    Ok(game) -> change_player(game)
    Error(error) -> Game(..initial_game, error:)
  }
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  game
  |> rule2
  |> Ok
  |> result.try(rule1)
  |> result.then(rule3)
  |> result.then(rule4)
  |> handle_rule_result(game)
}
