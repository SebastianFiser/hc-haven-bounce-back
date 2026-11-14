extends CharacterBody2D


@export var speed: float = 400.0
@export var gravity: float = 900.0
@export var veloc_jump: float = -400
@export var acceleration: float = 1500.0
@export var friction: float = 250.0
@export var bounciness: float = 0.5

func _physics_process(delta: float) -> void:
	var velocity_before = velocity
	var jumped =  Input.is_action_just_pressed("jump")
	var smer = Input.get_axis("move_left", "move_right")
	
	if smer != 0:
		velocity.x = move_toward(velocity.x,smer * speed, delta * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, delta * friction)
	
	
	if !is_on_floor():
		velocity.y += delta * gravity
	if jumped and is_on_floor() :
		velocity.y += veloc_jump
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var normal = get_slide_collision(i).get_normal()
		if velocity_before.length() > 150.0:
			var odraz = velocity_before.bounce(normal)
			odraz.y *= bounciness
			velocity = odraz
