extends Button
## Toggles between fullscreen and windowed mode on being pressed


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	DisplayUtility.toggle_fullscreen()
