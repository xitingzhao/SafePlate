extends Control

@onready var s1_cards: HBoxContainer = $S1/PanelContainer/VBoxContainer/HBoxContainer
@onready var s2_cards: HBoxContainer = $S2/PanelContainer/VBoxContainer/HBoxContainer
@onready var s1_ready_button: Button = $S1/PanelContainer/VBoxContainer/S1Button
@onready var s2_ready_button: Button = $S2/PanelContainer/VBoxContainer/S2Button

var is_s1_ready: bool = false
var is_s2_ready: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	s1_ready_button.toggle_mode = true
	s2_ready_button.toggle_mode = true
	s1_ready_button.toggled.connect(_on_s1_ready_toggled)
	s2_ready_button.toggled.connect(_on_s2_ready_toggled)
	s1_ready_button.text = "Bereit?"
	s2_ready_button.text = "Bereit?"
	
	for card in s1_cards.get_children():
		card.pressed.connect(func():_on_s1_card_selected(card))
	for card in s2_cards.get_children():
		card.pressed.connect(func():_on_s2_card_selected(card))

func _on_s1_card_selected(selected_card: Button):
	if is_s1_ready:
		return
	GameGlobal.player1 = selected_card.text

func _on_s2_card_selected(selected_card: Button):
	if is_s1_ready:
		return
	GameGlobal.player2 = selected_card.text

func _on_s1_ready_toggled(is_pressed:bool):
	if is_pressed and (GameGlobal.player1 == "" or GameGlobal.player1 == null):
		s1_ready_button.set_pressed_no_signal(false)
		return
	is_s1_ready = is_pressed
	if is_pressed:
		s1_ready_button.text = "Bereit!"
		s1_ready_button.modulate = Color.GREEN
	else:
		s1_ready_button.text = "Bereit?"
		s1_ready_button.modulate = Color.WHITE
	check_both_ready()

func _on_s2_ready_toggled(is_pressed: bool):
	if is_pressed and (GameGlobal.player2 == "" or GameGlobal.player2 == null):
		s2_ready_button.set_pressed_no_signal(false)
		return
	is_s2_ready = is_pressed
	if is_pressed:
		s2_ready_button.text = "Bereit!"
		s2_ready_button.modulate = Color.GREEN
	else:
		s2_ready_button.text = "Bereit?"
		s2_ready_button.modulate = Color.WHITE
		
	check_both_ready()
	
func check_both_ready():
	if is_s1_ready and is_s2_ready:
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/game/GameScene.tscn")
