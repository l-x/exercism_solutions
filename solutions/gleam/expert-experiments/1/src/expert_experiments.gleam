import gleam/result.{try}

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Error(_) -> experiment()
    ok -> ok
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()

  let r = experiment()
  time_logger()

  r
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use setup_data <- try(setup())
  use action_data <- try(action(setup_data))
  use record_data <- try(record(setup_data, action_data))

  Ok(#(name, record_data))
}
