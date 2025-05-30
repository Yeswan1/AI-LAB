% person(Name, DateOfRegistration).

person(john, '2024-05-10').
person(mary, '2023-12-01').
person(alice, '2025-01-20').
person(bob, '2024-11-15').
person(susan, '2023-05-01').

% Rule: registered_before(Name, Date)
% Checks if a person's DOR is before a given date
registered_before(Name, Date) :-
    person(Name, DOR),
    DOR @< Date.

% Rule: registered_after(Name, Date)
% Checks if a person's DOR is after a given date
registered_after(Name, Date) :-
    person(Name, DOR),
    DOR @> Date.
