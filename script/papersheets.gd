extends Control

signal quiz_completed

@onready var opt1 = $Panel/VBoxContainer/opt1
@onready var opt2 = $Panel/VBoxContainer/opt2
@onready var opt3 = $Panel/VBoxContainer/opt3
@onready var opt4 = $Panel/VBoxContainer/opt4
@onready var image = $Panel/VBoxContainer/image

@onready var panel = $"."

var questions = []
var current_question_index = 0
var count_correct = 0

func _ready() -> void:
	panel.visible = false
	set_questions(examsheets.send_questions_to_papersheets())
	
	if not opt1.is_connected("pressed", Callable(self, "_on_answer_selected")):
		opt1.connect("pressed", Callable(self, "_on_answer_selected").bind("A"))
	if not opt2.is_connected("pressed", Callable(self, "_on_answer_selected")):
		opt2.connect("pressed", Callable(self, "_on_answer_selected").bind("B"))
	if not opt3.is_connected("pressed", Callable(self, "_on_answer_selected")):
		opt3.connect("pressed", Callable(self, "_on_answer_selected").bind("C"))
	if not opt4.is_connected("pressed", Callable(self, "_on_answer_selected")):
		opt4.connect("pressed", Callable(self, "_on_answer_selected").bind("D"))

# Fungsi untuk menerima soal dari examsheets.gd
func set_questions(received_questions):
	questions = received_questions  # Simpan soal yang diterima
	print("Soal berhasil diterima: ", questions)
	
	# Mulai dengan memuat soal pertama
	load_question(0)

# Fungsi untuk memuat soal
func load_question(index):
	if index >= questions.size():
		print("Kuis selesai!")
		emit_signal("quiz_completed")
		var finalcount = count_correct * 20
		global.exam_score = finalcount
		panel.visible = false  # Tutup panel jika kuis selesai
		return

	var question_data = questions[index]

	# Memuat pertanyaan
	$Panel/VBoxContainer/Label.text = question_data["question"]

	# Memuat jawaban
	opt1.text = question_data["answers"][0]
	opt2.text = question_data["answers"][1]
	opt3.text = question_data["answers"][2]
	opt4.text = question_data["answers"][3]

	# Memuat gambar (jika ada)
	if question_data["image"] != "":
		image.texture = load(question_data["image"])
		image.visible = true
	else:
		image.visible = false

# Fungsi ini dipanggil ketika jawaban dipilih
func _on_answer_selected(answer_letter):
	var correct_answer = questions[current_question_index]["correct"]
	if answer_letter == correct_answer:
		count_correct += 1
		print("Jawaban benar!")
	else:
		print("Jawaban salah! Jawaban yang benar adalah:", correct_answer)

	current_question_index += 1
	load_question(current_question_index)
