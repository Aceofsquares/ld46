extends Node

signal roll_die
signal state_changed(state)

const PipTypes = preload("res://Scenes/die/pip_enum.gd")
const GameStates = preload("res://Scenes/game/game_states.gd")

var round_number = 1

var state = GameStates.ROLL_DIE
var salt_applied = 0
var is_rolling = false

var _transitions = {
	[GameStates.ROLL_DIE, GameStates.SELECT_DIE]: GameStates.SELECT_DIE,
	[GameStates.ROLL_DIE, GameStates.APPLY_DIE]: GameStates.APPLY_DIE,
	[GameStates.ROLL_DIE, GameStates.ROLL_DIE]: GameStates.ROLL_DIE,
	[GameStates.SELECT_DIE, GameStates.APPLY_DIE]: GameStates.APPLY_DIE,
	[GameStates.APPLY_DIE, GameStates.ROLL_DIE]: GameStates.ROLL_DIE,
	[GameStates.APPLY_DIE, GameStates.GAME_OVER]: GameStates.GAME_OVER,
}

var pip_selection = PipTypes.EMPTY

var die_rolls = []

func _ready():
	connect("state_changed", $UI/InstructionLabel, "_on_Main_state_changed")


func _input(event):
	if state == GameStates.ROLL_DIE and event.is_action_pressed("roll") and not is_rolling:
		emit_signal("roll_die")
		$SoundFX.play()
		is_rolling = true
		

func change_state(event):
	var transition = [state, event]
	if not transition in _transitions:
		return
	state = _transitions[transition]
	emit_signal("state_changed", state)


func apply_salt():
	apply_stat(PipTypes.SALT)

func apply_stat(pip):
	$Slimagotchi.apply_stat(pip)

func all(lst, variant):
	for elem in lst:
		if elem != variant:
			return false
	return true

func recieve_die_roll_pip(pip):
	die_rolls.append(pip)
	
	#Automatically apply salt stat
	if pip == PipTypes.SALT:
		apply_stat(pip)
	if len(die_rolls) == 3:
		if all(die_rolls, PipTypes.SALT):
			change_state(GameStates.ROLL_DIE)
		else:
			change_state(GameStates.SELECT_DIE)


func receive_selected_die(pip):
	if state == GameStates.SELECT_DIE:
		change_state(GameStates.APPLY_DIE)
		apply_stat(pip)
		die_rolls.clear()
		is_rolling = false


func _on_Slimagotchi_status_applied(resource):
	if resource == PipTypes.SALT:
		salt_applied += 1
	if salt_applied == 3:
		change_state(GameStates.ROLL_DIE)
		salt_applied = 0
	elif resource != PipTypes.SALT:
		change_state(GameStates.ROLL_DIE)
		salt_applied = 0


func _on_RestartBtn_pressed():
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	$UI/GameOverBG/GameOver/GameOverLabel.text = "Thanks for playing!"
	$UI/GameOverBG/GameOver/HBoxContainer/RestartBtn.visible = false
	$UI/GameOverBG/GameOver/HBoxContainer/Quit.visible = false
	yield(get_tree().create_timer(3), "timeout")
	get_tree().quit()


func _on_Slimagotchi_is_dead():
	$UI/GameOverBG.visible = true
