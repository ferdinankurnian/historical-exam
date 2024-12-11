extends Node

# Daftar soal dan pilihan jawabannya
var soal = [
	{
		"question": "Siapa yang memimpin pemberontakan DI/TII?", 
		"answers": [
			"A. D.N. Aidit", 
			"B. Kartosoewiryo", 
			"C. A.M. Nasution", 
			"D. Sultan Hamid II"
		], 
		"correct": "B",  # Jawaban yang benar adalah B
		"image": ""
	},
	{
		"question": "Apa tujuan utama pemberontakan DI/TII?", 
		"answers": [
			"A. Menuntut otonomi daerah", 
			"B. Mendirikan negara Islam di Indonesia", 
			"C. Menggulingkan Presiden Soekarno", 
			"D. Memperjuangkan kemerdekaan dari Belanda"
		], 
		"correct": "B",  # Jawaban yang benar adalah B
		"image": ""
	},
	{
		"question": "Pada tahun berapakah pemberontakan PRRI/Permesta dimulai?", 
		"answers": [
			"A. 1950", 
			"B. 1956", 
			"C. 1958", 
			"D. 1965"
		], 
		"correct": "C",  # Jawaban yang benar adalah C
		"image": ""
	},
	{
		"question": "Siapa tokoh utama yang terlibat dalam pemberontakan G30S/PKI?", 
		"answers": [
			"A. A.M. Nasution", 
			"B. Sultan Hamid II", 
			"C. D.N. Aidit", 
			"D. Kartosoewiryo"
		], 
		"correct": "C",  # Jawaban yang benar adalah C
		"image": ""
	},
	{
		"question": "Apa yang menjadi alasan utama pemberontakan PRRI/Permesta?", 
		"answers": [
			"A. Menuntut pemerintahan komunis", 
			"B. Menuntut otonomi daerah lebih besar", 
			"C. Mendirikan negara Islam", 
			"D. Menggulingkan pemerintahan Presiden Soekarno"
		], 
		"correct": "B",  # Jawaban yang benar adalah B
		"image": ""
	},
	{
		"question": "Siapakah ini?", 
		"answers": [
			"A. D.N. Aidit", 
			"B. Kartosoewiryo", 
			"C. Sultan Hamid II", 
			"D. Presiden Soekarno"
		], 
		"correct": "A",  # Jawaban yang benar adalah A
		"image": "res://assets/bookimg/dnaidit.jpeg"
	},
	{
		"question": "Siapakah ini?", 
		"answers": [
			"A. D.N. Aidit", 
			"B. Kartosoewiryo", 
			"C. Sultan Hamid II", 
			"D. Presiden Soekarno"
		], 
		"correct": "B",  # Jawaban yang benar adalah B
		"image": "res://assets/bookimg/kartosoewiryo.jpeg"
	},
	{
		"question": "Siapakah ini?", 
		"answers": [
			"A. D.N. Aidit", 
			"B. Kartosoewiryo", 
			"C. Sultan Hamid II", 
			"D. Kolonel Ventje Sumual"
		], 
		"correct": "D",  # Jawaban yang benar adalah D
		"image": "res://assets/bookimg/ventjesumual.jpeg"
	},
]

# Fungsi untuk mengambil 5 soal secara acak
func get_random_questions(count):
	if count > soal.size():
		count = soal.size()
	soal.shuffle()
	var random_questions = []
	for i in range(count):
		random_questions.append(soal[i])
	return random_questions

# Memanggil papersheets.gd untuk mengirim soal
func send_questions_to_papersheets():
	var random_questions = get_random_questions(5)
	return random_questions
