-module(armstrong_numbers).

-export([is_armstrong_number/1]).

digits(0) ->
    [];
digits(Number) ->
    [Number rem 10 | digits(Number div 10)].

pow(X, N) ->
    trunc(math:pow(X, N)).

is_armstrong_number(0) ->
    true;

is_armstrong_number(Number) ->
    Digits = digits(Number),
    Len = length(Digits),

    lists:sum([pow(D, Len) || D <:- Digits]) =:= Number.
