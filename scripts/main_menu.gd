extends Control

@onready var title: Label = $MarginContainer/VBoxContainer/GameTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_title_animation()

func start_title_animation():
	await get_tree().process_frame
	title.pivot_offset = title.size / 2
	var float_speed := 0.6  
	var scale_speed := 0.6
	var tween = create_tween().set_loops().set_parallel(true)
	tween.tween_property(title, "position:y", title.position.y - 10, float_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(title, "position:y", title.position.y, float_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
#Scene change from main menu to profile auswahl
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/profilauswahl.tscn")
