extends Area2D

var product_id: int = 0
var product_name: String = ""
var ingredients: String = ""
var allergens: Array = []
var tags: Array = []

var product_data: Dictionary = {}
var product_info: Control = null

var dragging := false
var drag_offset := Vector2.ZERO

@onready var sprite: Sprite2D = $ProductSprite
@onready var name_label: Label = $NameLabel

func setup(data: Dictionary) -> void:
	product_data = data

	name_label.text = data.get("name", "")

	if data.has("image"):
		var path: String = "res://assets/products/" + str(data["image"])
		sprite.texture = load(path) as Texture2D
		sprite.scale = Vector2(0.15, 0.15)

	name_label.position = Vector2(-50, 55)
	name_label.size = Vector2(100, 30)
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.z_index = 10

func bind_product_info(info: Control) -> void:
	product_info = info

func is_mouse_over() -> bool:
	var mouse_pos := get_global_mouse_position()
	return global_position.distance_to(mouse_pos) < 100
