extends Node2D

func _ready() -> void:
	$BlackoutAnimation.play("changescene_out")


func _process(delta: float) -> void:
	change_act()


func _on_outlibrary_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_act = true 


func _on_outlibrary_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_act = false


func change_act():
	if global.transition_act == true:
		if global.current_act == "class":
			$BlackoutAnimation.play("changescene_in")


func _on_blackout_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "changescene_in":
		get_tree().change_scene_to_file("res://scenes/class.tscn")
		global.finish_changeact()
