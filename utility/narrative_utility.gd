class_name NarrativeUtility


static func queue_dialogue(dialogue: Array[String], title: String = "") -> bool:
	assert(dialogue.size() > 0, "Empty dialogue")
	
	var dialogue_screen := _get_dialogue_screen()
	for entry: String in dialogue.slice(0, -1):
		dialogue_screen.queue_dialogue(entry, title)
	
	var last_entry: String = dialogue.back()
	await dialogue_screen.queue_dialogue(last_entry, title)
	return true


static func _get_dialogue_screen() -> DialogueScreen:
	# Placeholder
	return null
