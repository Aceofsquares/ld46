extends Node2D

signal selected

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


func _process(delta):
	$Tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(1.5,1.5), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
func _on_Area2D_mouse_entered():
	modulate = Color(0, 0.50, 0.75, 1)
	tween_up = true
	

func _on_Area2D_mouse_exited():
	modulate = Color(1, 1, 1, 1)
	tween_down = true
