extends Node2D

signal selected(pip)
signal finished_rolling

var current_pip setget set_current_pip, get_current_pip
const pip_types = preload("res://Scenes/die/pip_enum.gd")

var clicked_once = false

func _ready():
	current_pip = $Pip.current_pip

func get_current_pip():
	return current_pip

func set_current_pip(pip):
	current_pip = pip

func _on_Pip_finished_rolling(pip):
	self.current_pip = pip
	emit_signal("finished_rolling", current_pip)


func _on_Area2D_mouse_entered():
	modulate = Color(0, 0.50, 0.75, 1)
	$DieLabel.text = pip_types.pip_text(current_pip)
	

func _on_Area2D_mouse_exited():
	modulate = Color(1, 1, 1, 1)
	$DieLabel.text = ""
	clicked_once = false


func _on_Main_roll_die():
	$Pip.animate_die_roll()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print(clicked_once)
		if clicked_once:
			emit_signal("selected", current_pip)
			clicked_once = false
		else:
			clicked_once = true
