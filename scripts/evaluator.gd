extends Node

static func check_product(profile: String, product_data: Dictionary) -> Dictionary:

	var result := {
		"correct": false,
		"message": ""
	}

	if product_data["tags"].has(profile):
		result.correct = true
		result.message = "Richtig entschieden!"
	else:
		result.correct = false

		match profile:
			"Vegan":
				result.message = "Überlege nochmal, ob es zu Vegan passt."

			"Vegetarisch":
				result.message = "Überlege nochmal, ob es zu Vegetarisch passt."

			"Glutenfrei":
				result.message = "Überlege nochmal, ob es glutenfrei ist."

			"Laktosefrei":
				result.message = "Überlege nochmal, ob es laktosefrei ist."

			_:
				result.message = "ungeeignet"

	return result
