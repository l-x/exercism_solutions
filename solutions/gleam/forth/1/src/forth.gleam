import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

// TOKENIZER --------------------------------------------------------

pub type Token {
  Number(Int)
  Word(String)
  Definition(Token, List(Token))
  Invalid
}

fn create_token(value: String) -> Token {
  case int.parse(value) {
    Ok(i) -> Number(i)
    _ -> Word(string.uppercase(value))
  }
}

fn create_definition(
  name: String,
  values: List(String),
  acc: List(Token),
) -> #(Token, List(String)) {
  case values {
    [] -> #(Invalid, [])
    [";", ..tl] -> #(Definition(create_token(name), acc |> list.reverse), tl)
    [hd, ..tl] -> create_definition(name, tl, [create_token(hd), ..acc])
  }
}

fn create_tokens(values: List(String), acc: List(Token)) -> List(Token) {
  case values {
    [] -> acc |> list.reverse
    [":", name, ..tl] -> {
      let #(token, tl) = create_definition(name, tl, [])
      create_tokens(tl, [token, ..acc])
    }
    [hd, ..tl] -> create_tokens(tl, [create_token(hd), ..acc])
  }
}

fn tokenize(prog: String) -> List(Token) {
  prog
  |> string.split(" ")
  |> list.map(string.trim)
  |> list.filter(fn(x) { x != "" })
  |> create_tokens([])
}

// EVALUATION -------------------------------------------------------

fn eval_word(f: Forth, word: String) -> Result(Forth, ForthError) {
  case get_word(f, word) {
    Ok(func) -> func(f)
    Error(err) -> Error(err)
  }
}

fn eval_token(f: Forth, token: Token) -> Result(Forth, ForthError) {
  case token {
    Number(i) -> push(f, [i])
    Word(w) -> eval_word(f, w)
    Definition(name, tokens) -> define_word(f, name, tokens)
    _ -> Error(InvalidWord)
  }
}

fn eval_tokens(f: Forth, tokens: List(Token)) -> Result(Forth, ForthError) {
  case tokens {
    [] -> Ok(f)
    [token, ..tokens] -> {
      use f <- result.try(eval_token(f, token))

      eval_tokens(f, tokens)
    }
  }
}

// STACK ------------------------------------------------------------

fn push(f: Forth, values: List(Int)) -> Result(Forth, ForthError) {
  case values {
    [] -> Ok(f)
    [value, ..values] -> push(Forth(..f, stack: [value, ..f.stack]), values)
  }
}

fn pop(f: Forth) -> Result(#(Forth, Int), ForthError) {
  case f.stack {
    [] -> Error(StackUnderflow)
    [value, ..stack] -> Ok(#(Forth(..f, stack: stack), value))
  }
}

// WORDDICT ---------------------------------------------------------

type Func =
  fn(Forth) -> Result(Forth, ForthError)

fn create_word_dict() -> Dict(String, Func) {
  dict.from_list([
    #("+", func2(fn(a, b) { Ok([a + b]) })),
    #("-", func2(fn(a, b) { Ok([a - b]) })),
    #("*", func2(fn(a, b) { Ok([a * b]) })),
    #(
      "/",
      func2(fn(a, b) {
        case b {
          0 -> Error(DivisionByZero)
          _ -> Ok([a / b])
        }
      }),
    ),
    #("DUP", func1(fn(a) { Ok([a, a]) })),
    #("DROP", func1(fn(_) { Ok([]) })),
    #("SWAP", func2(fn(a, b) { Ok([b, a]) })),
    #("OVER", func2(fn(a, b) { Ok([a, b, a]) })),
  ])
}

fn get_word(f: Forth, name: String) -> Result(Func, ForthError) {
  case dict.get(f.words, name) {
    Ok(func) -> Ok(func)
    _ -> Error(UnknownWord)
  }
}

// I guess this hould have some documentation some day...
fn define_word(
  f: Forth,
  name: Token,
  tokens: List(Token),
) -> Result(Forth, ForthError) {
  case name {
    Word(n) -> {
      let func = fn(f2: Forth) -> Result(Forth, ForthError) {
        use f3 <- result.try(eval_tokens(
          Forth(stack: f2.stack, words: f.words),
          tokens,
        ))

        Ok(Forth(stack: f3.stack, words: f2.words))
      }

      let words = dict.insert(f.words, n, func)
      Ok(Forth(..f, words:))
    }
    _ -> Error(InvalidWord)
  }
}

// Wrapper for unary functions
fn func1(func: fn(Int) -> Result(List(Int), ForthError)) -> Func {
  fn(f: Forth) -> Result(Forth, ForthError) {
    use #(f, a) <- result.try(pop(f))
    use r <- result.try(func(a))

    push(f, r)
  }
}

// Wrapper for binary functions
fn func2(func: fn(Int, Int) -> Result(List(Int), ForthError)) -> Func {
  fn(f: Forth) -> Result(Forth, ForthError) {
    use #(f, b) <- result.try(pop(f))
    use #(f, a) <- result.try(pop(f))
    use r <- result.try(func(a, b))

    push(f, r)
  }
}

// ------------------------------------------------------------------

pub type Forth {
  Forth(stack: List(Int), words: Dict(String, Func))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub fn new() -> Forth {
  Forth(stack: [], words: create_word_dict())
}

pub fn format_stack(f: Forth) -> String {
  f.stack
  |> list.reverse
  |> list.map(int.to_string)
  |> string.join(" ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  prog
  |> tokenize
  |> eval_tokens(f, _)
}
