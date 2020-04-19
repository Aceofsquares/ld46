extends Node

signal roll_die
signal state_changed(state)

const PipTypes = preload("res://Scenes/die/pip_enum.gd")
const GameStates = preload("res://Scenes/game/game_states.gd")

var round_number = 1

var state = GameStates.ROLL_DIE

var _transitions = {
	[GameStates.ROLL_DIE, GameStates.SELECT_DIE]: GameStates.SELECT_DIE,
	[GameStates.SELECT_DIE, GameStates.APPLY_DIE]: GameStates.APPLY_DIE,
	[GameStates.APPLY_DIE, GameStates.ROLL_DIE]: GameStates.ROLL_DIE,
}

var pip_selection = PipTypes.EMPTY

var die_rolls = []

func _ready():
	connect("state_changed", $UI/InstructionLabel, "_on_Main_state_changed")

func _process(delta):
	match state:
		GameStates.ROLL_DIE:
			roll_dice()
		GameStates.SELECT_DIE:
			continue
		GameStates.APPLY_DIE:
			die_rolls.clear()

func change_state(event):
	var transition = [state, event]
	if not transition in _transitions:
		return
	state = _transitions[transition]
	enter_state()
	emit_signal("state_changed", state)


func enter_state():
	pass


func apply_salt():
	apply_stat(PipTypes.SALT)

func apply_stat(pip):
	print("Apply Stats")
	state = GameStates.ROLL_DIE

func roll_dice():
	if Input.is_action_pressed("roll"):
		emit_signal("roll_die")
		state = GameStates.PERFORMING

func recieve_die_roll_pip(pip):
	die_rolls.append(pip)
	apply_salt()
	print(die_rolls)
	if len(die_rolls) == 3:
		state = GameStates.SELECT_DIE
