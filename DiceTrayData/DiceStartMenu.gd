extends Control

func _ready():
	$VersionLabel.text = " v" + ProjectSettings.get_setting("application/config/version")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_world.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")


func _on_notes_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/notes_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
