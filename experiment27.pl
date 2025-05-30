% --- Graph edges ---
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(d, g).
edge(e, g).
edge(f, g).

% --- Heuristic function: h(Node, Heuristic) ---
h(a, 6).
h(b, 4).
h(c, 5).
h(d, 2).
h(e, 3).
h(f, 4).
h(g, 0).

% --- Entry Point ---
best_first(Start, Goal, Path) :-
    bfs([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

% --- Main BFS Procedure ---
bfs([[Goal|Rest]|_], Goal, [Goal|Rest]).
bfs([[Current|Rest]|OtherPaths], Goal, Path) :-
    findall(
        [Next,Current|Rest],
        (edge(Current, Next), \+ member(Next, [Current|Rest])),
        NewPaths
    ),
    score_paths(NewPaths, ScoredNewPaths),
    score_paths(OtherPaths, ScoredOtherPaths),
    append(ScoredNewPaths, ScoredOtherPaths, Combined),
    sort(2, @=<, Combined, Sorted),
    extract_paths(Sorted, SortedPaths),
    bfs(SortedPaths, Goal, Path).

% --- Attach Heuristic Scores ---
score_paths([], []).
score_paths([[Node|Rest]|T], [[[Node|Rest], H]|R]) :-
    h(Node, H),
    score_paths(T, R).

% --- Remove Scores After Sorting ---
extract_paths([], []).
extract_paths([[Path,_]|T], [Path|R]) :-
    extract_paths(T, R).
