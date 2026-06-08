extends Node2D

func _ready() -> void:
	$SpeechBubble.hide()

func say(text: String) -> void:    ##Text in der Blase anzeigen, 3 Sekunden warten
	$SpeechBubble/DialogLabel.text = text
	$SpeechBubble.show()
	await get_tree().create_timer(3.0).timeout
	if is_instance_valid($SpeechBubble):
		$SpeechBubble.hide()

func on_game_start() -> void:
	say("Hallo! Schau dir die Produkte genau an!")

func on_correct() -> void:
	say("Gute Wahl! Passt zu deinem Profil.")

func on_wrong(allergen: String) -> void:
	say("Vorsicht! Enthält " + allergen + " – passt nicht zu deinem Profil.")

func on_round_end() -> void: ##Dialog am Rundenende
	say("Gut gespielt! Schau dir die Ergebnisse an.")

func on_conflict(product_name: String) -> void:    ##Dialog wenn dasselbe Produkt für S1 und S2 unterschiedlich bewertet wird
	say("Hmm – " + product_name + " passt für mich, aber auf der anderen Seite nicht!")

func apply_side_style(side: String) -> void:
	var sprite := $AgentSprite as Sprite2D
	match side:
		"S1", "blue":
			#sprite.modulate = Color(0.3, 0.6, 1.0)
			sprite.scale = Vector2.ONE
			$SpeechBubble.position = Vector2(-150, -130)
		"S2", "orange":
			#sprite.modulate = Color(1.0, 0.6, 0.2)
			sprite.scale = Vector2.ONE
			$SpeechBubble.position = Vector2(-150, 130)
