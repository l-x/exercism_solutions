-module(accumulate).
-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Fn, List) -> accumulate(Fn, List, []).

-spec accumulate(fun((A) -> B), list(A), list(B)) -> list(B).
accumulate(_, [], Acc) -> reverse(Acc, []);
accumulate(Fn, [X|Xs], Acc) -> accumulate(Fn, Xs, [Fn(X) | Acc]).

-spec reverse(list(A), list(A)) -> list(A).
reverse([], Acc) -> Acc;
reverse([X|Xs], Acc) -> reverse(Xs, [X | Acc]).