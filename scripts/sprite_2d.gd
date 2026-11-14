extends Sprite2D

@export var speed: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_movement(delta)
	
	
func handle_movement(delta: float) -> void:
	var smer = Input.get_axis("move_left", "move_right")
	position.x += smer * delta * speed
	
	
