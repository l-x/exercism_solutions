import gleam/bool
import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/string

const table_header = "Team                           | MP |  W |  D |  L |  P"

type TeamStats {
  TeamStats(name: String, won: Int, drawn: Int, lost: Int, points: Int)
}

type MatchResult =
  #(String, String, String)

type League =
  dict.Dict(String, TeamStats)

pub fn tally(input: String) -> String {
  list.fold(over: parse(input), from: dict.new(), with: record)
  |> dict.values
  |> list.sort(fn(s1, s2) { int.compare(s2.points, s1.points) })
  |> list.map(format_row)
  |> list.prepend(table_header)
  |> string.join("\n")
}

fn parse(input: String) -> List(MatchResult) {
  use <- bool.guard(when: input == "", return: [])

  input
  |> string.split("\n")
  |> list.map(string.split(_, ";"))
  |> list.map(fn(s) {
    let assert [t1, t2, r] = s
    #(t1, t2, r)
  })
}

fn do_record(league: League, match: MatchResult) -> League {
  let #(team_1, _, result) = match

  let is = fn(r) {
    case result == r {
      True -> 1
      False -> 0
    }
  }

  let win = is("win")
  let draw = is("draw")
  let loss = is("loss")
  let points = win * 3 + draw

  dict.upsert(league, team_1, fn(teamstats) {
    case teamstats {
      option.None -> TeamStats(team_1, win, draw, loss, points)
      option.Some(ts) ->
        TeamStats(
          ts.name,
          ts.won + win,
          ts.drawn + draw,
          ts.lost + loss,
          ts.points + points,
        )
    }
  })
}

fn record(league: League, match: MatchResult) -> League {
  let opposite_match = #(match.1, match.0, case match.2 {
    "win" -> "loss"
    "loss" -> "win"
    r -> r
  })

  league
  |> do_record(match)
  |> do_record(opposite_match)
}

fn format_row(stats: TeamStats) -> String {
  let fmt = fn(i) {
    i
    |> int.to_string
    |> string.pad_left(2, " ")
  }

  [
    string.pad_right(stats.name, 30, " "),
    fmt(stats.won + stats.drawn + stats.lost),
    fmt(stats.won),
    fmt(stats.drawn),
    fmt(stats.lost),
    fmt(stats.points),
  ]
  |> string.join(" | ")
  |> string.trim
}
