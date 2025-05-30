% --- Fruit-color facts
fruit_color(apple, red).
fruit_color(apple, green).
fruit_color(banana, yellow).
fruit_color(grape, purple).
fruit_color(grape, green).
fruit_color(orange, orange).
fruit_color(mango, yellow).
fruit_color(mango, green).

% --- Query rule
find_color(Fruit, Color) :-
    fruit_color(Fruit, Color).
