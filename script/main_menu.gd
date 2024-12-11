extends Control

@onready var new_game_button = $PanelContainer/VBoxContainer/NewGameButton  # Tombol New Game
@onready var confirmation_dialog = $ConfirmationDialog  # Modal konfirmasi
@onready var option_panel = $OptionsPanel

func _ready() -> void:
	if global.check_save_data():  # Jika ada data
		$PanelContainer/VBoxContainer/ContinueButton.disabled = false  # Aktifkan tombol Continue
		print("Save data found. Continue enabled.")
	else:
		$PanelContainer/VBoxContainer/ContinueButton.disabled = true  # Matikan tombol Continue
		print("No save data found. Continue disabled.")
	
	if global.block_continue:
		$PanelContainer/VBoxContainer/ContinueButton.disabled = true

func _on_continue_button_pressed() -> void:
	global.loadAct()

func _on_new_game_button_pressed() -> void:
	confirmation_dialog.popup_centered()

func _on_confirmation_dialog_confirmed() -> void:
	global.newGameAct()

func _on_confirmation_dialog_canceled() -> void:
	confirmation_dialog.hide()
	

func _on_option_button_pressed() -> void:
	option_panel.show()

func _on_done_options_pressed() -> void:
	option_panel.hide()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
