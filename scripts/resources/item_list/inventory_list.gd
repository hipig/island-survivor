extends Resource
class_name InventoryList

@export var slots: Array[SlotData] = []

func add_item(item: ItemData, amount: int = 1) -> int:
	if not item or amount <= 0:
		return 0
		
	var remaining = amount
	var max_stack = item.max_stack_size
	
	for i in range(slots.size()):
		var slot = slots[i]
		if slot and not slot.is_empty() and slot.item.id == item.id and slot.amount < max_stack:
			var space_left = max_stack - slot.amount
			var to_add = min(space_left, amount)
			slot.amount += to_add
			remaining -= to_add
			if remaining <= 0: return amount
	
	for i in range(slots.size()):
		var slot = slots[i]
		if not slot:
			slot = SlotData.new()
			slots[i] = slot
			
		if slot.is_empty():
			slot.item = item
			var to_add = min(amount, item.max_stack_size)
			slot.amount = to_add
			remaining -= to_add
			if remaining <= 0: return amount
	
	return amount - remaining

func remove_item(item: ItemData, amount: int = 1) -> int:
	if not item or amount <= 0:
		return 0
		
	var total_removed = 0
	var remaining = amount
	var item_id = item.id
		
	var eligible_slots = []
	for i in range(slots.size()):
		var slot = slots[i]
		if slot and slot.item and slot.item.id == item_id:
			eligible_slots.append({
				"index": i,
				"amount": slot.amount
			})
	
	for slot_info in eligible_slots:
		if remaining <= 0:
			break
			
		var slot_index = slot_info["index"]
		var slot = slots[slot_index]
		var to_remove = min(remaining, slot.amount)
		slot.amount -= to_remove
		total_removed += to_remove
		remaining -= to_remove
		
		if slot.amount <= 0:
			slot.item = null
			slot.amount = 0
	
	return total_removed
