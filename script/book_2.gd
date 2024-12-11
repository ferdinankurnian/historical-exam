extends Panel

@onready var page1 = $page_1
@onready var page2 = $page_2
@onready var page3 = $page_3
@onready var prev_button = $prev_button
@onready var next_button = $next_button

# Variabel untuk melacak halaman yang ditampilkan
var current_page = 0
var pages = []
var library = null  # Referensi ke scene utama (library.gd)

func _ready():
	# Menambahkan halaman ke array `pages`
	if page1 != null:
		pages.append(page1)
	if page2 != null:
		pages.append(page2)
	if page3 != null:
		pages.append(page3)

	show_page(current_page)

	# Menghubungkan tombol navigasi ke fungsi
	prev_button.connect("pressed", Callable(self, "_on_prev_button_pressed"))
	next_button.connect("pressed", Callable(self, "_on_next_button_pressed"))

	# Update status tombol
	update_button_state()

# Fungsi untuk menerima referensi ke library.gd
func set_library(library_ref):
	library = library_ref

# Fungsi untuk menampilkan halaman
func show_page(page_index: int):
	# Sembunyikan semua halaman
	for page in pages:
		page.visible = false

	# Tampilkan halaman yang sesuai
	pages[page_index].visible = true

# Fungsi ketika tombol Prev ditekan
func _on_prev_button_pressed():
	if current_page > 0:
		current_page -= 1
		show_page(current_page)
	else:
		# Jika di halaman pertama, panggil fungsi `go_to_prev_book` di library
		if library != null:
			library.go_to_prev_book()

	update_button_state()

# Fungsi ketika tombol Next ditekan
func _on_next_button_pressed():
	if current_page < pages.size() - 1:
		current_page += 1
		show_page(current_page)
	else:
		# Jika di halaman terakhir, panggil fungsi `go_to_next_book` di library
		if library != null:
			library.go_to_next_book()

	update_button_state()

# Fungsi untuk update status tombol
func update_button_state():
	prev_button.disabled = current_page == 0 and library == null
	next_button.disabled = current_page == pages.size() - 1 and library == null
