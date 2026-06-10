extends Control
# definitiert 2 Agenten 
@onready var agent_blue: Node2D = $AgentBlue
@onready var agent_orange: Node2D = $AgentOrange
@onready var feedback = $FeedbackOverlay

const Evaluator = preload("res://scripts/Evaluator.gd")
const TOTAL_PRODUCTS = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(GameGlobal.player1)
	print(GameGlobal.player2)
	$Player1Area/ProfileArea1/VBoxContainer/ProfilArt.text = GameGlobal.player1
	$Player2Area/ProfileArea2/VBoxContainer/ProflArt.text = GameGlobal.player2
	
	AgentSetup.place_in_game(self,agent_blue,agent_orange)
	
	
func check_round_end():

	if GameGlobal.evaluated_products >= TOTAL_PRODUCTS:
		get_tree().change_scene_to_file(
			"res://scenes/EndScreen.tscn"
		)
	
func evaluate_player1(product_data: Dictionary):

	var result = Evaluator.check_product(
		GameGlobal.player1,
		product_data
	)

	if result.correct:
		GameGlobal.player1_correct += 1
	else:
		GameGlobal.player1_wrong += 1

	GameGlobal.evaluated_products += 1

	feedback.show_feedback(
		result.correct,
		result.message
	)

	check_round_end()


func evaluate_player2(product_data: Dictionary):

	var result = Evaluator.check_product(
		GameGlobal.player2,
		product_data
	)

	if result.correct:
		GameGlobal.player2_correct += 1
	else:
		GameGlobal.player2_wrong += 1

	GameGlobal.evaluated_products += 1

	feedback.show_feedback(
		result.correct,
		result.message
	)

	check_round_end()
