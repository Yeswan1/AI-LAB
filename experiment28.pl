% --- Symptoms for each disease ---
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

% --- Ask user for symptoms ---
symptom(Symptom) :-
    format('Do you have ~w? (yes/no): ', [Symptom]),
    read(Response),
    Response = yes.

% --- Start diagnosis ---
diagnose :-
    write('--- Medical Diagnosis System ---'), nl,
    disease(Disease),
    format('You may be suffering from: ~w', [Disease]), nl,
    !.

diagnose :-
    write('Sorry, I could not diagnose the disease based on your symptoms.'), nl.
