extends Control


func _on_change_colors_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_color_menu.tscn")


func _on_dice_styles_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_style_menu.tscn")


func _on_fatigue_die_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_fatigue_options_menu.tscn")


func _on_back_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		Input.vibrate_handheld(50,1)
		get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
