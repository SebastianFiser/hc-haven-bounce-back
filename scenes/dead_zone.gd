extends Area2D

@export_file("*.tscn") var respawn_scene: String = "res://scenes/lvl1.tscn"


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	get_tree().paused = false
	get_tree().change_scene_to_file.call_deferred(respawn_scene)
