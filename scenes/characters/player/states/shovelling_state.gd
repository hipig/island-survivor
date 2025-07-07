extends StateMachineState

var is_shoveling: bool = false

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	var collision_position = Vector2.ZERO
	match actor.direction:
		Vector2.UP:
			collision_position = Vector2(0, -9.0)
		Vector2.DOWN:
			collision_position = Vector2(0, 9.0)
		Vector2.LEFT:
			collision_position = Vector2(-9.0, 0)
		Vector2.RIGHT:
			collision_position = Vector2(9.0, 0)

	is_shoveling = true
	actor.hit_box_component.tool_type = DataTypes.ToolType.Shovel
	actor.hit_box_component.damage = 1.0
	actor.hit_box_collision_shape.position = collision_position
	actor.animated_sprite.play("shoveling_" + actor.animate_direction)
	actor.animated_sprite.frame_changed.connect(_on_frame_changed.bind(actor))
	await actor.animated_sprite.animation_finished
	is_shoveling = false
	actor.hit_box_collision_shape.disabled = true
	
func _on_next(_actor: Node) -> void:
	if !is_shoveling:
		transition.emit("Idle")
		
func _on_exit(actor: Node) -> void:
	actor = actor as Player
	actor.animated_sprite.frame_changed.disconnect(_on_frame_changed.bind(actor))

func _on_frame_changed(actor: Player) -> void:
	if  actor.animated_sprite.frame >= 4:
		actor.hit_box_collision_shape.disabled = false
