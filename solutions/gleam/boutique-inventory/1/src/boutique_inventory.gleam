import gleam/iterator.{type Iterator, filter, fold, map}

fn name(item: Item) -> String {
  item.name
}

fn is_cheap(item: Item) -> Bool {
  item.price < 30
}

fn is_out_of_stock(item: Item) -> Bool {
  item.quantity < 1
}

fn quantity(acc: Int, item: Item) -> Int {
  acc + item.quantity
}

pub type Item {
  Item(name: String, price: Int, quantity: Int)
}

pub fn item_names(items: Iterator(Item)) -> Iterator(String) {
  map(items, name)
}

pub fn cheap(items: Iterator(Item)) -> Iterator(Item) {
  filter(items, is_cheap)
}

pub fn out_of_stock(items: Iterator(Item)) -> Iterator(Item) {
  filter(items, is_out_of_stock)
}

pub fn total_stock(items: Iterator(Item)) -> Int {
  fold(items, 0, quantity)
}
