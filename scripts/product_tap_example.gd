extends Area2D

@export var product_data: Dictionary = {
	"name": "Hafermilch",
	"inhaltsstoffe": "Wasser, Hafer 10%",
	"allergene": "Gluten",
	"siegel": "vegan"
}

var _product_info: Control

func bind_product_info(product_info: Control) -> void:
	_product_info = product_info

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if _product_info:
			_product_info.show_info(product_data)
