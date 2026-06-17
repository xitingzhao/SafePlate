extends Node

static func check_product(profile: String, product_data: Dictionary) -> Dictionary:

	var result := {
		"correct": false,
		"message": ""
	}

	var profile_norm := profile.strip_edges().to_lower()

	var tags := []
	for t in product_data["tags"]:
		tags.append(t.strip_edges().to_lower())

	if tags.has(profile_norm):
		result["correct"] = true
		result["message"] = "Richtig, %s passt zu %s." % [product_data["name"], profile]
		return result

	match profile_norm:

		"vegan":
			result["message"] = "Falsch %s ist nicht vegan." % product_data["name"]

		"vegetarisch":
			result["message"] = "Falsch %s ist nicht vegetarisch." % product_data["name"]

		"glutenfrei":
			result["message"] = "Falsch, enthält Gluten."

		"laktosefrei":
			result["message"] = "Falsch, enthält Laktose."

		_:
			result["message"] = "Falsch, Produkt ungeeignet."

	return result
