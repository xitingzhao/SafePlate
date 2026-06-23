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
@onready var collision_shape := $CollisionShape2D

func setup(data: Dictionary) -> void:
	product_data = data

	name_label.text = data.get("name", "")

	if data.has("image"):
		var path: String = "res://assets/products/" + str(data["image"])
		sprite.texture = load(path) as Texture2D
		sprite.scale = Vector2(0.15, 0.15)
		
	if data.has("collision_width") and data.has("collision_height"):
		var new_shape := RectangleShape2D.new()
		new_shape.size = Vector2(
			float(data["collision_width"]),
			float(data["collision_height"])
	)
		collision_shape.shape = new_shape

		print(data.get("name", ""), " Collision: ", new_shape.size)

	name_label.position = Vector2(-50, 55)
	name_label.size = Vector2(100, 30)
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.z_index = 10

func bind_product_info(info: Control) -> void:
	product_info = info

func is_mouse_over() -> bool:
	var shape := collision_shape.shape as RectangleShape2D
	if shape == null:
		return false

	var local_mouse: Vector2 = collision_shape.global_transform.affine_inverse() * get_global_mouse_position()
	var rect := Rect2(-shape.size / 2.0, shape.size)

	return rect.has_point(local_mouse)
