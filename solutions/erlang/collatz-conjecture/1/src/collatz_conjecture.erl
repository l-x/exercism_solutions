-module(collatz_conjecture).

-export([steps/1]).

-spec calc(integer()) -> integer().
calc(N) when N rem 2 =:= 0 -> N div 2;
calc(N) -> N * 3 + 1.

-spec steps(integer(), integer()) -> integer().
steps(1, Acc) -> Acc;
steps(N, Acc) -> steps(calc(N), Acc + 1).

-spec steps(integer()) -> integer().
steps(N) when N > 0 -> steps(N, 0);
steps(_) -> error(badarg).
