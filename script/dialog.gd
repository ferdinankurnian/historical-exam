extends Node

# Dialogue Act 1
var act1_teacher_1 = "Oke, baik anak-anak, besok kita ada ulangan sejarah, ya."
var act1_teacher_2 = "Materinya tentang Sejarah Pemberontakan di Indonesia."
var act1_teacher_3 = "Jadi silakan kalian pelajari sendiri dulu, ya."
var act1_students_4 = "Siap, Pak!"
var act1_teacher_5 = "Ingat, kalau nilainya di bawah 80, siap-siap bersih-bersih toilet sekolah."
var act1_students_6 = "Siap, Pak..."
var act1_bayu_7 = "Wah, pokoknya besok aku harus dapet di atas 80. Masa iya, nanti malah bersihin toilet"
var act1_bayu_8 = "Tapi kok, materinya ga ada di buku, ya? Ah, mending ke perpustakaan aja deh, cari-cari referensi."

# Dialogue Act 2
var act2_bayu_1 = "Nah, sampai juga di perpustakaan. "
var act2_bayu_2 = "Pertama-tama, setorin kartu perpustakaan dulu biar bisa pinjem buku."
var act2_librarian_3 = "Halo, dek! Ada yang bisa dibantu?"
var act2_bayu_4 = "Iya, Bu, saya mau baca buku."
var act2_librarian_5 = "Oke, boleh lihat kartu perpustakaannya dulu, ya?"
var act2_bayu_6 = "Siap, Bu. Nih, kartunya."
var act2_librarian_7 = "Oke, udah beres. Silakan baca bukunya, dek!"
var act2_bayu_8 = "Oke makasih, Bu."
var act2_bayu_9 = "Oke, sudah semua nya, sekarang akan ku baca."
var act2_bayu_10 = "Oke, buku-bukunya udah selesai. Waktunya pulang, ah."

# Dialogue Act 3
var act3_teacher_1 = "Oke anak-anak, kita mulai ulangannya, ya. Semoga hasilnya bagus!"
var act3_teacher_2 = "Dan ingat, siapa yang nilainya di bawah 80, siap-siap bersihin kamar mandi! wkwkwk"
var act3_students_3 = "Siap, Pak..."
var act3_teacher_4 = "Oke, anak-anak, ini hasil ulangan sejarah kalian. "
var act3_teacher_5 = "Indra, kamu dapet 90."
var act3_teacher_6 = "Sari, 80."

func act3_result_bayu(passe: bool, result: String):
	if passe == true:
		var act3_teacher_7 = "Bayu, nilaimu " + result + "! Bagus!"
		var act3_bayu_8 = "Yes, nilaiku bagus!"
		var act3_bayu_9 = "Ga sia-sia belajar ke perpustakaan kemarin."
	else:
		var act3_teacher_7 = "Bayu, nilaimu… " + result + ". Nah, siap-siap bersih-bersih kamar mandi, ya!"
		var act3_bayu_8 = "Ahh.. tidakk.."
		var act3_bayu_9 = "Ah, serius bersih-bersih kamar mandi?"
