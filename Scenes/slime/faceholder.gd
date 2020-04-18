extends Node2D


export(Array, PackedScene) var faces = []

var current_mood

enum Face {
	HAPPY=0,
	SAD=1,
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
	for child in get_children():
		child.visible = false
	match current_mood:
		Face.HAPPY:
			$HappyFace.visible = true
		Face.SAD:
			$SadFace.visible = true
