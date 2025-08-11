-module(rational_numbers).

-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).

-type rn() :: {A :: integer(), B :: integer()}.

-spec pow(X :: number(), N :: number()) -> integer().
pow(X, N) ->
    trunc(math:pow(X, N)).

-spec root(X :: number(), N :: number()) -> float().
root(X, N) ->
    math:pow(X, 1 / N).

-spec gcd(rn()) -> integer().
gcd({A, 0}) ->
    A;
gcd({A, B}) ->
    gcd({B, A rem B}).

-spec fix_sign(rn()) -> rn().
fix_sign({A, B}) when A >= 0, B < 0 ->
    {A * -1, B * -1};
fix_sign({A, B}) ->
    {A, B}.

-spec absolute(rn()) -> rn().
absolute({N, D}) ->
    reduce({abs(N), abs(D)}).

-spec add(rn(), rn()) -> rn().
add({A1, B1}, {A2, B2}) ->
    reduce({A1 * B2 + A2 * B1, B1 * B2}).

-spec divide(rn(), rn()) -> rn().
divide({N1, D1}, {N2, D2}) ->
    reduce({N1 * D2, N2 * D1}).

exp({A, B}, Exponent) when is_integer(Exponent), Exponent >= 0 ->
    reduce({pow(A, Exponent), pow(B, Exponent)});
exp({A, B}, Exponent) when is_integer(Exponent), Exponent < 0 ->
    reduce({pow(B, abs(Exponent)), pow(A, abs(Exponent))});
exp({A, B}, Exponent) when is_float(Exponent) ->
    math:pow(A, Exponent) / math:pow(B, Exponent);
exp(N, {A, B}) when is_number(N) ->
    root(math:pow(N, A), B).

-spec mul(rn(), rn()) -> rn().
mul({A1, B1}, {A2, B2}) ->
    reduce({A1 * A2, B1 * B2}).

-spec reduce(rn()) -> rn().
reduce({A, B} = Rn) ->
    Gcd = gcd(Rn),
    fix_sign({A div Gcd, B div Gcd}).

-spec sub(rn(), rn()) -> rn().
sub({A1, B1}, {A2, B2}) ->
    reduce({A1 * B2 - A2 * B1, B1 * B2}).
