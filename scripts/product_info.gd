extends Control

func _ready() -> void:
	hide()

func show_info(product: Dictionary) -> void:
	$Panel/VBoxContainer/LabelName.text = product["name"]
	$Panel/VBoxContainer/LabelInhaltsstoffe.text = "Inhaltsstoffe: " + product["ingredients"]
	$Panel/VBoxContainer/LabelAllergene.text = "Allergene: " + ", ".join(product["allergens"])
	$Panel/VBoxContainer/LabelSiegel.text = "Tags: " + ", ".join(product["tags"])
	show()

func _on_close_button_pressed() -> void:
	hide()
