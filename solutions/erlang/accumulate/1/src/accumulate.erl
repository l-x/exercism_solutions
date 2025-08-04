-module(accumulate).
-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Fn, List) -> accumulate(Fn, List, []).

-spec accumulate(fun((A) -> B), list(A), list(B)) -> list(B).
accumulate(Fn, [], Acc) -> lists:reverse(Acc);
accumulate(Fn, [X|Xs], Acc) -> accumulate(Fn, Xs, [Fn(X) | Acc]).