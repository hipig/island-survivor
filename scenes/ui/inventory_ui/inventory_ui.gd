extends CanvasLayer
class_name InventoryUI

@onready var open_button: Button = $MarginContainer/OpenButton
@onready var inventory_panel: InventoryPanel = $InventoryPanel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var opened: bool = false

func _ready() -> void:
	open_button.pressed.connect(_on_pressed)
	inventory_panel.closed.connect(_on_closed)
	
func _on_pressed() -> void:
	if !opened:
		opened = true
		animation_player.play("open")
		inventory_panel.update_display()
		inventory_panel.update_description()

func _on_closed() -> void:
	opened = false
	animation_player.play("close")
