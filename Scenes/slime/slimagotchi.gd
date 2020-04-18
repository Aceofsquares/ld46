extends Node2D


onready var face_holder = $FaceHolder

export(Array, PackedScene) var faces = []

var current_face

func _ready():
	current_face = 0
	face_holder.add_child(faces[current_face].instance())
