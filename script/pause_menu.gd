extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func paused():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func textEsc():
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().paused:
		paused()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		resume()

func _on_exit_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_continue_button_pressed() -> void:
	resume()

func _process(delta: float) -> void:
	textEsc()
