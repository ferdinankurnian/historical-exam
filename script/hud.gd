extends Control

@onready var obj_text = $PanelContainer/VBoxContainer/VBoxContainer/Obj_text
@onready var interact_sign = $PanelContainer/VBoxContainer/InteractSign

func _ready() -> void:
	interact_sign.text = ""

# Set text to display on object
func set_obj_text(textinput: String):
	obj_text.text = textinput

# Set interact sign text
func set_interact_sign(textinput: String):
	interact_sign.text = textinput

# Update function is left empty intentionally
func _process(delta: float) -> void:
	pass
