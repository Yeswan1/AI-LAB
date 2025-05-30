% --- State Representation: state(MonkeyPos, MonkeyOnBox, BoxPos, HasBanana)

% --- Initial state: monkey at door, on floor, box at window, no banana
initial_state(state(door, on_floor, window, has_not)).

% --- Goal state: monkey has the banana
goal_state(state(_, on_box, middle, has)).

% --- Possible actions
move(state(X, on_floor, X, has_not), grasp, state(X, on_box, X, has)).

move(state(X, on_floor, X, has_not), climb, state(X, on_box, X, has_not)).

move(state(X, on_floor, Y, H), push(X, Y), state(Y, on_floor, Y, H)).

move(state(X, on_floor, B, H), walk(X, Y), state(Y, on_floor, B, H)).

% --- Plan from one state to another
plan(State, [], _) :- goal_state(State).

plan(State, [Action | Rest], Visited) :-
    move(State, Action, NewState),
    \+ member(NewState, Visited),       % avoid cycles
    plan(NewState, Rest, [NewState | Visited]).

% --- Entry point: solve problem
solve :-
    initial_state(Initial),
    plan(Initial, Plan, [Initial]),
    write('Plan to reach the banana: '), nl,
    write_steps(Plan).

% --- Helper to print plan steps
write_steps([]).
write_steps([H|T]) :-
    write('- '), write(H), nl,
    write_steps(T).
% --- Start with user input
start :-
    write('Enter Monkey Position (door/window/middle): '), read(MonkeyPos),
    write('Enter Box Position (door/window/middle): '), read(BoxPos),
    InitialState = state(MonkeyPos, on_floor, BoxPos, has_not),
    plan(InitialState, Plan, [InitialState]),
    write('Plan to reach the banana:'), nl,
    write_steps(Plan).
