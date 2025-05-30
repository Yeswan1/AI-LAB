% --- Allow runtime facts (known/1) ---
:- dynamic known/1.

% --- Rules: Disease diagnosis based on symptoms ---
disease(flu) :-
    symptom(fever),
    symptom(cough),
    symptom(headache),
    symptom(body_ache).

disease(common_cold) :-
    symptom(sneezing),
    symptom(runny_nose),
    symptom(sore_throat).

disease(malaria) :-
    symptom(fever),
    symptom(chills),
    symptom(sweating),
    symptom(headache).

disease(typhoid) :-
    symptom(fever),
    symptom(abdominal_pain),
    symptom(fatigue),
    symptom(loss_of_appetite).

disease(covid19) :-
    symptom(fever),
    symptom(cough),
    symptom(loss_of_taste),
    symptom(shortness_of_breath).

% --- Symptom query (only asks once) ---
symptom(S) :-
    known(S), !.

symptom(S) :-
    format('Do you have ~w? (yes/no): ', [S]),
    read(Response),
    (Response == yes -> assertz(known(S)) ; fail).

% --- Backward chaining diagnosis attempt ---
diagnose :-
    retractall(known(_)),  % clear previous knowledge
    disease(D),
    format('You may be suffering from: ~w~n', [D]), !.

diagnose :-
    write('No diagnosis could be made based on the given symptoms.'), nl.
