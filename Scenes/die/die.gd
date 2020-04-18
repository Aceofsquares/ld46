extends Node2D

enum Pip {
	EMPTY,
	FOOD,
	ENTERTAINMENT,
	SLEEP,
	WATER,
	SALT,
}


var pip_textures = {
	Pip.EMPTY: null,
	Pip.FOOD: preload("res://Textures/die/Die-Pip-Food.png"),
	Pip.ENTERTAINMENT: preload("res://Textures/die/Die-Pip-Entertainment.png"),
	Pip.SLEEP: preload("res://Textures/die/Die-Pip-Sleep.png"),
	Pip.WATER: preload("res://Textures/die/Die-Pip-Water.png"),
	Pip.SALT:  preload("res://Textures/die/Die-Pip-Salt.png"),
}

var pips = []
var pips_copy = []

var current_pip

func _ready():
	for pip in pip_textures.keys():
		pips.append(pip)
		pips_copy.append(pip)
	current_pip = Pip.EMPTY
	

func set_pip_texture():
	$Pip.texture = pip_textures[current_pip]

func _input(event):
	if event.is_action_pressed("Roll"):
		var die_roll = randi() % 61
		var index = -1
		if die_roll > 55:
			current_pip = Pip.SALT 
		elif die_roll > 50:
			current_pip = Pip.EMPTY
		elif die_roll > 35:
			current_pip = Pip.FOOD
		elif die_roll > 25:
			current_pip = Pip.WATER
		elif die_roll > 15:
			current_pip = Pip.ENTERTAINMENT
		else:
			current_pip = Pip.SLEEP
	set_pip_texture()
