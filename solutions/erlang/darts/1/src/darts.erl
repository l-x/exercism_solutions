-module(darts).

-export([score/2]).

-spec distance(X :: number(), Y :: number()) -> float().
distance(X, Y) ->
    abs(math:sqrt(math:pow(X, 2) + math:pow(Y, 2))).

-spec score(X :: number(), Y :: number()) -> float().
score(X, Y) ->
    score(distance(X, Y)).

-spec score(Distance :: float()) -> integer().
score(Distance) when Distance =< 1 ->
    10;
score(Distance) when Distance =< 5 ->
    5;
score(Distance) when Distance =< 10 ->
    1;
score(_) ->
    0.
