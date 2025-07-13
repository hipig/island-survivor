extends StaticBody2D
class_name Tent

@onready var area: Area2D = $Area2D
@onready var gpu_particles: GPUParticles2D = $GPUParticles2D
@onready var progress_control: Control = $ProgressControl
@onready var progress_bar: ProgressBar = $ProgressControl/ProgressBar

var recover_duration: float = 5.0
var recover_time: float = 0
var recover_started: bool = false
var recover_body: Player

func _ready() -> void:
	gpu_particles.emitting = false
	progress_control.hide()
	area.body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	if not recover_started:
		return
	
	recover_time += delta
	var percent: float = recover_time / recover_duration
	progress_bar.value = percent
	
	if recover_time >= recover_duration:
		recover_time = 0
		progress_control.hide()
		progress_bar.value = 0
		gpu_particles.emitting = false
		recover_started = false
		
		if recover_body:
			recover_body.recovery_strength()
		

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		recover_body = body
		recover_started = true
		gpu_particles.emitting = true
		progress_control.show()
