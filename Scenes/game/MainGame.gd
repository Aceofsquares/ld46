extends Node

signal roll_die
signal state_changed(state)

const PipTypes = preload("res://Scenes/die/pip_enum.gd")
const GameStates = preload("res://Scenes/game/game_states.gd")

var round_number = 1

var state = GameStates.ROLL_DIE

var _transitions = {
	[GameStates.ROLL_DIE, GameStates.SELECT_DIE]: GameStates.SELECT_DIE,
	[GameStates.ROLL_DIE, GameStates.APPLY_DIE]: GameStates.APPLY_DIE,
	[GameStates.SELECT_DIE, GameStates.APPLY_DIE]: GameStates.APPLY_DIE,
	[GameStates.APPLY_DIE, GameStates.ROLL_DIE]: GameStates.ROLL_DIE,
	[GameStates.APPLY_DIE, GameStates.GAME_OVER]: GameStates.GAME_OVER,
}

var pip_selection = PipTypes.EMPTY

var die_rolls = []

func _ready():
	connect("state_changed", $UI/InstructionLabel, "_on_Main_state_changed")


func _input(event):
	if state == GameStates.ROLL_DIE and event.is_action_pressed("roll"):
		emit_signal("roll_die")
		

func change_state(event):
	var transition = [state, event]
	if not transition in _transitions:
		return
	state = _transitions[transition]
	emit_signal("state_changed", state)


func apply_salt():
	apply_stat(PipTypes.SALT)

func apply_stat(pip):
	print("Apply Stats")
	change_state(GameStates.ROLL_DIE)

func roll_dice():
	if Input.is_action_pressed("roll"):
		emit_signal("roll_die")

func all(lst, variant):
	for elem in lst:
		if elem != variant:
			return false
	return true

func recieve_die_roll_pip(pip):
	die_rolls.append(pip)
	if pip == PipTypes.SALT:
		apply_salt()
	if len(die_rolls) == 3:
		if all(die_rolls, PipTypes.SALT):
			change_state(GameStates.APPLY_DIE)
		else:
			change_state(GameStates.SELECT_DIE)

func receive_selected_die(pip):
	change_state(GameStates.APPLY_DIE)
