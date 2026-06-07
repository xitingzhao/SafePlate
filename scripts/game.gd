extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameGlobal.player1)
	print(GameGlobal.player2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
