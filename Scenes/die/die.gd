extends Node2D

signal selected(pip)
signal finished_rolling
signal hovered_over(pip)
signal hover_exited

var current_pip setget set_current_pip, get_current_pip
const pip_types = preload("res://Scenes/die/pip_enum.gd")

var clicked_once = false

func _ready():
	current_pip = $Pip.current_pip

func get_current_pip():
	return current_pip

func set_current_pip(pip):
	current_pip = pip

func _on_Pip_finished_rolling(pip):
	self.current_pip = pip
	if self.current_pip == pip_types.SALT:
		modulate = Color(1, 1, 1, 0.5)
		$Area2D/CollisionShape2D.disabled = true
	emit_signal("finished_rolling", current_pip)


func _on_Area2D_mouse_entered():
	modulate = Color(0, 0.50, 0.75, 1)
	$DieLabel.text = pip_types.pip_text(current_pip)
	emit_signal("hovered_over", current_pip)
	
	

func _on_Area2D_mouse_exited():
	modulate = Color(1, 1, 1, 1)
	$DieLabel.text = ""
	clicked_once = false
	emit_signal("hover_exited")


func _on_Main_roll_die():
	$Area2D/CollisionShape2D.disabled = false
	modulate = Color(1, 1, 1, 1)
	$Pip.animate_die_roll()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if clicked_once:
			emit_signal("selected", current_pip)
			clicked_once = false
		else:
			clicked_once = true
