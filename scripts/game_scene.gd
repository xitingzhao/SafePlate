extends Control

@onready var agent_blue: Node2D = $AgentBlue
@onready var agent_orange: Node2D = $AgentOrange
@onready var feedback = $FeedbackOverlay

const Evaluator = preload("res://scripts/Evaluator.gd")
@onready var product_info: Control = $ProductInfo
@onready var shelf_area: Node = $ShelfArea
@onready var cart_area_1: Control = $Player1Area/CartArea1
@onready var cart_area_2: Control = $Player2Area/CartArea2
var cart_area_1_products: Array = []
var cart_area_2_products: Array = []

var product_scene := preload("res://scenes/product.tscn")

var active_drags := {}

func _ready() -> void:
	print(feedback)
	$Player1Area/ProfileArea1/VBoxContainer/ProfilArt.text = GameGlobal.player1
	$Player2Area/ProfileArea2/VBoxContainer/ProfilArt.text = GameGlobal.player2
	
	AgentSetup.place_in_game(self, agent_blue, agent_orange)
	load_products_from_json()


func end_game():
	AgentSetup.notify_round_end(agent_blue)
	AgentSetup.notify_round_end(agent_orange)

	await get_tree().create_timer(0.5).timeout

	get_tree().change_scene_to_file("res://scenes/EndScreen.tscn")

func evaluate_live(player: String, product_data: Dictionary, agent: Node2D) -> void:
	var result = Evaluator.check_product(player, product_data)

	feedback.show_feedback(result["correct"], result["message"])

	if result["correct"]:
		AgentSetup.notify_correct(agent)
	else:
		AgentSetup.notify_wrong(agent, result["message"])

func evaluate_end() -> void:
	for product in cart_area_1_products:
		var result = Evaluator.check_product(GameGlobal.player1, product.product_data)

		if result["correct"]:
			GameGlobal.player1_correct += 1
		else:
			GameGlobal.player1_wrong += 1

	for product in cart_area_2_products:
		var result = Evaluator.check_product(GameGlobal.player2, product.product_data)

		if result["correct"]:
			GameGlobal.player2_correct += 1
		else:
			GameGlobal.player2_wrong += 1

	end_game()
	
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
	for touch_id in active_drags.keys():
		var drag = active_drags[touch_id]
		drag.product.global_position = drag.position + drag.offset
		

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			for product in shelf_area.get_children():
				if product.has_method("is_point_over") and product.is_point_over(event.position):
					active_drags[event.index] = {
						"product": product,
						"offset": product.global_position - event.position,
						"position": event.position
					}
					product.z_index = 20
					break
		else:
			if active_drags.has(event.index):
				var product = active_drags[event.index].product
				check_cart_drop(product)
				product.z_index = 5
				active_drags.erase(event.index)

	if event is InputEventScreenDrag:
		if active_drags.has(event.index):
			active_drags[event.index].position = event.position

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for product in shelf_area.get_children():
				if product.has_method("is_point_over") and product.is_point_over(event.position):
					active_drags[-1] = {
						"product": product,
						"offset": product.global_position - event.position,
						"position": event.position
					}
					product.z_index = 20
					break
		else:
			if active_drags.has(-1):
				var product = active_drags[-1].product
				check_cart_drop(product)
				product.z_index = 5
				active_drags.erase(-1)

	if event is InputEventMouseMotion:
		if active_drags.has(-1):
			active_drags[-1].position = event.position

func check_cart_drop(product: Node2D) -> void:
	var in_cart_1 := is_inside_control(product.global_position, cart_area_1)
	var in_cart_2 := is_inside_control(product.global_position, cart_area_2)

	if product in cart_area_1_products and not in_cart_1:
		remove_from_cart(product, cart_area_1_products)

	if product in cart_area_2_products and not in_cart_2:
		remove_from_cart(product, cart_area_2_products)

	if in_cart_1:
		add_to_cart(product, cart_area_1_products)
		evaluate_live(GameGlobal.player1, product.product_data, agent_orange)
		return

	if in_cart_2:
		add_to_cart(product, cart_area_2_products)
		evaluate_live(GameGlobal.player2, product.product_data, agent_blue)
		return
	
func is_inside_control(global_pos: Vector2, control: Control) -> bool:
	var local_pos := control.get_global_transform().affine_inverse() * global_pos
	var rect := Rect2(Vector2.ZERO, control.size)
	return rect.has_point(local_pos)


func remove_from_cart(product: Node2D, cart: Array):
	if product in cart:
		cart.erase(product)


func add_to_cart(product: Node2D, cart: Array):
	if product not in cart:
		cart.append(product)


func _on_end_button_pressed() -> void:
	evaluate_end()
