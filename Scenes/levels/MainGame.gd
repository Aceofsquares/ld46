extends Node

signal roll_die

var rolled_die = false
var round_number = 1

var die_rolls = []

func _input(event):
	if event.is_action_pressed("roll") and not rolled_die:
		rolled_die = true
		emit_signal("roll_die")


func recieve_die_roll_pip(pip):
	die_rolls.append(pip)
	print(die_rolls)
