extends StateMachineState

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	actor.animated_sprite.play("idle_" + actor.animate_direction)

func _on_next(actor: Node) -> void:
	actor = actor as Player
	handle_arrival(actor)

func handle_arrival(actor: Player) -> void:
	if actor.current_target:
		var hurt_box_component: HurtBoxComponent = actor.current_target.get_node_or_null("HurtBoxComponent")
		if hurt_box_component:
			match hurt_box_component.required_damage_type:
				DataTypes.ToolType.Axe:
					transition.emit("Chopping")
				DataTypes.ToolType.Axe:
					transition.emit("Chopping")
