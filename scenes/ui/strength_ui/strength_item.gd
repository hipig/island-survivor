@tool
extends TextureRect
class_name StrengthItem

const FULL_TEXTURE: Texture2D = preload("res://assets/textures/icons/mini/Heart_Outline.png")
const EMPTY_TEXTURE: Texture2D = preload("res://assets/textures/icons/mini/Heart_Empty_Outline.png")

var used: bool = false:
	set(n):
		used = n
		update_texture()

func _ready() -> void:
	update_texture()

func full() -> void:
	used = false
	
func empty() -> void:
	used = true

func update_texture() -> void:
	texture = FULL_TEXTURE
	if used:
		texture = EMPTY_TEXTURE
