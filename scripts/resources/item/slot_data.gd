extends Resource
class_name SlotData

@export var item: ItemData = null
@export var amount: int

func is_empty() -> bool:
	return !item
