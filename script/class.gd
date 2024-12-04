extends Node2D

@onready var hud = $HUD/HUD
@onready var textbox = $Textbox

func _ready() -> void:
	$BlackoutAnimate.play("changescene_out")
	if global.act1 == false && global.act2 == false && global.act3 == false:
		global.act1 = true
	
	if global.act1 == true:
		textbox.add_text("Guru", dialog.act1_teacher_1)
		textbox.add_text("Guru", dialog.act1_teacher_2)
		textbox.add_animation("changescene_in", 1.0)
		textbox.add_text("Murid-murid", dialog.act1_students_4)
		textbox.add_text("Guru", dialog.act1_teacher_5)


func _process(delta: float) -> void:
	change_act()

func _on_outclass_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_act = true

func _on_outclass_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_act = false

func change_act():
	if global.transition_act == true:
		if global.current_act == "class":
			$BlackoutAnimate.play("changescene_in")

func _on_blackout_animate_animation_finished(anim_name: StringName) -> void:
	if anim_name == "changescene_in":
		get_tree().change_scene_to_file("res://scenes/library.tscn")
		global.finish_changeact()


func _on_commit_work_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("Tekan [E] untuk Kumpulkan")


func _on_commit_work_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")
