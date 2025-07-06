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
		
	if actor.navigation_agent.is_navigation_finished():
		handle_arrival(actor)
		return
		
	var next_path_position = actor.navigation_agent.get_next_path_position()
	var direction = actor.global_position.direction_to(next_path_position)
	actor.update_direction(direction)

	var new_velocity = direction * actor.speed

	if actor.navigation_agent.avoidance_enabled:
		actor.navigation_agent.set_velocity(new_velocity)
	else:
		actor.velocity = new_velocity
		actor.move_and_slide()

func handle_arrival(actor: Player) -> void:
	if actor.current_target:
		var hurt_box_component: HurtBoxComponent = actor.current_target.get_node_or_null("HurtBoxComponent")
		if hurt_box_component:
			match hurt_box_component.required_damage_type:
				DataTypes.ToolType.Axe:
					transition.emit("Chopping")
				DataTypes.ToolType.Axe:
					transition.emit("Chopping")
	else:
		transition.emit("Idle")
