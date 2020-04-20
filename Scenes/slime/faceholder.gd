extends Node2D


export(Array, PackedScene) var faces = []

const MOOD = preload("res://Scenes/slime/mood_enum.gd")

var current_mood setget set_mood
var face_animation


func _ready():
	self.current_mood = MOOD.Mood.HAPPY
	
#func _input(event):
#	if event.is_action_pressed("change_face"):
#		current_mood += 1
#		set_face(current_mood)

func _process(_delta):
	if face_animation:
		face_animation.visible = false
	match current_mood:
		MOOD.Mood.HAPPY:
			face_animation = $HappyFace
		MOOD.Mood.SAD:
			face_animation = $SadFace
		MOOD.Mood.MEH:
			face_animation = $MehFace
		MOOD.Mood.MAD:
			face_animation = $MadFace
		MOOD.Mood.DEAD:
			face_animation = $DeadFace
	face_animation.visible = true

func set_mood(mood):
	current_mood = mood
	
