import gleam/bool
import gleam/queue
import gleam/result

pub opaque type CircularBuffer(t) {
  CircularBuffer(capacity: Int, length: Int, queue: queue.Queue(t))
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(capacity:, length: 0, queue: queue.new())
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  use #(item, queue) <- result.try(queue.pop_front(buffer.queue))

  Ok(#(item, CircularBuffer(..buffer, length: buffer.length - 1, queue:)))
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  use <- bool.guard(when: buffer.length >= buffer.capacity, return: Error(Nil))

  Ok(
    CircularBuffer(
      ..buffer,
      length: buffer.length + 1,
      queue: queue.push_back(buffer.queue, item),
    ),
  )
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  let queue = case buffer.length >= buffer.capacity {
    True -> {
      let assert Ok(#(_, queue)) = queue.pop_front(buffer.queue)

      queue
    }
    False -> buffer.queue
  }

  CircularBuffer(..buffer, length: buffer.length - 1, queue:)
  |> write(item)
  |> result.unwrap(buffer)
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  new(buffer.capacity)
}
