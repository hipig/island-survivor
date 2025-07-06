extends StateMachineState

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

	actor.hit_box_collision_shape.position = collision_position
	actor.hit_box_collision_shape.disabled = false
	actor.animated_sprite.play("mining_" + actor.animate_direction)
	
func _on_exit(actor: Node) -> void:
	actor.hit_box_collision_shape.disabled = true

func _on_next(actor: Node) -> void:
	actor = actor as Player
	if actor.current_target == null:
		transition.emit("Idle")
