extends MarginContainer
class_name InventoryPanel

signal closed

@export var inventory_list: InventoryList

@onready var inventory_grid: GridContainer = %InventoryGrid
@onready var description_label: Label = %DescriptionLabel
@onready var close_button: Button = %CloseButton

var slots: Array[InventorySlot] = []
var selected_index: int = 0

func _ready() -> void:
	for item in inventory_grid.get_children():
		if item is InventorySlot:
			slots.append(item)
			
	for i in slots.size():
		var slot = slots[i]
		slot.pressed.connect(_on_pressed.bind(i))
		
	close_button.pressed.connect(_on_close_pressed)

func update_display() -> void:
	for i in slots.size():
		var slot = slots[i]
		var inventory_slot = inventory_list.slots[i]
		
		if inventory_slot and inventory_slot.item:
			slot.slot = inventory_slot
			slot.update_display()

func update_description() -> void:
	var inventory_slot = inventory_list.slots[selected_index]
	description_label.text = inventory_slot.item.name

func _on_pressed(index: int) -> void:
	var inventory_slot = inventory_list.slots[index]
	if !inventory_slot or !inventory_slot.item:
		return
	
	selected_index = index
	update_description()
	
func _on_close_pressed() -> void:
	closed.emit()
