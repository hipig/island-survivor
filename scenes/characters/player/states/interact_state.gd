extends StateMachineState

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	if actor.current_target:
		var hurt_box_component: HurtBoxComponent = actor.current_target.get_node_or_null("HurtBoxComponent")
		if hurt_box_component:
			if hurt_box_component.required_damage_type == DataTypes.ToolType.Axe:
				transition.emit("Chopping")
				return
