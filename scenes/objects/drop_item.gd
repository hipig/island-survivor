extends Node2D
class_name DropItem

@export var item_data: ItemData

@onready var sprite_2d: Sprite2D = $Sprite2D

var velocity: Vector2 = Vector2.ZERO

var owner_body: Node2D

func _ready() -> void:
	sprite_2d.texture = item_data.icon
	
func start_drop(target_position: Vector2, bounce_height: float, drop_duration: float) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	
	var start_position = global_position
	var peak_position = (start_position + target_position) * 0.5
	peak_position.y -= bounce_height
	
	var control_position = start_position.lerp(peak_position, 0.33)
	control_position.y -= bounce_height * 0.3
	var control_position_2 = peak_position.lerp(target_position, 0.66)
	control_position_2.y -= bounce_height * 0.2
	
	tween.tween_method(
		func(t: float):
			# 三次贝塞尔曲线公式
			var u = 1.0 - t
			var tt = t * t
			var uu = u * u
			var uuu = uu * u
			var ttt = tt * t
			
			# 计算位置
			var p = uuu * start_position
			p += 3 * uu * t * control_position
			p += 3 * u * tt * control_position_2
			p += ttt * target_position
			
			global_position = p,
		0.0, 1.0, drop_duration
	)
	
	tween.tween_property(
		self, 
		"position:y", 
		position.y - 5, 
		0.1
	).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		self, 
		"position:y", 
		position.y, 
		0.1
	).set_ease(Tween.EASE_IN)
	
	tween.chain()
	
	tween.tween_callback(
		func ():
			await get_tree().create_timer(0.5).timeout
			start_collect()
	)
	
func start_collect() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	
	var target_position = owner_body.global_position
	
	tween.tween_property(self, "global_position", target_position, 0.5)
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.5)
	tween.chain()
	tween.tween_callback(
		func ():
			if owner_body and owner_body.has_method("item_collect"):
				owner_body.item_collect(item_data)
				
			queue_free()
	)
