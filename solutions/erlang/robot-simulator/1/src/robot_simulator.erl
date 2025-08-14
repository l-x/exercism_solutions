-module(robot_simulator).

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2]).
-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).

%% Server Callbacks

init(_Args) ->
    {ok, {north, {0, 0}}}.

handle_call(direction, _From, {Direction, _Position} = State) ->
    {reply, Direction, State};
handle_call(position, _From, {_Direction, Position} = State) ->
    {reply, Position, State}.

handle_cast({place, NewState}, _OldState) ->
    {noreply, NewState};
handle_cast(right, State) ->
    {noreply, do_turn_right(State)};
handle_cast(left, State) ->
    {noreply, do_turn_left(State)};
handle_cast(advance, State) ->
    {noreply, do_advance(State)}.

%% Helper functions

do_advance({Direction, {X, Y}}) ->
    case Direction of
        north ->
            {Direction, {X, Y + 1}};
        east ->
            {Direction, {X + 1, Y}};
        south ->
            {Direction, {X, Y - 1}};
        west ->
            {Direction, {X - 1, Y}}
    end.

do_turn_left({Direction, Position}) ->
    case Direction of
        north ->
            {west, Position};
        west ->
            {south, Position};
        south ->
            {east, Position};
        east ->
            {north, Position}
    end.

do_turn_right({Direction, Position}) ->
    case Direction of
        north ->
            {east, Position};
        east ->
            {south, Position};
        south ->
            {west, Position};
        west ->
            {north, Position}
    end.

%% Exercise Functions

create() ->
    {ok, Pid} = gen_server:start_link(?MODULE, [], []),

    Pid.

direction(Robot) ->
    gen_server:call(Robot, direction).

left(Robot) ->
    gen_server:cast(Robot, left).

place(Robot, Direction, Position) ->
    gen_server:cast(Robot, {place, {Direction, Position}}).

position(Robot) ->
    gen_server:call(Robot, position).

right(Robot) ->
    gen_server:cast(Robot, right).

advance(Robot) ->
    gen_server:cast(Robot, advance).
