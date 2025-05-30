% Facts: parent(Parent, Child)

parent(john, mary).
parent(john, david).
parent(susan, mary).
parent(susan, david).
parent(mary, linda).
parent(mary, kevin).
parent(david, james).
parent(david, emma).
parent(linda, sophie).

% Gender information
male(john).
male(david).
male(kevin).
male(james).

female(susan).
female(mary).
female(linda).
female(emma).
female(sophie).

% Rules:

% X is the father of Y
father(X, Y) :-
    parent(X, Y),
    male(X).

% X is the mother of Y
mother(X, Y) :-
    parent(X, Y),
    female(X).

% X is a child of Y
child(X, Y) :-
    parent(Y, X).

% X is a sibling of Y (they share a parent, and are not the same person)
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

% X is a brother of Y
brother(X, Y) :-
    sibling(X, Y),
    male(X).

% X is a sister of Y
sister(X, Y) :-
    sibling(X, Y),
    female(X).

% X is a grandparent of Y
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% X is a grandfather of Y
grandfather(X, Y) :-
    grandparent(X, Y),
    male(X).

% X is a grandmother of Y
grandmother(X, Y) :-
    grandparent(X, Y),
    female(X).

% X is an ancestor of Y
ancestor(X, Y) :-
    parent(X, Y).

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).
