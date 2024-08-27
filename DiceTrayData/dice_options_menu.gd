extends Control


func _on_change_colors_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_color_menu.tscn")


func _on_dice_styles_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_style_menu.tscn")


func _on_fatigue_die_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_fatigue_options_menu.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")


