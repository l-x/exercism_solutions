-module(sieve).

-export([primes/1]).

primes(N) when N < 2 ->
    [];
primes(N) ->
    sieve(lists:seq(2, N), []).

sieve([], Acc) ->
    Acc;
sieve([H | T], Acc) ->
    sieve([X || X <:- T, X rem H =/= 0 ], [H | Acc]).
