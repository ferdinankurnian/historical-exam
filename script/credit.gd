extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5.0  # Tunggu 10 detik
	timer.one_shot = true
	timer.start()
	
	timer.timeout.connect(_on_timer_timeout)  # Sambungkan ke fungsi ketika selesai

func _on_timer_timeout():
	# Kembali ke main menu
	global.block_continue = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
