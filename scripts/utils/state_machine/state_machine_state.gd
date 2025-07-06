extends Node
class_name StateMachineState

@warning_ignore("unused_signal")
signal transition(state_name: String)

func _on_enter(_actor: Node) -> void:
	pass

func _on_update(_delta: float, _actor: Node) -> void:
	pass

func _on_next(_actor: Node) -> void:
	pass

func _on_exit(_actor: Node) -> void:
	pass
