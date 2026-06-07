extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#change scene from profile auswahl to game
func _on_start_button_pressed() -> void:
	GameGlobal.player1 = $VBoxContainer/S1Panel/S1OptionButton.get_item_text($VBoxContainer/S1Panel/S1OptionButton.selected)
	GameGlobal.player2 = $VBoxContainer/S2Panel/S2OptionButton.get_item_text($VBoxContainer/S2Panel/S2OptionButton.selected)
	get_tree().change_scene_to_file("res://scenes/game/Game.tscn")
