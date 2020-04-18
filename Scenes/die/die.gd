extends Node2D

const pip_types = preload("res://Scenes/die/pip_enum.gd")

func _on_Pip_finished_rolling(pip):
	print(pip)
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
