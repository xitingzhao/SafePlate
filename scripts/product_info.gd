extends Control

func _ready() -> void:
	hide()

func show_info(product: Dictionary) -> void:
	$Panel/VBoxContainer/LabelName.text = product.get("name", "")

	var ingredients = product.get("ingredients", [])
	var ingredients_text := ", ".join(ingredients) if ingredients is Array else str(ingredients)
	$Panel/VBoxContainer/LabelInhaltsstoffe.text = "Inhaltsstoffe: " + ingredients_text
	show()

func _on_close_button_pressed() -> void:
	hide()
