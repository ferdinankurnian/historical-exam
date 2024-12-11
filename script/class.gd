extends Node2D

@onready var hud = $HUD/HUD
@onready var textbox = $Textbox

var on_return_area = false

var going_to_act2 = false
var exam_complete = false

func _ready() -> void:
	$returnbookindicator.visible = false
	$Textbox.connect("queue_finished", Callable(self, "_on_queue_finished"))
	$Textbox.connect("dialog_ended", Callable(self, "_on_dialog_ended"))
	$Papersheets/papersheets.connect("quiz_completed", Callable(self, "_on_quiz_completed"))
	$BlackoutAnimate.play("changescene_out")
	global.checkAct()
	if not (global.act1 or global.act2 or global.act3):
		global.act1 = true

	if global.act1:
		hud.visible = false
		textbox.add_text_to_queue("Guru", dialog.act1_teacher_1)
		textbox.add_text_to_queue("Guru", dialog.act1_teacher_2)
		textbox.add_text_to_queue("Guru", dialog.act1_teacher_3)
		textbox.add_text_to_queue("Murid-murid", dialog.act1_students_4)
		textbox.add_text_to_queue("Guru", dialog.act1_teacher_5)
		textbox.add_text_to_queue("Murid-murid", dialog.act1_students_6)
		textbox.add_blackout_to_queue() 
		textbox.add_text_to_queue("Bayu", dialog.act1_bayu_7)
		textbox.add_text_to_queue("Bayu", dialog.act1_bayu_8)
		textbox.add_blackout_to_queue() 
		
		going_to_act2 = true
	
	if global.act3 and global.givepapersheets == false:
		hud.visible = false
		textbox.add_text_to_queue("Guru", dialog.act3_teacher_1)
		textbox.add_text_to_queue("Guru", dialog.act3_teacher_2)
		textbox.add_text_to_queue("Murid-murid", dialog.act3_students_3)

func _on_queue_finished():
	if going_to_act2:
		$BlackoutAnimate.play("blackouttext")
		# Menghilangkan karakter
		$teacher.visible = false
		$classmate2.visible = false
		$classmate3.visible = false
		$classmate4.visible = false
		going_to_act2 = false
	
	if global.givepapersheets:
		$BlackoutAnimate.play("changescene_in")
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 5.0  # Tunggu 10 detik
		timer.one_shot = true
		timer.start()
		
		timer.timeout.connect(_on_timer_timeout)  # Sambungkan ke fungsi ketika selesai

func _on_timer_timeout():
	# Kembali ke main menu
	get_tree().change_scene_to_file("res://scenes/credit.tscn")

func _on_dialog_started():
	hud.visible = false

func _on_dialog_ended():
	if global.act1:
		hud.visible = true
		hud.set_obj_text("Pergi ke perpustakaan")
	elif global.act3 and global.givepapersheets == false:
		$teacher.position = Vector2(456, 150)
		$Papersheets/papersheets.visible = true

func _on_play_blackout_animation(animation_name: String):
	$BlackoutAnimate.play(animation_name)

func _process(delta: float) -> void:
	change_act()
	
	if on_return_area and Input.is_action_just_pressed("interact"):
		hud.visible = false
		global.givepapersheets = true
		$returnbookindicator.visible = false
		$CharacterBody2D.position = Vector2(552, 241)
		$CharacterBody2D.setPlayertoIdle()
		textbox.add_text_to_queue("Bayu", dialog.act3_teacher_4)
		textbox.add_text_to_queue("Bayu", dialog.act3_teacher_5)
		textbox.add_text_to_queue("Bayu", dialog.act3_teacher_6)
		if global.exam_score >= 80:
			textbox.add_text_to_queue("Guru", dialog.act3teacher7(global.exam_score))
			textbox.add_text_to_queue("Bayu", dialog.act3_alt1_bayu_8)
			textbox.add_text_to_queue("Bayu", dialog.act3_alt1_bayu_9)
		elif global.exam_score < 80:
			textbox.add_text_to_queue("Guru", dialog.act3teacher7(global.exam_score))
			textbox.add_text_to_queue("Bayu", dialog.act3_alt2_bayu_8)
			textbox.add_text_to_queue("Bayu", dialog.act3_alt2_bayu_9)

# Handle transition to library scene
func _on_outclass_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if global.act1:
			global.transition_act = true
			global.act2 = true
			global.act1 = false

func _on_outclass_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.act1:
			global.transition_act = false

# Change the act if necessary
func change_act():
	if global.transition_act and global.current_act == "class":
		$BlackoutAnimate.play("changescene_in")

# Scene transition
func _on_blackout_animate_animation_finished(anim_name: StringName) -> void:
	if anim_name == "changescene_in" and global.givepapersheets == false:
		get_tree().change_scene_to_file("res://scenes/library.tscn")
		global.finish_changeact()

# Interact at the commit point
func _on_commit_work_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if global.act3 and global.givepapersheets == false:
			on_return_area = true
			hud.set_interact_sign("Tekan [E] untuk Kumpulkan")

func _on_commit_work_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")

func _on_quiz_completed():
	hud.visible = true
	exam_complete = true
	$returnbookindicator.visible = true
	hud.set_obj_text("Kumpulkan ulangan ke meja guru")
	
