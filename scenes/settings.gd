extends Node2D   # change to match the type of your Settings root node

const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1366, 768),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
]

var index := 0

@onready var resolution_label: Label = $WSGroup/Resolution
@onready var increase_button: Button = $WSGroup/increase_button
@onready var decrease_button: Button = $WSGroup/decrease_button


func _ready() -> void:
	# Start at whatever size the window currently has (if it's in the list)
	var found := RESOLUTIONS.find(DisplayServer.window_get_size())
	index = found if found != -1 else 0

	increase_button.pressed.connect(_on_increase_pressed)
	decrease_button.pressed.connect(_on_decrease_pressed)
	_update_label()


func _on_increase_pressed() -> void:
	index = mini(index + 1, RESOLUTIONS.size() - 1)
	_apply_resolution()


func _on_decrease_pressed() -> void:
	index = maxi(index - 1, 0)
	_apply_resolution()


func _apply_resolution() -> void:
	var size := RESOLUTIONS[index]
	DisplayServer.window_set_size(size)

	# Re-center the window on the screen so it doesn't jump off to a corner
	var screen_pos := DisplayServer.screen_get_position()
	var screen_size := DisplayServer.screen_get_size()
	DisplayServer.window_set_position(screen_pos + (screen_size - size) / 2)

	_update_label()


func _update_label() -> void:
	print("upd_label")
	var size := RESOLUTIONS[index]
	resolution_label.text = "%d x %d" % [size.x, size.y]
	decrease_button.disabled = index == 0
	increase_button.disabled = index == RESOLUTIONS.size() - 1


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
