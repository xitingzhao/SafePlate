extends Control

func _ready():

	$Player1Label.text = (
		"Profil: %s\nRichtig: %d\nFalsch: %d"
		% [
			GameGlobal.player1,
			GameGlobal.player1_correct,
			GameGlobal.player1_wrong
		]
	)

	$Player2Label.text = (
		"Profil: %s\nRichtig: %d\nFalsch: %d"
		% [
			GameGlobal.player2,
			GameGlobal.player2_correct,
			GameGlobal.player2_wrong
		]
	)

func _on_replay_button_pressed():

	GameGlobal.reset_game()

	get_tree().change_scene_to_file(
		"res://scenes/menu/profilauswahl.tscn"
	)
