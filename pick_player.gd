extends Node2D
@onready var preview: Sprite2D = $Player/Sprite2D
var texture_list = [
	preload("res://Sprites/Untitled design-1.png"),
	preload("res://Sprites/Untitled design-2.png"),
	preload("res://Sprites/Untitled design-3.png"),
	preload("res://Sprites/Untitled design-4.png"),
	preload("res://Sprites/Untitled design-5.png")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var sprite_selected = 0
var sprite_count = 5
func _on_left_pressed() -> void:
	if sprite_selected > 0:
		sprite_selected -= 1
		print(sprite_selected)
		update_sprite()

func _on_right_pressed() -> void:
	if sprite_selected < sprite_count - 1:
		sprite_selected += 1
		print(sprite_selected)
		update_sprite()
	
func update_sprite() -> void:
	preview.texture = texture_list[sprite_selected]



func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
