import gleam/list
import gleam/option.{type Option}

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

fn set_if(command: Command, value: Int) -> Option(Command) {
  case value {
    0 -> option.None
    _ -> option.Some(command)
  }
}

fn reverse_if(commands: List(Command), value: Int) -> List(Command) {
  case value {
    0 -> commands
    _ -> commands |> list.reverse
  }
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let assert <<reverse:1, jump:1, close:1, blink:1, wink:1>> = <<
    encoded_message:5,
  >>

  [
    Wink |> set_if(wink),
    DoubleBlink |> set_if(blink),
    CloseYourEyes |> set_if(close),
    Jump |> set_if(jump),
  ]
  |> option.values
  |> reverse_if(reverse)
}
