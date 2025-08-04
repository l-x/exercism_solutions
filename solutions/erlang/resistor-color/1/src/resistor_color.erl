-module(resistor_color).

-export([colors/0, color_code/1]).

colors() ->
    [black, brown, red, orange, yellow, green, blue, violet, grey, white].

color_code(Color) ->
    Colors = colors(),
    Count = length(Colors),
    proplists:get_value(Color, lists:zip(Colors, lists:seq(0, Count - 1))).
