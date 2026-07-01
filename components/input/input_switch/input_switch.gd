class_name InputSwitch
extends Control


@export var visible_if_kbm: Control
@export var visible_if_controller: Control
@export var visible_if_touch: Control


func _ready() -> void:
	var device := InputDeviceListener.get_current_device()
	_set_device(device)
	InputDeviceListener.switched_device.connect(_on_device_switched)


func _set_device(device: InputDeviceListener.Device) -> void:
	_hide_all_controls()
	if device == InputDeviceListener.Device.KBM and visible_if_kbm:
		visible_if_kbm.show()
	elif device == InputDeviceListener.Device.CONTROLLER and visible_if_controller:
		visible_if_controller.show()
	elif device == InputDeviceListener.Device.TOUCH and visible_if_touch:
		visible_if_touch.show()


func _hide_all_controls() -> void:
	if visible_if_kbm:
		visible_if_kbm.hide()
	if visible_if_controller:
		visible_if_controller.hide()
	if visible_if_touch:
		visible_if_touch.hide()


func _on_device_switched(new_device: InputDeviceListener.Device) -> void:
	_set_device(new_device)
