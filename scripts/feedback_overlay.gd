extends CanvasLayer

@onready var panel = $Panel
@onready var label = $Panel/Label

func show_feedback(correct: bool, text: String):

	if correct:
		panel.modulate = Color.GREEN
	else:
		panel.modulate = Color.RED

	label.text = text
	visible = true

	await get_tree().create_timer(2.0).timeout

	visible = false
	
func _ready():
	visible = false
