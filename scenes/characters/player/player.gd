extends CharacterBody2D
class_name Player

const INVENTORY_LIST: InventoryList = preload("res://resouces/item_lists/inventory_player.tres")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var hit_box_collision_shape: CollisionShape2D = $HitBoxComponent/HitBoxCollisionShape

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var direction: Vector2 = Vector2.ZERO
var animate_direction: String = "down"
var speed: float = 40.0

var total_strength: int = 5
var strength: int = total_strength

var coin: int = 0

var current_target: Node2D = null

func _ready() -> void:
	state_machine.start()
	update_total_strength(total_strength, true)
	Events.strength_deducted.connect(_on_strength_deducted)
	
func item_collect(item: ItemData) -> void:
	INVENTORY_LIST.add_item(item)
	
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

func recovery_strength() -> void:
	strength = total_strength
	Events.strength_recovered.emit()

func update_total_strength(total: int, full_all: bool = false) -> void:
	total_strength = total
	Events.strength_total_updated.emit(total_strength, full_all)

func _on_strength_deducted(deducte_strength: int) -> void:
	strength = max(0, strength - deducte_strength)
	
