extends Node2D


export(Array, PackedScene) var faces = []

var current_mood
var face_animation

enum Face {
	HAPPY=0,
	SAD=1,
	MEH=2,
}

func _ready():
	current_mood = Face.HAPPY
	set_face(current_mood)
	
func _input(event):
	if event.is_action_pressed("change_face"):
		current_mood += 1
		current_mood %= Face.size()
		set_face(current_mood)


func set_face(mood):
	if face_animation:
		face_animation.visible = false
	match current_mood:
		Face.HAPPY:
			face_animation = $HappyFace
		Face.SAD:
			face_animation = $SadFace
		Face.MEH:
			face_animation = $MehFace
	face_animation.visible = true
