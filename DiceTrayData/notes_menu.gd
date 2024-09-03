extends Control


func _on_back_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
