class_name DialogueQueue
extends Node
## Processes a queue of dialogue


signal started
signal finished

class QueuedDialogue:
	signal started
	signal finished
	
	var title: String
	var text: String
	var options: Dictionary[String, Callable]
	var reward: Texture
	
	func _init(p_text: String = "", p_title: String = "",
			p_options: Dictionary[String, Callable] = {},
			p_reward: Texture = null) -> void:
		title = p_title
		text = p_text
		options = p_options
		reward = p_reward


@export var _title_label: Label
@export var _typed_label: TypedLabel
@export var _title_panel: Control
@export var _options_container: GridContainer
@export var _option_button_scene: PackedScene
@export var _sfx_on_reward: AudioStreamPlayer

@onready var _reward_container: PanelContainer = %RewardContainer
@onready var _reward_texture: TextureRect = %RewardTexture


var _current_dialogue: QueuedDialogue = null
var _queued_dialogue: Array[QueuedDialogue] = []


func next() -> void:
	if _current_dialogue and _current_dialogue.options:
		return
	
	if _current_dialogue and _typed_label.is_typing():
		_typed_label.skip_to_end()
	else:
		_next_dialogue()
	get_viewport().set_input_as_handled()


func add(dialogue: String = "", title: String = "",
		options: Dictionary[String, Callable] = {},
		reward: Texture = null) -> void:
	var q_dialogue := QueuedDialogue.new(dialogue, title, options, reward)
	_queued_dialogue.push_back(q_dialogue)
	
	if not _current_dialogue:
		_next_dialogue()
		started.emit()
	
	await q_dialogue.finished


func _next_dialogue() -> void:
	if _current_dialogue:
		_current_dialogue.finished.emit()
	
	if not _queued_dialogue:
		_handle_finished_dialogue()
		return
	
	_current_dialogue = _queued_dialogue.pop_front()
	
	if _current_dialogue.text:
		_typed_label.text = tr(_current_dialogue.text)
		_typed_label.start_typing()
		_typed_label.show()
	else:
		_typed_label.hide()
	
	for option in _options_container.get_children():
		option.queue_free()
	
	if _current_dialogue.options:
		_populate_options(_current_dialogue.options)
		_options_container.show()
	else:
		_options_container.hide()
	
	if _current_dialogue.reward:
		_reward_texture.texture = _current_dialogue.reward
		_reward_container.show()
		if _sfx_on_reward:
			_sfx_on_reward.play()
	else:
		_reward_container.hide()
	
	_title_label.text = tr(_current_dialogue.title)
	_title_panel.visible = _current_dialogue.title.length() > 0
	_typed_label.audio_while_typing_enabled = _title_panel.visible
	
	_current_dialogue.started.emit()


func _handle_finished_dialogue() -> void:
	_current_dialogue = null
	finished.emit()


func _populate_options(options: Dictionary[String, Callable]) -> void:
	_options_container.columns = ceili(options.size() / 2.0)
	if options.size() == 2: # want row instead of column for 2 options
		_options_container.columns += 1
	
	for option in options:
		var button := _option_button_scene.instantiate() as Button
		button.text = tr(option)
		_options_container.add_child(button)
		
		var on_pressed := func () -> void:
			options[option].call()
			_next_dialogue()
		button.pressed.connect(on_pressed)
