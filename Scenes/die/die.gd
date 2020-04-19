extends Node2D

signal selected
signal finished_rolling

var current_pip setget set_current_pip, get_current_pip
const pip_types = preload("res://Scenes/die/pip_enum.gd")

var tween_up = false
var tween_down = false

func get_current_pip():
	return current_pip

func set_current_pip(pip):
	current_pip = pip

func _on_Pip_finished_rolling(pip):
	self.current_pip = pip
	match pip:
		pip_types.EMPTY:
			print("empty")
		pip_types.SALT:
			print("salt")
		pip_types.FOOD:
			print("food")
		pip_types.ENTERTAINMENT:
			print("entertainment")
		pip_types.WATER:
			print("water")
		pip_types.SLEEP:
			print("sleep")
	emit_signal("finished_rolling", current_pip)


func _on_Area2D_mouse_entered():
	modulate = Color(0, 0.50, 0.75, 1)
	tween_up = true
	

func _on_Area2D_mouse_exited():
	modulate = Color(1, 1, 1, 1)
	tween_down = true


func _on_Main_roll_die():
	$Pip.animate_die_roll()
