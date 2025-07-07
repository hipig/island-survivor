extends Node2D
class_name DropComponent

const DROP_ITEM = preload("res://scenes/objects/drop_item.tscn")

@export var drop_list: Array[DropData]
@export var min_horizontal_offset: float = 30.0
@export var max_horizontal_offset: float = 60.0
@export var bounce_height: float = 30.0
@export var drop_duration: float = 0.4

func drop_items(body: Node2D) -> void:
	if drop_list.size() == 0:
		return

	generate_drops(body)
	
func generate_drops(body: Node2D) -> void:
	for i in drop_list.size():
		if drop_list[ i ] == null or drop_list[ i ].item == null:
			continue
		var drop_count: int = drop_list[ i ].get_drop_count()
		for j in drop_count:
			var drop : DropItem = DROP_ITEM.instantiate() as DropItem
			drop.item_data = drop_list[ i ].item
			drop.owner_body = body
			Groups.entities_layer.add_child(drop)
			drop.global_position = global_position
			start_drop(drop)

func start_drop(drop: DropItem) -> void:
	var horizontal_offset = randf_range(min_horizontal_offset, max_horizontal_offset)
	var target_position = drop.global_position + Vector2(horizontal_offset * [-1, 1].pick_random(), 0)
	
	drop.start_drop(target_position, bounce_height, drop_duration)
	
