extends Node
class_name TapDetector

signal tapped   ##Signal: kurzer Tap ohne Bewegung
signal drag_started   ##Signal: Finger hat sich mehr als 10 px bewegt

const DRAG_THRESHOLD := 10.0

var _press_pos := Vector2.ZERO
var _is_dragging := false
var _pointer_down := false

func handle_input(event: InputEvent) -> bool:   ##In _input() aufrufen — wertet Touch aus
	if event is InputEventScreenTouch:
		return _handle_press(event.position, event.pressed)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		return _handle_press(event.position, event.pressed)
	if event is InputEventScreenDrag and _pointer_down:
		return _handle_motion(event.position)
	if event is InputEventMouseMotion and _pointer_down:
		return _handle_motion(event.position)
	return false

func _handle_press(pos: Vector2, pressed: bool) -> bool:   ##Drücken/Loslassen verarbeiten
	if pressed:
		_press_pos = pos
		_is_dragging = false
		_pointer_down = true
	elif _pointer_down:
		_pointer_down = false
		if not _is_dragging:
			tapped.emit()
			return true
	return false

func _handle_motion(pos: Vector2) -> bool:   ##Drücken/Loslassen verarbeiten
	if pos.distance_to(_press_pos) <= DRAG_THRESHOLD:
		return false
	if not _is_dragging:
		_is_dragging = true
		drag_started.emit()
		return true
	return false
