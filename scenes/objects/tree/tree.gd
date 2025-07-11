extends Node2D
class_name TreeObject

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var drop_component: DropComponent = $DropComponent

var damage_owner: Node2D

func _ready() -> void:
	hurt_box_component.hurted.connect(_on_hurted)
	health_component.died.connect(_on_died)
	
func _on_hurted(damage: float, hit_owner: Node2D) -> void:
	damage_owner = hit_owner
	health_component.damage(damage)
	sprite.material.set_shader_parameter("shake_intensity", 0.8)
	await get_tree().create_timer(0.8).timeout
	sprite.material.set_shader_parameter("shake_intensity", 0.0)
	
func _on_died() -> void:
	drop_component.drop_items(damage_owner)
	Events.strength_deducted.emit(1)
	call_deferred("queue_free")
