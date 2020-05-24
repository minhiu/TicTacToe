# TicTacToe
CECS 343
Name: Tic-Tac-Toe UC

Identifier UC-TTT (A unique identifier for this use case, e.g. UC10)

Description A human user plays a game of tic-tac toe from start to finish. The user initializes a tic-tac-toe game, chooses the amount of time they want to make a move, then gets assigned an icon at random. The user plays against an AI which gets assigned a different icon. Each player takes turns until the game ends in one of the players winning or a tie is reached. At this point, the user has the option to start another game.(A couple of sentences or a paragraph describing the basic idea of the use case)

Goal For the tic-tac-toe game to begin and end with the user winning, losing, or getting a tie. (The business goal of the initiating actor)

Preconditions (List the state(s) the system can be in before this use case starts)
The user has and is able to run the game on their computer.

Assumptions (Optional, List all assumptions that have been made)
The user’s hardware isn’t faulty
The user isn’t hacking.

Frequency As often as the human user runs the program..(Approximately how often this use case is realized, e.g., once a week, 500 times a day, etc.)

Basic Course (Describe the “normal” processing path, aka, the Happy Path)
Human user initializes a game.
Human user states the amount of time they wish to have for each move
Human user gets assigned a player icon (“X” or “O”) with the AI getting assigned the opposing icon.
Whoever gets “X” goes first
Either player makes a move.
The other player makes a move.
Program recommends moves to the user to help them win.
Game ends when one player beats the other, when 3 of that player’s icons line up.
Human player elects to start another game and chooses a new alloted time.

Exception Course A: The user attempts to move into an occupied square.
Condition: The user makes a move that has already previously been made within the same game.
Human user initializes a game.
Human user gets assigned a player icon (“X” or “O”) with the AI getting assigned the opposing icon.
The AI makes a move.
The human user attempts to make a move into an occupied space
The game denies the user’s request and the user is asked again to make a move, repeatedly if necessary.
Eventually the user might make a valid move.
Game ends in a tie as neither of the players have won and no more moves can be made.
Human player elects to start another game.

Exception Course B: The user cannot hope to win the game.
Condition: The user stops playing and does not place a move.
B.1 Human user initializes a game.
B.2 Human user gets assigned a player icon (“X” or “O”) with the AI getting assigned the opposing icon.
B.3 The AI makes a move.
B.4 The human user does not do anything.
B.5 The AI chooses a random empty square for the user to make a move in
B.5 The program continues to run, until either the user or AI wins.

Exception Course C: The AI detects that the game must end in a tie
Condition: The previous moves made on the board guarantee that the game must end in a tie.
C. 1 Human user initializes a game.
C. 2 Human user gets assigned a player icon (“X” or “O”) with the AI getting assigned the opposing icon.
C. 3 Either player makes a move.
C. 4 The other player makes a move.
C. 5 The AI detects that, based on previously placed moves, the game must end in a tie.
C. 7 Game ends in a tie as neither of the players have won and no more moves can be made.
C. 8 Human player elects to start another game.

Post conditions (List the state(s) the system can be in when this use case ends)
The user elected to start another game, starting from the beginning of the course.
The user has stopped playing and the program is no longer running.

Actors (List of actors that participate in the use case)
	The human user and AI.

Included Use Cases (Optional, List of use cases that this use case includes)


Extended Use Case (Optional, The use case, if any, that this use case extends)


Notes
List any "to dos" concerns to be addressed,  important decisions made during the development of this use case, …

In a course, some steps are repeated while others only run once.
The user might not ever make a valid move, resulting in the system staying stuck in the time selection screen

