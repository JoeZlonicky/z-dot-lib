class_name TypedLabel
extends Label
## "Types" out characters


## Emitted when all characters have been typed out
signal finished

## How many ms it takes for on character to be typed
@export_range(1, 200, 1, "suffix:ms") var time_per_character: float = 50.0

## If set will set the [AudioStreamPlayer] to be playing while typing
@export var play_audio_while_typing: AudioStreamPlayer

var _timer_ms: float = 0.0


func _process(delta: float) -> void:
	if visible_characters == -1 or visible_characters >= text.length():
		return
	
	if play_audio_while_typing:
		play_audio_while_typing.playing = true
	
	_timer_ms += delta * 1000.0
	while _timer_ms > time_per_character:
		visible_characters += 1
		_timer_ms -= time_per_character
		if visible_characters >= text.length():
			finished.emit()
			break


func start_typing() -> void:
	visible_characters = 0


func skip_to_end() -> void:
	if visible_characters >= text.length():
		return
	
	visible_characters = text.length()
	finished.emit()


func is_typing() -> bool:
	return visible_characters > 0 and visible_characters < text.length()
