import gleam/queue.{
  type Queue, length, pop_back, pop_front, push_back, push_front,
}

pub fn insert_top(queue: Queue(Int), card: Int) -> Queue(Int) {
  queue |> push_back(card)
}

pub fn remove_top_card(queue: Queue(Int)) -> Queue(Int) {
  case queue |> pop_back {
    Ok(#(_, q)) -> q
    _ -> queue
  }
}

pub fn insert_bottom(queue: Queue(Int), card: Int) -> Queue(Int) {
  queue |> push_front(card)
}

pub fn remove_bottom_card(queue: Queue(Int)) -> Queue(Int) {
  case queue |> pop_front {
    Ok(#(_, q)) -> q
    _ -> queue
  }
}

pub fn check_size_of_stack(queue: Queue(Int), target: Int) -> Bool {
  queue |> length == target
}
