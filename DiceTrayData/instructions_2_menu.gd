extends Control


func _on_back_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/instructions_menu.tscn")


@warning_ignore("untyped_declaration")
func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		Input.vibrate_handheld(50,1)
		get_tree().change_scene_to_file("res://DiceTrayData/instructions_menu.tscn")
