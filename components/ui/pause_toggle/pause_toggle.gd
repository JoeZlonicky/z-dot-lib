extends Node


@export var canvas_layer: CanvasLayer


func _ready() -> void:
	if not canvas_layer:
		return
	
	canvas_layer.visibility_changed.connect(_on_canvas_layer_visibility_changed)


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause_toggle"):
		return
	
	if get_tree().paused:
		get_tree().paused = false
		if canvas_layer:
			canvas_layer.hide()
	else:
		get_tree().paused = true
		if canvas_layer:
			canvas_layer.show()
	
	get_viewport().set_input_as_handled()


func _on_canvas_layer_visibility_changed() -> void:
	if not canvas_layer.visible and get_tree().paused:
		get_tree().paused = false
