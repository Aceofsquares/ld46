extends Sprite

signal done_animating
signal finished_rolling(pip)

const pip_types = preload("res://Scenes/die/pip_enum.gd")

var pip_textures = {
	pip_types.EMPTY: null,
	pip_types.FOOD: preload("res://Textures/die/Die-Pip-Food.png"),
	pip_types.ENTERTAINMENT: preload("res://Textures/die/Die-Pip-Entertainment.png"),
	pip_types.SLEEP: preload("res://Textures/die/Die-Pip-Sleep.png"),
	pip_types.WATER: preload("res://Textures/die/Die-Pip-Water.png"),
	pip_types.SALT:  preload("res://Textures/die/Die-Pip-Salt.png"),
}

var pips = []
var pips_copy = []
var current_pip

func _ready():
	for pip in pip_textures.keys():
		pips.append(pip)
		pips_copy.append(pip)
	current_pip = pip_types.EMPTY
	
func set_pip_texture(pip):
	texture = pip_textures[pip]

func animate_die_roll():
	randomize()
	var ri = randi() % len(pips)
	for i in range((randi() % 15) + 5):
		set_pip_texture(pips[ri])
		ri += 1
		ri %= len(pips)
		yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("done_animating")

func roll_die():
	var die_roll = randi() % 61
	if die_roll > 55:
		current_pip = pip_types.SALT 
	elif die_roll > 50:
		current_pip = pip_types.EMPTY
	elif die_roll > 35:
		current_pip = pip_types.FOOD
	elif die_roll > 25:
		current_pip = pip_types.WATER
	elif die_roll > 15:
		current_pip = pip_types.ENTERTAINMENT
	else:
		current_pip = pip_types.SLEEP
	set_pip_texture(current_pip)
	emit_signal("finished_rolling", current_pip)
