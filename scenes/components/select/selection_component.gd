extends Node2D
class_name SelectionComponent

var current_selected: SelectableComponent = null

func _ready() -> void:
	Events.selectable_selected.connect(_on_selectable_selected)

func _on_selectable_selected(selectable: SelectableComponent) -> void:
	deselect_current()
	
	current_selected = selectable
	if selectable:
		selectable.is_selected = true
	
	var player = Groups.player
	if player:
		player.set_interaction_target(selectable.owner)

func deselect_current():
	if current_selected:
		current_selected.is_selected = false
	current_selected = null
