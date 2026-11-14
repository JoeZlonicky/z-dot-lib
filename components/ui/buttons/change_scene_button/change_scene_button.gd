extends Button
## Changes the current scene when pressed


@export_category(ExportCategories.REQUIRED)
@export_file("*.tscn") var scene_file: String


func _ready() -> void:
	if not scene_file:
		push_warning(ConfigurationWarnings.missing_required_properties(self))
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if not scene_file:
		return
	
	get_tree().change_scene_to_file(scene_file)
