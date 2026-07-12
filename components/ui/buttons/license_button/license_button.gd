extends Button
## Opens the Godot license page when pressed


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	OS.shell_open("https://godotengine.org/license/")
