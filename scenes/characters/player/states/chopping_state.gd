extends StateMachineState

var is_chopping: bool = false

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	var collision_position = Vector2.ZERO
	match actor.direction:
		Vector2.UP:
			collision_position = Vector2(0, -10.0)
		Vector2.DOWN:
			collision_position = Vector2(0, 10.0)
		Vector2.LEFT:
			collision_position = Vector2(-9.0, 0)
		Vector2.RIGHT:
			collision_position = Vector2(9.0, 0)

	is_chopping = true
	actor.hit_box_component.damage_type = DataTypes.ToolType.Axe
	actor.hit_box_component.damage = 1.0
	actor.hit_box_collision_shape.position = collision_position
	actor.hit_box_collision_shape.disabled = false
	actor.animated_sprite.play("chopping_" + actor.animate_direction)
	await actor.animated_sprite.animation_finished
	is_chopping = false
	actor.hit_box_collision_shape.disabled = true
	
func _on_next(_actor: Node) -> void:
	if !is_chopping:
		transition.emit("Idle")
