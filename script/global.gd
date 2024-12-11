extends Node

# Act Flags
var act1 = false
var act2 = false
var act3 = false

# Current and Transition Act Management
var current_act = "class"
var transition_act = false
var game_first_loading = true

var block_continue = false

# Exam Score
var exam_score = 0
var givepapersheets = false

# Player Movement
var player_movable = true

func checkAct():
	print()
	print("current_act:")
	print(current_act)
	print()
	print("Act 1: ")
	print(act1)
	print("Act 2: ")
	print(act2)
	print("Act 3: ")
	print(act3)

# Function to save variables to JSON
func saveAct() -> void:
	# Create a dictionary to store the state of the variables
	var act_data : Dictionary = {
		"act1": act1,
		"act2": act2,
		"act3": act3
	}
	
	# Convert the dictionary to a JSON string
	var json_data : String = JSON.stringify(act_data)
	
	# Specify the file path where the JSON will be saved
	var file_path : String = "user://act_data.json"
	
	# Open the file for writing (create the file if it doesn't exist)
	var file : FileAccess = FileAccess.open(file_path, FileAccess.WRITE)
	
	if file:
		# Write the JSON data to the file
		file.store_string(json_data)
		file.close()
		print("Data saved successfully.")
	else:
		print("Failed to open file for writing.")

# Function to create new game data and transition to Act 1
func newGameAct() -> void:
	# Set the flags to start a new game (Act 1)
	act1 = true
	act2 = false
	act3 = false
	
	# Save the new game data to file
	saveAct()
	
	# Transition to Act 1
	get_tree().change_scene_to_file("res://scenes/class.tscn")
	print("New game started, Act 1 entered.")

# Function to check if the save file exists
func check_save_data() -> bool:
	var file_path : String = "user://act_data.json"
	return FileAccess.file_exists(file_path)

# Function to load the saved act and change scene accordingly
func loadAct() -> void:
	var file_path : String = "user://act_data.json"
	
	if FileAccess.file_exists(file_path):
		var file : FileAccess = FileAccess.open(file_path, FileAccess.READ)
		
		if file:
			var json_data : String = file.get_as_text()
			file.close()
			
			# Create an instance of JSON to parse the data
			var json : JSON = JSON.new()
			var parse_result = json.parse(json_data)
			
			if parse_result == OK:
				var act_data : Dictionary = json.get_data()
				
				# Load the act data from the JSON
				act1 = act_data.get("act1", false)
				act2 = act_data.get("act2", false)
				act3 = act_data.get("act3", false)
				
				# Change scene based on the act
				if act1:
					get_tree().change_scene_to_file("res://scenes/class.tscn")
					print("Act 1 in")
				elif act2:
					get_tree().change_scene_to_file("res://scenes/library.tscn")
					print("Act 2 in")
				elif act3:
					get_tree().change_scene_to_file("res://scenes/class.tscn")
					print("Act 3 in")
			else:
				print("Failed to parse JSON data.")
		else:
			print("Failed to open file for reading.")
	else:
		print("No save data found. Starting a new game.")
		# If no save data, start a new game
		newGameAct()

# Functions to Manage Act Transition
func finish_changeact():
	if transition_act:
		transition_act = false
		current_act = "library" if current_act == "class" else "class"

func set_player_move(check: bool):
	player_movable = check
