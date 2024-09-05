extends Control

func _ready() -> void:
	$VersionLabel.text = " v" + ProjectSettings.get_setting("application/config/version")
	
	if ResourceLoader.exists("user://savedice.tres") : #Load custom saved colors
		DicePreferences.load_dice_colors()
		DicePreferences.load_dice_styles()
		DicePreferences.load_fatigue_die()
		DicePreferences.load_sounds()
		
	else: # load standard colors chosen by the developer!
		DicePreferences.load_default_dice_colors()
		DicePreferences.load_default_dice_styles()
		DicePreferences.load_default_fatigue_die()
		DicePreferences.load_default_sounds()


func _on_play_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_world.tscn")


func _on_options_pressed() -> void:
	Input.vibrate_handheld(50,1)
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")


func _on_quit_pressed() -> void:
	Input.vibrate_handheld(100,1)
	
	get_tree().quit()

func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit() # default behavior
