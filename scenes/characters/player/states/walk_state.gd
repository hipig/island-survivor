extends StateMachineState

var target_position: Vector2 = Vector2.ZERO
var path_update_timer: float = 0.0

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	if actor.current_target:
		target_position = actor.current_target.global_position
		actor.navigation_agent.target_position = target_position
		path_update_timer = 0.0

func _on_update(delta: float, actor: Node) -> void:
	actor = actor as Player
	actor.animated_sprite.play("walk_" + actor.animate_direction)
	path_update_timer += delta
	if path_update_timer > 0.2:
		actor.navigation_agent.target_position = target_position
		path_update_timer = 0.0
		
	var next_path_position = actor.navigation_agent.get_next_path_position()
	var direction = actor.global_position.direction_to(next_path_position)
	actor.update_direction(direction)

	var new_velocity = direction * actor.speed

	if actor.navigation_agent.avoidance_enabled:
		actor.navigation_agent.set_velocity(new_velocity)
	else:
		actor.velocity = new_velocity
		actor.move_and_slide()
		
func _on_next(actor: Node) -> void:
	actor = actor as Player
	if actor.navigation_agent.is_navigation_finished():
		transition.emit("Idle")
