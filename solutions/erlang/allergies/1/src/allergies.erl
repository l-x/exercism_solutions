-module(allergies).

-export([allergies/1, is_allergic_to/2]).

-define(SCORES,
        [{eggs, 1},
         {peanuts, 2},
         {shellfish, 4},
         {strawberries, 8},
         {tomatoes, 16},
         {chocolate, 32},
         {pollen, 64},
         {cats, 128}]).

allergies(Score) ->
    lists:filter(fun(Substance) -> is_allergic_to(Substance, Score) end,
                 proplists:get_keys(?SCORES)).

is_allergic_to(Substance, Score) ->
    Score band proplists:get_value(Substance, ?SCORES, 0) > 0.
