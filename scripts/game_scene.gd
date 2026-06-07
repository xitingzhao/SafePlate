extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameGlobal.player1)
	print(GameGlobal.player2)
	$Player1Area/ProfileArea1/VBoxContainer/ProfilArt.text = GameGlobal.player1
	$Player2Area/ProfileArea2/VBoxContainer/ProflArt.text = GameGlobal.player2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
