extends Node


@export_category(ExportCategories.REQUIRED)
@export var control: Control


func _ready() -> void:
	if control:
		control.visibility_changed.connect(_on_control_visiblity_changed)
		_focus_if_visible()
	else:
		push_warning(ConfigurationWarnings.missing_required_properties(self))


func _focus_if_visible() -> void:
	if not control or not control.is_visible_in_tree():
		return
	
	InputDeviceListener.focus_depending_on_device(control)


func _on_control_visiblity_changed() -> void:
	_focus_if_visible()
