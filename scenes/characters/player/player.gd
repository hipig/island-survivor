extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var hit_box_collision_shape: CollisionShape2D = $HitBoxComponent/HitBoxCollisionShape

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var direction: Vector2 = Vector2.ZERO
var animate_direction: String = "down"
var speed: float = 40.0

var current_target: Node2D = null

func _ready() -> void:
	state_machine.start()
	
func item_collect(item: ItemData) -> void:
	print(item)
	
func set_interaction_target(target: Node2D) -> void:
	current_target = target
	if current_target:
		state_machine.transition_to("Walk")

func get_movement_vector() -> Vector2:
	var x: float = Input.get_axis("move_left", "move_right")
	var y: float = Input.get_axis("move_up", "move_down")
	return Vector2(x, y).normalized()
	
func update_direction(dir: Vector2) -> void:
	var x = abs(dir.x)
	var y = abs(dir.y)
	if x > y:
		if dir.x > 0:
			direction = Vector2.RIGHT
			animate_direction = "right"
		else:
			direction = Vector2.LEFT
			animate_direction = "left"
	elif x < y:
		if dir.y > 0:
			direction = Vector2.DOWN
			animate_direction = "down"
		else:
			direction = Vector2.UP
			animate_direction = "up"
