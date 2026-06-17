extends Control

@onready var agent_blue: Node2D = $AgentBlue
@onready var agent_orange: Node2D = $AgentOrange
@onready var feedback = $FeedbackOverlay

const Evaluator = preload("res://scripts/Evaluator.gd")
const TOTAL_PRODUCTS = 10
@onready var product_info: Control = $ProductInfo
@onready var shelf_area: Node = $ShelfArea
@onready var cart_area_1: Control = $Player1Area/CartArea1
@onready var cart_area_2: Control = $Player2Area/CartArea2

var product_scene := preload("res://scenes/product.tscn")

var dragged_product: Node2D = null
var drag_offset := Vector2.ZERO

func _ready() -> void:
	$Player1Area/ProfileArea1/VBoxContainer/ProfilArt.text = GameGlobal.player1
	$Player2Area/ProfileArea2/VBoxContainer/ProfilArt.text = GameGlobal.player2
	
	AgentSetup.place_in_game(self, agent_blue, agent_orange)
	load_products_from_json()
	
func check_round_end():

	if GameGlobal.evaluated_products >= TOTAL_PRODUCTS:

		AgentSetup.notify_round_end(agent_blue)
		AgentSetup.notify_round_end(agent_orange)

		await get_tree().create_timer(1.0).timeout

		get_tree().change_scene_to_file(
			"res://scenes/EndScreen.tscn"
		)
	
func evaluate_player1(product_data: Dictionary):

	var result = Evaluator.check_product(
		GameGlobal.player1,
		product_data
	)

	if result.correct:
		GameGlobal.player1_correct += 1
		AgentSetup.notify_correct(agent_blue)
	else:
		GameGlobal.player1_wrong += 1
		AgentSetup.notify_wrong(agent_blue, result.message)

	GameGlobal.evaluated_products += 1

	feedback.show_feedback(
		result.correct,
		result.message
	)

	check_round_end()


func evaluate_player2(product_data: Dictionary):

	var result = Evaluator.check_product(
		GameGlobal.player2,
		product_data
	)

	if result.correct:
		GameGlobal.player2_correct += 1
		AgentSetup.notify_correct(agent_orange)
	else:
		GameGlobal.player2_wrong += 1
		AgentSetup.notify_wrong(agent_orange, result.message)

	GameGlobal.evaluated_products += 1

	feedback.show_feedback(
		result.correct,
		result.message
	)

	check_round_end()


func load_products_from_json() -> void:
	var file := FileAccess.open("res://data/products.json", FileAccess.READ)

	if file == null:
		print("products.json konnte nicht geladen werden")
		return

	var json_text := file.get_as_text()
	var products = JSON.parse_string(json_text)

	if products == null:
		print("JSON fehlerhaft")
		return

	var columns := 5
	var spacing_x := 160
	var spacing_y := 120
	var start_x := 100
	var start_y := 80

	var index := 0

	for product_data in products:
		var product = product_scene.instantiate()
		product.name = str(product_data.get("name", "Produkt"))
		shelf_area.add_child(product)

		product.z_index = 5

		var x := start_x + (index % columns) * spacing_x
		var y := start_y + int(index / columns) * spacing_y
		product.position = Vector2(x, y)

		product.setup(product_data)

		if product.has_method("bind_product_info"):
			product.bind_product_info(product_info)

		index += 1


func _process(_delta: float) -> void:
	if dragged_product != null:
		dragged_product.global_position = get_global_mouse_position() + drag_offset
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("Klick erkannt in GameScene: ", event.position)

		if event.pressed:
			for product in shelf_area.get_children():
				if product.has_method("is_mouse_over"):
					print("prüfe Produkt: ", product.name)

					if product.is_mouse_over():
						print("DRAG START: ", product.name)
						dragged_product = product
						drag_offset = product.global_position - get_global_mouse_position()
						product.z_index = 20
						break
		else:
			if dragged_product != null:
				print("DRAG STOP")
				check_cart_drop(dragged_product)
				dragged_product.z_index = 5
				dragged_product = null

func check_cart_drop(product: Node2D) -> void:
	if is_inside_control(product.global_position, cart_area_1):
		print("Produkt liegt im Warenkorb von Spieler 1: ", product.name)
		return

	if is_inside_control(product.global_position, cart_area_2):
		print("Produkt liegt im Warenkorb von Spieler 2: ", product.name)
		return

	print("Produkt wurde in keinen Warenkorb gelegt")
	
func is_inside_control(global_pos: Vector2, control: Control) -> bool:
	var local_pos := control.get_global_transform().affine_inverse() * global_pos
	var rect := Rect2(Vector2.ZERO, control.size)
	return rect.has_point(local_pos)
