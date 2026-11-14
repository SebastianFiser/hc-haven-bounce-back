extends Sprite2D
var texture_list = [
	preload("res://Sprites/Untitled design-1.png"),
	preload("res://Sprites/Untitled design-2.png"),
	preload("res://Sprites/Untitled design-3.png"),
	preload("res://Sprites/Untitled design-4.png"),
	preload("res://Sprites/Untitled design-5.png")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture = get_parent().get_parent().sprite_selected


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_debug_sprite_pressed() -> void:
	print(texture)
