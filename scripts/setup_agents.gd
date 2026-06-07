extends RefCounted
class_name AgentSetup

static func place_in_game(game: Node, agent_blue: Node2D, agent_orange: Node2D) -> void: ##	
##Positioniert beide Agenten, setzt Farben, startet Begrüßungsdialog
	agent_blue.position = Vector2(80, 80)
	agent_blue.apply_side_style("S1")

	agent_orange.position = Vector2(1870, 980)
	agent_orange.apply_side_style("S2")

	agent_blue.on_game_start()
	agent_orange.on_game_start()

static func notify_conflict(agent_blue: Node2D, agent_orange: Node2D, product_name: String) -> void:
##Beide Agenten reagieren auf Widerspruch
	agent_blue.on_conflict(product_name)
	agent_orange.on_conflict(product_name)

static func notify_correct(agent: Node2D) -> void:
	agent.on_correct()

static func notify_wrong(agent: Node2D, allergen: String) -> void:
	agent.on_wrong(allergen)

static func notify_round_end(agent: Node2D) -> void:
	agent.on_round_end()
