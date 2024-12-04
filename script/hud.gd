extends Control

@onready var obj_text = $PanelContainer/VBoxContainer/VBoxContainer/Obj_text
@onready var interact_sign = $PanelContainer/VBoxContainer/InteractSign

func _ready() -> void:
	interact_sign.text = ""

func set_obj_text(textinput: String):
	obj_text.text = textinput

func set_interact_sign(textinput: String):
	interact_sign.text = textinput

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
