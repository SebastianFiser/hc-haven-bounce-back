extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 300.0
@export var gravity: float = 900.0
@export var jump_velocity: float = -700.0
@export var jump_cut: float = 0.5
@export var bounciness: float = 0.7
@export var min_bounce_speed: float = 450.0
@export_range(-180.0, 180.0) var hit_angle_offset: float = 180.0
@export var hit_hold_time: float = 0.1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_hitting: bool = false
var hit_finished: bool = false
var hit_hold_left: float = 0.0
var rotation_tween: Tween


func _ready() -> void:
	sprite.play("small_bounce")
	sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(delta: float) -> void:
	# odpočet držení hit pózy
	if is_hitting and hit_finished:
		hit_hold_left -= delta
		if hit_hold_left <= 0.0:
			_end_hit()

	# gravitace
	if not is_on_floor():
		velocity.y += gravity * delta

	# skok
	var can_jump: bool = is_on_floor() and velocity.y >= 0.0
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = jump_velocity

	# useknutí skoku při puštění klávesy
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_cut

	# vodorovný pohyb s třením
	var smer: float = Input.get_axis("move_left", "move_right")
	if smer != 0:
		velocity.x = move_toward(velocity.x, smer * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# pohyb + odraz
	var velocity_before: Vector2 = velocity
	move_and_slide()

	var hit_normal := Vector2.ZERO
	for i in get_slide_collision_count():
		var normal: Vector2 = get_slide_collision(i).get_normal()
		var impact: float = -velocity_before.dot(normal)
		if impact > min_bounce_speed:
			var odraz: Vector2 = velocity_before.bounce(normal)
			odraz.y *= bounciness
			velocity = odraz
			hit_normal += normal

	# hit jen když výsledná normála není rovná podlaha (zeď, roh, strop)
	if hit_normal != Vector2.ZERO and hit_normal.normalized().y > -0.9:
		_play_hit(hit_normal.normalized())

	_update_animation()


func _play_hit(normal: Vector2) -> void:
	if is_hitting:
		return   # během hitu (včetně držení) se nový nespouští

	if rotation_tween:
		rotation_tween.kill()   # zruš případné vracení rotace

	is_hitting = true
	hit_finished = false
	sprite.speed_scale = 1.0
	sprite.rotation = wrapf(normal.angle() + PI / 2.0 + deg_to_rad(hit_angle_offset), -PI, PI)
	sprite.play("hit")


func _on_animation_finished() -> void:
	if sprite.animation == "hit":
		hit_finished = true
		hit_hold_left = hit_hold_time   # zůstane na posledním snímku


func _end_hit() -> void:
	is_hitting = false
	hit_finished = false
	rotation_tween = create_tween()
	rotation_tween.tween_property(sprite, "rotation", 0.0, 0.15)


func _update_animation() -> void:
	if is_hitting:
		return

	if not is_on_floor():
		sprite.speed_scale = 1.0
		if sprite.animation != "big_bounce":
			sprite.animation = "big_bounce"
		sprite.pause()
		# snímek podle rychlosti: začátek skoku = snímek 1, vrchol = snímek 4
		var last_frame: int = sprite.sprite_frames.get_frame_count("big_bounce") - 1
		var progress: float = clampf(1.0 - velocity.y / jump_velocity, 0.0, 1.0)
		sprite.frame = roundi(progress * last_frame)
		return

	if sprite.animation != "small_bounce":
		sprite.play("small_bounce")
	sprite.speed_scale = 1.8 if absf(velocity.x) > 10.0 else 1.0
