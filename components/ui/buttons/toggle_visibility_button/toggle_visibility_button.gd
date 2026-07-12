extends Button
## Shows or hides [CanvasLayer] or [CanvasItem]s when pressed


@export var show_canvas_items: Array[CanvasItem]
@export var show_canvas_layers: Array[CanvasLayer]

@export var hide_canvas_items: Array[CanvasItem]
@export var hide_canvas_layers: Array[CanvasLayer]

@export var trigger_on_ui_cancel: bool = false


func _ready() -> void:
	pressed.connect(_on_pressed)


func _unhandled_input(event: InputEvent) -> void:
	if not trigger_on_ui_cancel: return
	
	if event.is_action_pressed("ui_cancel") and is_visible_in_tree():
		_on_pressed()
		get_viewport().set_input_as_handled()


func _on_pressed() -> void:
	for c in show_canvas_items:
		if c: c.show()
	for c in show_canvas_layers:
		if c: c.show()
	for c in hide_canvas_items:
		if c: c.hide()
	for c in hide_canvas_layers:
		if c: c.hide()
