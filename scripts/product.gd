extends Node2D

@export var product_id: int = 0
@export var product_name: String = ""

@export var allergens: Array[String] = []
@export var tags: Array[String] = []

@onready var name_label = $NameLabel

func _ready():
	name_label.text = product_name
