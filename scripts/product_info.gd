extends Control

func _ready() -> void:
	show_info({
		"name": "Hafermilch",
		"inhaltsstoffe": "Wasser, Hafer 10%",
		"allergene": "Gluten",
		"siegel": "vegan"
	})

func show_info(product: Dictionary):
	$Panel/VBoxContainer/LabelName.text = product["name"]
	$Panel/VBoxContainer/LabelInhaltsstoffe.text = "Inhaltsstoffe: " + product["inhaltsstoffe"]
	$Panel/VBoxContainer/LabelAllergene.text = "Allergene: " + product["allergene"]
	$Panel/VBoxContainer/LabelSiegel.text = "Siegel: " + product["siegel"]
	show()

func _on_close_button_pressed() -> void:
	hide()
