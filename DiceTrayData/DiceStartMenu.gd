extends Control

func _ready():
	$VersionLabel.text = " v" + ProjectSettings.get_setting("application/config/version")


func _on_play_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_world.tscn")


func _on_options_pressed():
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")


func _on_quit_pressed():
	Input.vibrate_handheld(100,1)
	
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit() # default behavior
