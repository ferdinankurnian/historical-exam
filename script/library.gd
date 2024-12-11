extends Node2D

@onready var hud = $HUD/HUD
@onready var textbox = $Textbox
@onready var book_viewport = $view_book/book_viewport
@onready var prev_button = $view_book/prev_button
@onready var next_button = $view_book/next_button

@export var books = ["res://scenes/book_1.tscn", "res://scenes/book_2.tscn", "res://scenes/book_3.tscn"]
var current_book_index = 0
var current_book = null

var going_to_act3 = false
var on_librarian_area = false
var on_book1_area = false
var on_book2_area = false
var on_book3_area = false
var on_sit_read_area = false
var after_brought_book = false

# To do objective
var talk_to_librarian = false
var get_book_1 = false
var get_book_2 = false
var get_book_3 = false
var book_brought = 0
var sit_read_on_table = false

func _ready() -> void:
	$Textbox.connect("queue_finished", Callable(self, "_on_queue_finished"))
	$Textbox.connect("dialog_ended", Callable(self, "_on_dialog_ended"))
	showBookIndicator(false)
	showAlertIndicator(false)
	$BlackoutAnimation.play("changescene_out")
	global.checkAct()
	
	if global.act2:
		hud.visible = false
		$Alert1.visible = true
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_1)
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_2)
		hud.set_obj_text("Setor kartu perpus")

func _on_dialog_ended():
	hud.visible = true

func _process(delta: float) -> void:
	change_act()
	# On Librarian Interact Area
	if on_librarian_area and Input.is_action_pressed("interact"):
		hud.visible = false
		on_librarian_area = false
		talk_to_librarian = true
		$Alert1.visible = false
		textbox.add_text_to_queue("Librarian", dialog.act2_librarian_3)
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_4)
		textbox.add_text_to_queue("Librarian", dialog.act2_librarian_5)
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_6)
		textbox.add_text_to_queue("Librarian", dialog.act2_librarian_7)
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_8)
		hud.set_interact_sign("")
		hud.set_obj_text("Cari 3 Buku")
	
	# On Book 1 Interact Area
	if on_book1_area and Input.is_action_just_pressed("interact"):
		get_book_1 = true
		on_book1_area = false
		$BookIndict1.visible = false
		book_brought += 1
		hud.set_obj_text("Cari 3 Buku - " + str(book_brought) + " dari 3")
		hud.set_interact_sign("")
	
	# On Book 2 Interact Area
	if on_book2_area and Input.is_action_just_pressed("interact"):
		get_book_2 = true
		on_book2_area = false
		$BookIndict2.visible = false
		book_brought += 1
		hud.set_obj_text("Cari 3 Buku - " + str(book_brought) + " dari 3")
		hud.set_interact_sign("")
	
	# On Book 3 Interact Area
	if on_book3_area and Input.is_action_just_pressed("interact"):
		get_book_3 = true
		on_book3_area = false
		$BookIndict3.visible = false
		book_brought += 1
		hud.set_obj_text("Cari 3 Buku - " + str(book_brought) + " dari 3")
		hud.set_interact_sign("")
	
	# Check if book is 3
	if book_brought == 3 and after_brought_book == false:
		textbox.add_text_to_queue("Bayu", dialog.act2_bayu_9)
		hud.set_obj_text("Duduk")
		$Alert2.visible = true
		after_brought_book = true
	
	# On Sit Table Read Area
	if on_sit_read_area and Input.is_action_just_pressed("interact"):
		sit_read_on_table = true
		on_sit_read_area = false
		$Alert2.visible = false
		hud.set_interact_sign("")
		load_book(current_book_index)
		update_navigation_buttons()


# Talk with Librarian
func _on_talk_to_librarian_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if talk_to_librarian == false:
			on_librarian_area = true
			hud.set_interact_sign("Tekan [E] untuk Bicara dengan Librarian")

func _on_talk_to_librarian_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")


# Trigger All Searchable Book Indicators
func _on_talkself_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if talk_to_librarian == true and sit_read_on_table == false:
			showBookIndicator(true)
			hud.set_obj_text("Cari 3 Buku - 0 dari 3")

func _on_talkself_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if talk_to_librarian == true:
			pass


# Book 1
func _on_get_book_1_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if get_book_1 == false:
			on_book1_area = true
			hud.set_interact_sign("Tekan [E] untuk Ambil Buku")

func _on_get_book_1_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")


# Book 2
func _on_get_book_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if get_book_2 == false:
			on_book2_area = true
			hud.set_interact_sign("Tekan [E] untuk Ambil Buku")


func _on_get_book_2_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")


# Book 3
func _on_get_book_3_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if get_book_3 == false:
			on_book3_area = true
			hud.set_interact_sign("Tekan [E] untuk Ambil Buku")

func _on_get_book_3_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")



func showAlertIndicator(event:bool):
	$Alert1.visible = event
	$Alert2.visible = event

func showBookIndicator(event: bool):
	$BookIndict1.visible = event
	$BookIndict2.visible = event
	$BookIndict3.visible = event


# Sit on Table
func _on_sit_on_table_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if book_brought == 3 and sit_read_on_table == false:
			on_sit_read_area = true
			hud.set_interact_sign("Tekan [E] untuk Duduk")

func _on_sit_on_table_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		hud.set_interact_sign("")


# Call Book
func load_book(index: int):
	var book_scene = load(books[index])
	current_book = book_scene.instantiate()
	book_viewport.add_child(current_book)
	current_book.set_library(self)
	$view_book.visible = true
	global.player_movable = false

# Fungsi untuk navigasi antar buku
func go_to_next_book():
	if current_book_index < books.size() - 1:
		current_book_index += 1
		load_book(current_book_index)
		update_navigation_buttons()
	else:
		print("Sudah di buku terakhir!")

func go_to_prev_book():
	if current_book_index > 0:
		current_book_index -= 1
		load_book(current_book_index)
		update_navigation_buttons()
	else:
		print("Sudah di buku pertama!")

# Update status tombol navigasi antar buku
func update_navigation_buttons():
	prev_button.disabled = current_book_index == 0
	next_button.disabled = current_book_index == books.size() - 1

# Tombol global (jika ingin digunakan)
func _on_prev_button_pressed():
	go_to_prev_book()

func _on_next_button_pressed():
	go_to_next_book()

func on_end_of_last_book():
	textbox.add_text_to_queue("Bayu", dialog.act2_bayu_10)
	hud.set_obj_text("Pulang")
	going_to_act3 = true
	
	# Menutup buku yang sedang dibuka
	if current_book != null:
		current_book.queue_free()  # Menghapus instance buku dari scene tree
		current_book = null  # Reset variabel instance buku
	
	$view_book.visible = false
	global.player_movable = false


# Handle transition to class scene
func _on_outlibrary_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if going_to_act3:
			global.transition_act = true
			global.act2 = false
			global.act3 = true

func _on_outlibrary_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if going_to_act3:
			global.transition_act = false

# Change the act if necessary
func change_act():
	if global.transition_act and global.current_act == "library":
		$BlackoutAnimation.play("changescene_in")

# Scene transition when animation ends
func _on_blackout_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "changescene_in":
		get_tree().change_scene_to_file("res://scenes/class.tscn")
		global.finish_changeact()
