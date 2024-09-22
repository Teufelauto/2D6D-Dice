extends Control


func _on_change_colors_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_color_menu.tscn")


func _on_dice_styles_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_style_menu.tscn")


func _on_fatigue_die_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_fatigue_options_menu.tscn")


func _on_sound_and_vibe_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_sounds_and_vibe_options_menu.tscn")


func _on_instructions_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/instructions_menu.tscn")


func _on_legal_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/legal_menu.tscn")


func _on_back_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")


@warning_ignore("untyped_declaration")
func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		Input.vibrate_handheld(50,1)
		get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
