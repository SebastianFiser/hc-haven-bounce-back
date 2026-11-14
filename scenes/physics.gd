extends CharacterBody2D


@export var speed: float = 300.0
@export var gravity: float = 900.0
@export var veloc_jump: float = -400

func _physics_process(delta: float) -> void:
	var jumped =  Input.is_action_just_pressed("jump")
	var smer = Input.get_axis("move_left", "move_right")
	velocity.x = speed * smer
	if !is_on_floor():
		velocity.y += delta * gravity 
	if jumped and is_on_floor() :
		velocity.y += veloc_jump
	
	move_and_slide()
