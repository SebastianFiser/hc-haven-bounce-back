extends CanvasLayer

var elapsed: float = 0.0

@onready var timer_label: Label = $TimerLabel
@onready var pause_menu: Control = $PauseMenu
@onready var resume_button: TextureButton = $PauseMenu/ResumeButton
@onready var quit_button: TextureButton = $PauseMenu/QuitButton


func _ready() -> void:
	pause_menu.visible = false
	resume_button.pressed.connect(toggle_pause)
	quit_button.pressed.connect(_on_quit_pressed)


func _process(delta: float) -> void:
	if not get_tree().paused:
		elapsed += delta
		timer_label.text = "%.1f" % elapsed


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause() -> void:
	var new_state: bool = not get_tree().paused
	get_tree().paused = new_state
	pause_menu.visible = new_state


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
