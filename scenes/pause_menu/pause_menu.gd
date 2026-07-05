class_name PauseMenu
extends CanvasLayer


@onready var options: VBoxContainer = $Options
@onready var continue_button: Button = $Options/ContinueButton

@onready var confirm_quit: VBoxContainer = $ConfirmQuit


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_toggle"):
		if visible:
			_close()
		else:
			get_tree().paused = true
			show()
		get_viewport().set_input_as_handled()
	
	#elif visible and event.is_action_pressed("ui_cancel"):
		#if settings_menu.visible:
			#_on_settings_menu_back_pressed()
		#else:
		#	_close()


func _close() -> void:
	get_tree().paused = false
	options.show()
	#settings_menu.hide()
	confirm_quit.hide()
	hide()


func _on_continue_button_pressed() -> void:
	_close()
