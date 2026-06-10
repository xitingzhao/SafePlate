extends Node

var player1 = ""
var player2 = ""

# --- player 1 ----
var player1_correct = 0
var player1_wrong = 0

# --- player 2 ----
var player2_correct = 0
var player2_wrong = 0

var evaluated_products = 0

func reset_game():
	player1_correct = 0
	player1_wrong = 0

	player2_correct = 0
	player2_wrong = 0

	evaluated_products = 0
