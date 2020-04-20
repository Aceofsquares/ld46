extends Node2D

signal status_applied(resource)
signal is_dead

const plus_sign = preload("res://Scenes/ui/hud/plus.png")
const minus_sign = preload("res://Scenes/ui/hud/minus.png")
const zero_sign = preload("res://Scenes/ui/hud/zero.png")

const salt_sound = preload("res://SoundFX/StatSounds/salt_hit.wav")
const applied_stat = preload("res://SoundFX/StatSounds/applied_stat.wav")

const MOOD = preload("res://Scenes/slime/mood_enum.gd")
const _resource = preload("res://Scenes/die/pip_enum.gd")

var fullness = 25 setget set_fullness
var quench = 25 setget set_quench
var entertained = 25 setget set_entertained
var energy = 25 setget set_energy

var has_died = false

func _ready():
	take_salt_damage()
	take_salt_damage()
	take_salt_damage()
	set_bars()
	check_if_dead()
	change_face()

func set_bars():
	$HUD/VBoxContainer/FullnessContainer/FullnessBarBG/FullnessBar.value = fullness
	$HUD/VBoxContainer/QuenchContainer/QuenchBarBG/QuenchBar.value = quench
	$HUD/VBoxContainer/EntertainmentContainer/EntertainmentBarBG/EntertainmentBar.value = entertained
	$HUD/VBoxContainer/EnergyContainer/EnergyBarBG/EnergyBar.value = energy

func apply_stat(resource):
	match resource:
		_resource.EMPTY:
			$SoundFX.stream = salt_sound
			$SoundFX.play()
			ignore_slime()
		_resource.WATER:
			$SoundFX.stream = applied_stat
			$SoundFX.play()
			drink_water()
		_resource.FOOD:
			$SoundFX.stream = applied_stat
			$SoundFX.play()
			eat_food()
		_resource.SLEEP:
			$SoundFX.stream = applied_stat
			$SoundFX.play()
			sleep()
		_resource.ENTERTAINMENT:
			$SoundFX.stream = applied_stat
			$SoundFX.play()
			be_entertained()
		_resource.SALT:
			$SoundFX.stream = salt_sound
			$SoundFX.play()
			take_salt_damage()
	set_bars()
	check_if_dead()
	change_face()
	emit_signal("status_applied", resource)

func check_if_dead():
	if fullness == 0 or quench == 0 or entertained == 0 or energy == 0:
		has_died = true
	if has_died:
		$AnimationPlayer.stop()
		emit_signal("is_dead")

func ignore_slime():
	self.fullness -= 1
	self.quench -= 1
	self.entertained -= 1
	self.energy -= 1

func eat_food():
	self.fullness += 4
	self.quench -= 2
	#self.entertained -= 3
	self.energy += 1

func drink_water():
	self.quench += 5
	self.entertained -= 3
	self.energy -= 2

func be_entertained():
	self.fullness -= 1
	self.quench -= 1
	self.entertained += 5
	self.energy -= 3

func sleep():
	self.fullness -= 2
	self.quench -= 2
	self.entertained += 1
	self.energy += 4


func take_salt_damage():
	randomize()
	var resource_die = randi() % 4
	var damage_die = (randi() % 7) + 1
	if resource_die == 0:
		self.fullness -= damage_die
	elif resource_die == 1:
		self.quench -= damage_die
	elif resource_die == 2:
		self.entertained -= damage_die
	elif resource_die == 3:
		self.energy -= damage_die

func set_fullness(value):
	fullness = value
	if fullness > 25:
		fullness = 25
	if fullness < 0:
		fullness = 0

func set_quench(value):
	quench = value
	if quench > 25:
		quench = 25
	if quench < 0:
		quench = 0

func set_entertained(value):
	entertained = value
	if entertained > 25:
		entertained = 25
	if entertained < 0:
		entertained = 0

func set_energy(value):
	energy = value
	if energy > 25:
		energy = 25
	if energy < 0:
		energy = 0

func change_face():
	if has_died:
		$FaceHolder.set_mood(MOOD.Mood.DEAD)
		return
	var sum = fullness + quench + entertained + energy
	var avg = sum / 4
	
	if avg > 18:
		$FaceHolder.set_mood(MOOD.Mood.HAPPY)
	elif avg > 15:
		$FaceHolder.set_mood(MOOD.Mood.MEH)
	elif avg > 5:
		$FaceHolder.set_mood(MOOD.Mood.SAD)
	elif avg > 0:
		$FaceHolder.set_mood(MOOD.Mood.MAD)


func set_sign(resource):
	match resource:
		_resource.EMPTY:
			$HUD/VBoxContainer/FullnessContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/QuenchContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EnergyContainer/Sign.texture = minus_sign
		_resource.WATER:
			$HUD/VBoxContainer/FullnessContainer/Sign.texture = zero_sign
			$HUD/VBoxContainer/QuenchContainer/Sign.texture = plus_sign
			$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EnergyContainer/Sign.texture = minus_sign
		_resource.FOOD:
			$HUD/VBoxContainer/FullnessContainer/Sign.texture = plus_sign
			$HUD/VBoxContainer/QuenchContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = zero_sign
			$HUD/VBoxContainer/EnergyContainer/Sign.texture = plus_sign
		_resource.SLEEP:
			$HUD/VBoxContainer/FullnessContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/QuenchContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = plus_sign
			$HUD/VBoxContainer/EnergyContainer/Sign.texture = plus_sign
		_resource.ENTERTAINMENT:
			$HUD/VBoxContainer/FullnessContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/QuenchContainer/Sign.texture = minus_sign
			$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = plus_sign
			$HUD/VBoxContainer/EnergyContainer/Sign.texture = minus_sign


func unset_sign():
	$HUD/VBoxContainer/FullnessContainer/Sign.texture = null
	$HUD/VBoxContainer/QuenchContainer/Sign.texture = null
	$HUD/VBoxContainer/EntertainmentContainer/Sign.texture = null
	$HUD/VBoxContainer/EnergyContainer/Sign.texture = null
