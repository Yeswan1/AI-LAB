import math
def print_board(board):
    for row in board:
        print(" | ".join(row))
        print("-" * 9)
def check_winner(board, player):
    for i in range(3):
        if all(cell == player for cell in board[i]): return True
        if all(board[j][i] == player for j in range(3)): return True
    if all(board[i][i] == player for i in range(3)) or all(board[i][2 - i] == player for i in range(3)):
        return True
    return False
def is_full(board):
    return all(cell in ['X', 'O'] for row in board for cell in row)
def get_empty_cells(board):
    return [(i, j) for i in range(3) for j in range(3) if board[i][j] == ' ']
def minimax(board, is_maximizing):
    if check_winner(board, 'O'):
        return 1
    if check_winner(board, 'X'):
        return -1
    if is_full(board):
        return 0
    if is_maximizing:
        best_score = -math.inf
        for (i, j) in get_empty_cells(board):
            board[i][j] = 'O'
            score = minimax(board, False)
            board[i][j] = ' '
            best_score = max(score, best_score)
        return best_score
    else:
        best_score = math.inf
        for (i, j) in get_empty_cells(board):
            board[i][j] = 'X'
            score = minimax(board, True)
            board[i][j] = ' '
            best_score = min(score, best_score)
        return best_score
def best_move(board):
    best_score = -math.inf
    move = None
    for (i, j) in get_empty_cells(board):
        board[i][j] = 'O'
        score = minimax(board, False)
        board[i][j] = ' '
        if score > best_score:
            best_score = score
            move = (i, j)
    return move
def play_game():
    board = [[' ' for _ in range(3)] for _ in range(3)]
    print("Tic Tac Toe - You (X) vs AI (O)")
    while True:
        print_board(board)
        empty = get_empty_cells(board)
        if not empty or check_winner(board, 'X') or check_winner(board, 'O'):
            break
        move = empty[0]
        board[move[0]][move[1]] = 'X'
        print(f"You move to {move}")
        if check_winner(board, 'X'):
            print_board(board)
            print("🎉 You win!")
            return
        move = best_move(board)
        board[move[0]][move[1]] = 'O'
        print(f"AI moves to {move}")
        if check_winner(board, 'O'):
            print_board(board)
            print("💻 AI wins!")
            return
        if is_full(board):
            print("It's a draw!")
            return
play_game()
