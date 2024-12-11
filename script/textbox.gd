extends CanvasLayer

@onready var text_box = $TextboxContainer
@onready var label_subject = $TextboxContainer/MarginContainer/VBoxContainer/Subject
@onready var label_message = $TextboxContainer/MarginContainer/VBoxContainer/Message

signal queue_finished
signal dialog_started
signal dialog_ended

var current_text_index = 0
var text_queue = []  # Queue untuk menampung teks-teks yang akan ditampilkan

func _ready():
	text_box.visible = false  # Mulai dengan Textbox tersembunyi

# Menghandle input untuk melanjutkan teks
func _input(event):
	if event.is_action_pressed("ui_accept"):  # Input untuk lanjut dialog
		if text_queue.size() > 0:  # Hanya jika ada teks di queue
			show_next_text()
		elif not text_box.visible:  # Jika queue kosong dan textbox tidak terlihat
			return  # Abaikan input (tidak memanggil blackout)

func add_blackout_to_queue():
	text_queue.append({"type": "blackout"})

# Fungsi untuk menambahkan teks ke dalam queue
func add_text_to_queue(subject: String, message: String):
	text_queue.append({"subject": subject, "message": message})
	# Jika textbox tidak terlihat dan queue baru dimulai
	if not text_box.visible and current_text_index == text_queue.size() - 1:
		show_next_text()

# Fungsi untuk menampilkan teks berikutnya
func show_next_text():
	if current_text_index < text_queue.size():
		var current_text = text_queue[current_text_index]
		
		if current_text.has("type") and current_text["type"] == "blackout":
			emit_signal("queue_finished")
			current_text_index += 1  # Lanjutkan ke teks berikutnya
			show_next_text()  # Otomatis proses teks berikutnya setelah blackout
			return  # Berhenti memproses teks saat ini
		
		if current_text_index == 0:
			emit_signal("dialog_started") 
		
		# Jika bukan blackout, tampilkan teks
		showtextbox(current_text.get("subject", ""), current_text.get("message", ""))
		current_text_index += 1
	else:
		global.player_movable = true
		text_box.visible = false
		emit_signal("dialog_ended")  # Emit sinyal dialog selesai
		emit_signal("queue_finished")

# Fungsi untuk menampilkan teks
func showtextbox(subject: String, message: String):
	text_box.visible = true  # Menampilkan Textbox
	global.player_movable = false
	label_subject.text = subject
	label_message.text = message

func is_queue_empty() -> bool:
	return text_queue.size() == 0
