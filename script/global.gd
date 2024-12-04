extends Node

# Init si JSON nya dulu kan ya kan?


# Terus detect dan taruh ke var ini
var act1 = false
var act2 = false
var act3 = false

# Cek dan pindah act
var current_act = "class"
var transition_act = false

var game_first_loading = true

# Cek player bisa moveable or tidak
var player_movable = true

var text_queue = []  # Queue global untuk teks dan animasi
var is_reading = false  # Status membaca untuk mencegah konflik


func finish_changeact():
	if transition_act == true:
		transition_act = false
		if current_act == "class":
			current_act = "library"
		elif current_act == "library":
			current_act = "class"

func set_player_move(check: bool):
	player_movable = check
