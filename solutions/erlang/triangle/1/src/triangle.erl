-module(triangle).

-export([kind/3]).

kind(A, B, C) when A =< 0; B =< 0; C =< 0 ->
    {error, "all side lengths must be positive"};
kind(A, B, C) when A =< 0; B =< 0; C =< 0; A + B < C; B + C < A; A + C < B ->
    {error, "side lengths violate triangle inequality"};
kind(A, A, A) ->
    equilateral;
kind(A, A, _C) ->
    isosceles;
kind(A, _B, A) ->
    isosceles;
kind(_A, B, B) ->
    isosceles;
kind(_A, _B, _C) ->
    scalene.
