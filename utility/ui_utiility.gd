class_name UIUtility


## Focuses a node but only visually shows focus if not using a mouse
static func focus_depending_on_device(control: Control) -> void:
	var hide_focus := InputDeviceListener.is_kbm_mouse_user()
	control.grab_focus(hide_focus)
