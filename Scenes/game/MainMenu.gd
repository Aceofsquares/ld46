extends Control



func _on_StartBtn_pressed():
	get_tree().change_scene("res://Scenes/game/Main.tscn")


func _on_InstructionsBtn_pressed():
	$Instructions.visible = true


func _on_Quit_pressed():
	get_tree().quit()
