import math

# Players
HUMAN = 'O'
AI = 'X'
EMPTY = ' '

# Initial board
board = [[EMPTY, EMPTY, EMPTY],
         [EMPTY, EMPTY, EMPTY],
         [EMPTY, EMPTY, EMPTY]]

def print_board(board):
    for row in board:
        print("|".join(row))
    print()

def check_winner(board):
    # Check rows, columns, and diagonals
    for row in board:
        if row.count(row[0]) == 3 and row[0] != EMPTY:
            return row[0]
    for col in range(3):
        if board[0][col] != EMPTY and all(board[row][col] == board[0][col] for row in range(3)):
            return board[0][col]
    if board[0][0] != EMPTY and all(board[i][i] == board[0][0] for i in range(3)):
        return board[0][0]
    if board[0][2] != EMPTY and all(board[i][2 - i] == board[0][2] for i in range(3)):
        return board[0][2]
    return None

def is_full(board):
    return all(cell != EMPTY for row in board for cell in row)

# Minimax with Alpha-Beta Pruning
def minimax(board, depth, alpha, beta, is_maximizing):
    winner = check_winner(board)
    if winner == AI:
        return 1
    elif winner == HUMAN:
        return -1
    elif is_full(board):
        return 0

    if is_maximizing:
        max_eval = -math.inf
        for i in range(3):
            for j in range(3):
                if board[i][j] == EMPTY:
                    board[i][j] = AI
                    eval = minimax(board, depth + 1, alpha, beta, False)
                    board[i][j] = EMPTY
                    max_eval = max(max_eval, eval)
                    alpha = max(alpha, eval)
                    if beta <= alpha:
                        break
        return max_eval
    else:
        min_eval = math.inf
        for i in range(3):
            for j in range(3):
                if board[i][j] == EMPTY:
                    board[i][j] = HUMAN
                    eval = minimax(board, depth + 1, alpha, beta, True)
                    board[i][j] = EMPTY
                    min_eval = min(min_eval, eval)
                    beta = min(beta, eval)
                    if beta <= alpha:
                        break
        return min_eval

def best_move():
    best_score = -math.inf
    move = None
    for i in range(3):
        for j in range(3):
            if board[i][j] == EMPTY:
                board[i][j] = AI
                score = minimax(board, 0, -math.inf, math.inf, False)
                board[i][j] = EMPTY
                if score > best_score:
                    best_score = score
                    move = (i, j)
    if move:
        board[move[0]][move[1]] = AI

# Game loop
if __name__ == "__main__":
    while True:
        print_board(board)
        if check_winner(board) or is_full(board):
            break
        row = int(input("Enter your move row (0-2): "))
        col = int(input("Enter your move col (0-2): "))
        if board[row][col] == EMPTY:
            board[row][col] = HUMAN
            if not check_winner(board) and not is_full(board):
                best_move()
        else:
            print("Invalid move, try again.")

    print_board(board)
    winner = check_winner(board)
    if winner:
        print(f"Winner is {winner}")
    else:
        print("It's a draw!")
