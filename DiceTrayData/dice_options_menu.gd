extends Control


func _on_change_colors_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_color_menu.tscn")


func _on_dice_options_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
