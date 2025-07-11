extends CanvasLayer
class_name StrengthUI

const STRENGTH_ITEM = preload("res://scenes/ui/strength_ui/strength_item.tscn")

@onready var strength_grid: GridContainer = $MarginContainer/StrengthGrid

var total_strength: int
var current_strength: int

var items: Array[StrengthItem] = []

func _ready() -> void:
	for item in strength_grid.get_children():
		if item is StrengthItem:
			items.append(item)
			
	Events.strength_total_updated.connect(update_total)
	Events.strength_deducted.connect(deduct)

func deduct(deduct_amount: int = 1) -> void:
	current_strength = max(0, current_strength - deduct_amount)
	update_display()

func update_total(total: int, full_all: bool = false) -> void:
	total_strength = total
	if full_all:
		current_strength = total_strength
		
	update_display()
		
	
func update_display() -> void:
	var diff_count = max(0, total_strength - items.size())
	if diff_count:
		for i in range(diff_count):
			var strength_item: StrengthItem = STRENGTH_ITEM.instantiate()
			items.append(strength_item)
			strength_grid.add_child(strength_item)
	
	for i in range(items.size()):
		var item: StrengthItem = items[i]
		item.used = i >= current_strength
