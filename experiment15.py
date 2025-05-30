import numpy as np

# Sample dataset: [feature1, feature2, ..., label]
data = [
    [1, 1, 'Yes'],
    [1, 0, 'No'],
    [0, 1, 'No'],
    [0, 0, 'No'],
    [1, 1, 'Yes']
]

# Split dataset by feature value
def split_dataset(dataset, feature_index, value):
    left = [row for row in dataset if row[feature_index] == value]
    right = [row for row in dataset if row[feature_index] != value]
    return left, right

# Calculate Gini Impurity
def gini_index(groups, classes):
    n_instances = sum([len(group) for group in groups])
    gini = 0.0
    for group in groups:
        size = len(group)
        if size == 0:
            continue
        score = 0.0
        labels = [row[-1] for row in group]
        for class_val in classes:
            p = labels.count(class_val) / size
            score += p * p
        gini += (1.0 - score) * (size / n_instances)
    return gini

# Find the best split
def get_best_split(dataset):
    class_values = list(set(row[-1] for row in dataset))
    best_index, best_value, best_score, best_groups = None, None, float('inf'), None
    for index in range(len(dataset[0]) - 1):  # excluding label
        for row in dataset:
            groups = split_dataset(dataset, index, row[index])
            gini = gini_index(groups, class_values)
            if gini < best_score:
                best_index, best_value, best_score, best_groups = index, row[index], gini, groups
    return {'index': best_index, 'value': best_value, 'groups': best_groups}

# Create terminal node
def to_terminal(group):
    labels = [row[-1] for row in group]
    return max(set(labels), key=labels.count)

# Recursive tree build
def split(node, max_depth, min_size, depth):
    left, right = node['groups']
    del(node['groups'])

    # Check for no split
    if not left or not right:
        node['left'] = node['right'] = to_terminal(left + right)
        return

    # Check for max depth
    if depth >= max_depth:
        node['left'], node['right'] = to_terminal(left), to_terminal(right)
        return

    # Process left child
    if len(left) <= min_size:
        node['left'] = to_terminal(left)
    else:
        node['left'] = get_best_split(left)
        split(node['left'], max_depth, min_size, depth + 1)

    # Process right child
    if len(right) <= min_size:
        node['right'] = to_terminal(right)
    else:
        node['right'] = get_best_split(right)
        split(node['right'], max_depth, min_size, depth + 1)

# Build a decision tree
def build_tree(train, max_depth, min_size):
    root = get_best_split(train)
    split(root, max_depth, min_size, 1)
    return root

# Make prediction with the tree
def predict(node, row):
    if row[node['index']] == node['value']:
        if isinstance(node['left'], dict):
            return predict(node['left'], row)
        else:
            return node['left']
    else:
        if isinstance(node['right'], dict):
            return predict(node['right'], row)
        else:
            return node['right']

# Test
tree = build_tree(data, max_depth=3, min_size=1)
for row in data:
    prediction = predict(tree, row)
    print(f"Expected={row[-1]}, Predicted={prediction}")
