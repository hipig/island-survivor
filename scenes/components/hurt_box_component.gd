extends Area2D
class_name HurtBoxComponent

signal hurted(damage: float)

@export var required_tool_type: DataTypes.ToolType = DataTypes.ToolType.None

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hit_box_component: HitBoxComponent = area as HitBoxComponent
	var damage = hit_box_component.damage
	
	if required_tool_type == hit_box_component.tool_type:
		hurted.emit(damage, hit_box_component.owner)
