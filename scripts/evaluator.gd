extends Node

static func check_product(profile: String, product_data: Dictionary) -> Dictionary:

	var result := {
		"correct": false,
		"message": ""
	}

	if product_data["tags"].has(profile):
		result.correct = true
		result.message = "Richtig, " + product_data["name"] + " passt zu " + profile + "."
		return result

	match profile:

		"Vegan":
			result.message = "Falsch " + product_data["name"] + " ist nicht vegan."

		"Vegetarisch":
			result.message = "Falsch " + product_data["name"] + " ist nicht vegetarisch."

		"Glutenfrei":
			result.message = "Falsch, Enthält Gluten."

		"Laktosefrei":
			result.message = "Falsch, Enthält Laktose."

		_:
			result.message = "Falsch, Produkt ungeeignet."

	return result
