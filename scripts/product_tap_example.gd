extends Node2D

## Hilfsfunktion für Teil von Jonas: Tap öffnet Info, Drag startet Bewegung.
## An Product-Node hängen und in _input() aufrufen: _tap_detector.handle_input(event)

@export var product_data: Dictionary = {
	"name": "Hafermilch",
	"inhaltsstoffe": "Wasser, Hafer 10%",
	"allergene": "Gluten",
	"siegel": "vegan"
}

var _tap_detector: TapDetector
var _dragging := false
var _product_info: Control

func _ready() -> void:
	_tap_detector = TapDetector.new()
	add_child(_tap_detector)
	_tap_detector.tapped.connect(_on_tapped)
	_tap_detector.drag_started.connect(_on_drag_started)

func bind_product_info(product_info: Control) -> void:
	_product_info = product_info

func _input(event: InputEvent) -> void:
	_tap_detector.handle_input(event)

func _on_tapped() -> void:
	if _product_info:
		_product_info.show_info(product_data)

func _on_drag_started() -> void:
	_dragging = true

func is_dragging() -> bool:
	return _dragging

func reset_drag() -> void:
	_dragging = false
