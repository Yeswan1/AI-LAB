import itertools

# Distance matrix: dist[i][j] is the distance from city i to city j
dist = [
    [0, 29, 20, 21],
    [29, 0, 15, 17],
    [20, 15, 0, 28],
    [21, 17, 28, 0]
]

num_cities = len(dist)
cities = list(range(num_cities))

# Initialize minimum path and cost
min_path = []
min_cost = float('inf')

# Generate all permutations of cities except the starting city (0)
for perm in itertools.permutations(cities[1:]):
    path = [0] + list(perm) + [0]  # Start and end at city 0
    cost = sum(dist[path[i]][path[i+1]] for i in range(num_cities))
    
    if cost < min_cost:
        min_cost = cost
        min_path = path

print("Minimum cost path:", min_path)
print("Minimum cost:", min_cost)
