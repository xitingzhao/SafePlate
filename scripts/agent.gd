extends Node2D

# Wird aufgerufen wenn Scene startet
func _ready():
	# Sprechblase am Anfang verstecken
	$SpeechBubble.hide()

# zeigt Text für 3 Sekunden dann verschwindet 
func say(text: String):
	$SpeechBubble/DialogLabel.text = text
	$SpeechBubble.show()
	await get_tree().create_timer(3.0).timeout
	$SpeechBubble.hide()
