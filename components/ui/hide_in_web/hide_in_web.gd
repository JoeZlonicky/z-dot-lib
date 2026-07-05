extends Node


@export var canvas_items: Array[CanvasItem]


func _ready() -> void:
	if OS.get_name() != "Web":
		return
	
	for c in canvas_items:
		if c: c.hide()
