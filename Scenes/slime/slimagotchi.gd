extends Node2D

signal status_applied(resource)

const _resource = preload("res://Scenes/die/pip_enum.gd")

var hunger = 25
var thirst = 25
var boredom = 25
var energy = 25


func apply_stat(resource):
	print("APPLYING " + _resource.pip_text(resource))
	match resource:
		_resource.EMPTY:
			pass
		_resource.WATER:
			pass
		_resource.FOOD:
			pass
		_resource.SLEEP:
			pass
		_resource.ENTERTAINMENT:
			pass
		_resource.SALT:
			pass
	emit_signal("status_applied", resource)
