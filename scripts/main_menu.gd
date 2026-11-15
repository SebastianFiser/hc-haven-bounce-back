extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl1.tscn")
	print("pressed start")


func _on_player_pressed() -> void:
	print("pressed player")
	get_tree().change_scene_to_file("res://scenes/PickPlayer.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
