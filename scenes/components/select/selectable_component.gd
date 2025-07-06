extends Area2D
class_name SelectableComponent

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_selected: bool = false:
	set(value):
		is_selected = value
		update_selection_visual()

func _ready() -> void:
	sprite_2d.hide()
	input_event.connect(_on_input_event)
	body_entered.connect(_on_body_entered)
	
func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.is_pressed():
			Events.selectable_selected.emit(self)
		
func update_selection_visual() -> void:
	if  is_selected:
		sprite_2d.show()
		animation_player.play("select")
	else:
		sprite_2d.hide()
		animation_player.stop()

func _on_body_entered(_body: Node2D) -> void:
	is_selected = false
