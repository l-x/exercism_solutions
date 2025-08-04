-module(acronym).

-export([abbreviate/1]).

-define(PATTERN, "(^|\\s|_|-)([A-Z])").
-define(OPTIONS, [global, {capture, [2], list}]).

-spec abbreviate(Phrase :: string()) -> string().
abbreviate(Phrase) ->
    P = string:uppercase(Phrase),

    {ok, Re} = re:compile(?PATTERN),
    {match, Captured} = re:run(P, Re, ?OPTIONS),

    lists:flatten(Captured).
