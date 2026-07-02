extends Control

@onready var title: Label = $MarginContainer/VBoxContainer/GameTitle
@onready var settings_overlay: ColorRect = $SettingsOverlay
@onready var volume_slider: HSlider = $SettingsOverlay/SettingsPanel/VBoxContainer/VolumeHBox/VolumeSlider
@onready var volume_value_label: Label = $SettingsOverlay/SettingsPanel/VBoxContainer/VolumeHBox/VolumeValueLabel

func _ready() -> void:
	$AnleitungOverlay.hide()
	start_title_animation()

func start_title_animation():
	await get_tree().process_frame
	title.pivot_offset = title.size / 2
	var float_speed := 0.6
	var tween = create_tween().set_loops().set_parallel(true)
	tween.tween_property(title, "position:y", title.position.y - 10, float_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(title, "position:y", title.position.y, float_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/profilauswahl.tscn")

func _on_anleitung_button_pressed() -> void:
	$AnleitungOverlay.show()

func _on_anleitung_close_pressed() -> void:
	$AnleitungOverlay.hide()
func _on_einstellungen_button_pressed() -> void:
	settings_overlay.visible = true
	var current := AudioManager.get_music_volume() * 100.0
	volume_slider.value = current
	_update_volume_label(current)

func _on_close_button_pressed() -> void:
	settings_overlay.visible = false

func _on_volume_slider_value_changed(value: float) -> void:
	AudioManager.set_music_volume(value / 100.0)
	_update_volume_label(value)

func _update_volume_label(value: float) -> void:
	volume_value_label.text = "%d%%" % int(value)
