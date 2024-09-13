extends Control

func _ready() -> void:
	## add version number to start menu
	$MarginContainer/VBoxContainer/VersionLabel.text = " v" \
			+ ProjectSettings.get_setting("application/config/version") \
			+ "-alpha"
	
	if ResourceLoader.exists("user://playerdicepreferences.tres") : 
		
		##Load custom saved settings, colors and styles
		DicePreferences.load_dice_colors()
		DicePreferences.load_dice_styles()
		DicePreferences.load_fatigue_die()
		DicePreferences.load_sounds()
		
		## We are saving here, after loading everything, so that any new default
		## variables will be added to the save file as default values.
		DicePreferences._save_dice_preferences()
		
	else: 
		## load standard settings, colors and styles chosen by the developer!
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


func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit() ## default behavior
