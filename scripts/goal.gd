extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_goal_body_entered)
	print("Goal ready")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_goal_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
