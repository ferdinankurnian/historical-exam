extends CanvasLayer

const CHAR_READ_RATE = 0.05

# Path relatif dimulai dari root (Textbox)
@onready var textbox_container = $TextboxContainer
@onready var subject = $TextboxContainer/MarginContainer/VBoxContainer/Subject
@onready var message = $TextboxContainer/MarginContainer/VBoxContainer/Message
@onready var end_message = $TextboxContainer/MarginContainer/VBoxContainer/EndMessage

func _ready():
	# Sembunyikan textbox saat awal
	textbox_container.hide()
	print("Textbox initialized successfully!")
	
	# Dipanggil ketika ada teks baru di text_queue
func trigger_text_processing():
	# Jika sedang tidak membaca dan ada data di queue, langsung proses
	if not global.is_reading and global.text_queue.size() > 0:
		print("Triggering text processing...")
		_process_next_text()

# Dipanggil ketika ada teks baru di text_queue
func add_text(new_subject: String, new_message: String):
	global.text_queue.append({"type": "text", "subject": new_subject, "message": new_message})
	print("Text added to queue: ", new_subject, new_message)
	trigger_text_processing()  # Trigger dari textbox.gd

func add_animation(animation_name: String, duration: float):
	global.text_queue.append({"type": "animation", "animation": animation_name, "duration": duration})
	print("Animation added to queue: ", animation_name, duration)
	trigger_text_processing()  # Trigger dari textbox.gd

func _process(delta):
	# Deteksi input pemain untuk melanjutkan teks
	if Input.is_action_just_pressed("ui_accept") and not global.is_reading:
		print("Input detected: ui_accept")
		_process_next_text()

# Fungsi untuk memproses item berikutnya di Global.text_queue
func _process_next_text():
	if global.text_queue.size() == 0:
		# Jika queue kosong, sembunyikan textbox
		print("Text queue is empty, hiding textbox.")
		textbox_container.hide()
		global.is_reading = false
		global.player_movable = true
		return

	var current_item = global.text_queue.pop_front()  # Ambil item pertama di queue
	print("Processing item from queue: ", current_item)

	if current_item["type"] == "text":
		_process_text(current_item)
	elif current_item["type"] == "animation":
		_process_animation(current_item)

# Proses item teks
func _process_text(item):
	global.is_reading = true
	global.player_movable = false  # Nonaktifkan pergerakan player saat membaca teks
	textbox_container.show() 	# Tampilkan textbox
	print("Showing textbox: ", item)

	# Set teks subjek dan pesan
	subject.text = item["subject"]
	message.text = item["message"]
	message.visible_ratio = 0.0  # Mulai dengan teks tak terlihat
	end_message.text = ""

	# Tween untuk teks berjalan
	var tween = get_tree().create_tween()
	tween.tween_property(message, "visible_ratio", 1.0, message.text.length() * CHAR_READ_RATE)
	tween.finished.connect(_on_tween_finished)

# Proses item animasi
func _process_animation(item):
	global.is_reading = true
	textbox_container.hide()  # Sembunyikan textbox jika animasi berjalan
	print("Playing animation: ", item["animation"])
	$BlackoutAnimate.play(item["animation"])

	# Timer untuk durasi animasi
	var timer = Timer.new()
	timer.wait_time = item["duration"]
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_animation_finished"))
	add_child(timer)
	timer.start()

func _on_tween_finished():
	print("Tween finished. Displaying end message.")
	end_message.text = "Press space to continue"
	global.is_reading = false

func _on_animation_finished():
	print("Animation finished. Proceeding to next item.")
	global.is_reading = false
	_process_next_text()
