extends Label

const GameStates = preload("res://Scenes/game/game_states.gd")

var _state_text = {
	GameStates.ROLL_DIE: "Press SPACEBAR to roll die",
	GameStates.SELECT_DIE: "Select an activity to do",
	GameStates.APPLY_DIE: "Doing Activity",
}

func _on_Main_state_changed(state):
	text = _state_text[state]
