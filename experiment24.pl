% disease facts
disease(diabetes).
disease(hypertension).
disease(obesity).
disease(anemia).

% diet recommendations
diet(diabetes, 'Low sugar, high fiber, whole grains, leafy vegetables').
diet(hypertension, 'Low salt, high potassium, vegetables, fruits').
diet(obesity, 'Low fat, high protein, lots of vegetables').
diet(anemia, 'Iron-rich foods like spinach, meat, and legumes').

% rule to suggest diet
suggest_diet(Condition, Recommendation) :-
    disease(Condition),
    diet(Condition, Recommendation).
