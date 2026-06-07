extends Area2D

@export var product_id: int = 0
@export var product_name: String = ""
@export var allergens: Array[String] = []
@export var tags: Array[String] = []

@onready var name_label: Label = $NameLabel

var dragging := false
var active_touch_index := -1
var drag_offset := Vector2.ZERO
var start_position := Vector2.ZERO

func _ready() -> void:
	name_label.text = product_name
	start_position = global_position

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and not dragging:
			dragging = true
			active_touch_index = event.index
			drag_offset = global_position - event.position
			z_index = 10

		elif not event.pressed and event.index == active_touch_index:
			dragging = false
			active_touch_index = -1
			z_index = 0

	if event is InputEventScreenDrag:
		if dragging and event.index == active_touch_index:
			global_position = event.position + drag_offset
