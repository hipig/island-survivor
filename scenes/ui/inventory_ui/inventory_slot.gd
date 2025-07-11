extends Button
class_name InventorySlot

@export var slot: SlotData = null

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $MarginContainer/Label

func _ready() -> void:
	update_display()

func update_display() -> void:
	if !slot or !slot.item:
		return
	
	texture_rect.texture = slot.item.icon
	if slot.item is ToolItemData:
		label.text = "LV" + str(slot.item.level)
	else:
		label.text = str(slot.amount)
	
