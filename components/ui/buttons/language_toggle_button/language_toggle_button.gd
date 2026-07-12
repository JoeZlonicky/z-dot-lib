extends Button
# Toggles between Japanese and English when pressed


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	LangUtility.toggle_japanese()
