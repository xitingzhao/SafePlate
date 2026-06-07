extends Control

func _ready() -> void:
	hide()

func show_info(product: Dictionary) -> void:
	$Panel/VBoxContainer/LabelName.text = product["name"]
	$Panel/VBoxContainer/LabelInhaltsstoffe.text = "Inhaltsstoffe: " + product["inhaltsstoffe"]
	$Panel/VBoxContainer/LabelAllergene.text = "Allergene: " + product["allergene"]
	$Panel/VBoxContainer/LabelSiegel.text = "Siegel: " + product["siegel"]
	show()

func _on_close_button_pressed() -> void:
	hide()
