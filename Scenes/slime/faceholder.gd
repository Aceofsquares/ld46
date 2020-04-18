extends Node2D


export(Array, PackedScene) var faces = []

const MOOD = preload("res://Scenes/slime/mood_enum.gd")

var current_mood
var face_animation


func _ready():
	current_mood = MOOD.Mood.HAPPY
	set_face(current_mood)
	
func _input(event):
	if event.is_action_pressed("change_face"):
		current_mood += 1
		current_mood %= MOOD.Mood.size()
		set_face(current_mood)


func set_face(mood):
	if face_animation:
		face_animation.visible = false
	match current_mood:
		MOOD.Mood.HAPPY:
			face_animation = $HappyFace
		MOOD.Mood.SAD:
			face_animation = $SadFace
		MOOD.Mood.MEH:
			face_animation = $MehFace
	face_animation.visible = true
