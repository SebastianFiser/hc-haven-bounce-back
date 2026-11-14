extends Area2D

@export var next_level: PackedScene


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if next_level:
		get_tree().change_scene_to_packed.call_deferred(next_level)
	else:
		print("Poslední level")
