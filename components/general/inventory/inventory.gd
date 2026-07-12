class_name Inventory
extends RefCounted
## Manages a dictionary of items ([Resource]) with quantities

## Emitted when some amount of an item is added
signal item_added(item_data: Resource, n: int)

## Emitted when some amount of an item is removed
signal item_removed(item_data: Resource, n: int)

## Emitted when sopme amount of an item is added or removed
signal changed

var _items: Dictionary[Resource, int] = {}


## Add a given number of an item.
func add_item(item_data: Resource, count: int = 1) -> void:
	assert(count >= 1)
	_items[item_data] = _items.get(item_data, 0) + count
	item_added.emit(item_data, count)
	changed.emit()


## Removes up to a given number of an item.
func remove_item(item_data: Resource, count: int = 1) -> void:
	assert(count >= 1)
	
	var current_count: int = _items.get(item_data, 0)
	if current_count <= 0:
		return
	
	var new_count := current_count - count
	if new_count <= 0:
		_items.erase(item_data)
	else:
		_items[item_data] = new_count
	item_removed.emit(item_data, current_count - new_count)
	changed.emit()


## Gets all items that are contained.
func get_items() -> Array:
	return _items.keys()


## Returns the quantity of an item (0 if there are none).
func get_item_count(item_data: Resource) -> int:
	return _items.get(item_data, 0)


## Returns true if there is more than a given number of an item
func has_item(item_data: Resource, quantity: int = 1) -> bool:
	assert(quantity >= 0)
	return get_item_count(item_data) >= quantity


## Removes all items.
func empty() -> void:
	_items.clear()
