extends Button
## Exits the application when pressed


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	get_tree().quit()
