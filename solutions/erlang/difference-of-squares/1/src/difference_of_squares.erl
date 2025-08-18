-module(difference_of_squares).

-export([difference_of_squares/1, square_of_sum/1, sum_of_squares/1]).

difference_of_squares(Number) ->
    square_of_sum(Number) - sum_of_squares(Number).

square_of_sum(Number) ->
    Sum = (Number * Number + Number) div 2,
    Sum * Sum.

sum_of_squares(0) ->
    0;
sum_of_squares(Number) ->
    Number * Number + sum_of_squares(Number - 1).
