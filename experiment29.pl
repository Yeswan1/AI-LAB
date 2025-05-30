% --- Dynamic database to allow runtime assertions ---
:- dynamic known/1.

% --- Disease rules based on symptoms ---
diagnose(flu) :-
    known(fever),
    known(cough),
    known(headache),
    known(body_ache).

diagnose(common_cold) :-
    known(sneezing),
    known(runny_nose),
    known(sore_throat).

diagnose(malaria) :-
    known(fever),
    known(chills),
    known(sweating),
    known(headache).

diagnose(typhoid) :-
    known(fever),
    known(abdominal_pain),
    known(fatigue),
    known(loss_of_appetite).

diagnose(covid19) :-
    known(fever),
    known(cough),
    known(loss_of_taste),
    known(shortness_of_breath).

% --- Ask for symptoms and assert them as known facts ---
ask_symptoms([]).
ask_symptoms([Symptom | Rest]) :-
    format('Do you have ~w? (yes/no): ', [Symptom]),
    read(Response),
    (Response == yes -> assertz(known(Symptom)) ; true),
    ask_symptoms(Rest).

% --- Run the forward chaining diagnosis ---
start_diagnosis :-
    retractall(known(_)),  % clear previous session
    Symptoms = [fever, cough, headache, body_ache, sneezing, runny_nose, sore_throat,
                chills, sweating, abdominal_pain, fatigue, loss_of_appetite,
                loss_of_taste, shortness_of_breath],
    ask_symptoms(Symptoms),
    (diagnose(Disease) ->
        format('You may be suffering from: ~w~n', [Disease])
    ;
        write('No diagnosis could be made based on the given symptoms.'), nl
    ).
