extends Node
class_name DiceAudio

## Vibration Settings
@export_group("Menu Select")
@export var menu_click_vibe_length :int = 50   			## [ms] 500 default
@export var menu_click_vibe_strength :float = 1.0    	## -1 default
@export_group("Menu Quit")
@export var menu_quit_vibe_length :int = 100   			## [ms] 500 default
@export var menu_quit_vibe_strength :float = 1.0    	## -1 default
@export_group("Dice in Hand")
@export var dice_throw_vibe_length : int = 20			## time in milliseconds
@export var dice_throw_vibe_strength : float = 2.0 
@export_group("Dice on Dice")
@export var dice_on_dice_vibe_length :int = 10   		## [ms] 500 default
@export var dice_on_dice_vibe_strength :float = 3.0  	## -1 default
@export_group("Dice on Felt")
@export var dice_on_felt_vibe_length :int = 50   		## [ms] 500 default
@export var dice_on_felt_vibe_strength :float = 1.0    	## -1 default

@onready var dice_unmuted :bool = DicePreferences.d_unmuted
@onready var dice_vibrate :bool = DicePreferences.d_vibration_on


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SignalBusDiceTray.dice_impact_sound.connect(dice_impact_sound)
	
	
	


func dice_impact_sound(type_of_sound :String) -> void:
	match type_of_sound:
		"plastic":
			dice_on_dice_vibe()
		"felt":
			dice_on_felt_vibe()
		_:
			print(type_of_sound + " -This Dice impact sound not defined in dice audio vibe control.")


func menu_click_vibe() -> void:
	Input.vibrate_handheld(menu_click_vibe_length,menu_click_vibe_strength)
	
	
func menu_quit_vibe() -> void:
	Input.vibrate_handheld(menu_quit_vibe_length,menu_quit_vibe_strength)
	

func dice_on_dice_vibe() -> void:
	if dice_unmuted:
		
		%AudioStreamPlayerPlastic.play()
	if dice_vibrate:
		Input.vibrate_handheld(dice_on_dice_vibe_length,dice_on_dice_vibe_strength)
	
	
func dice_on_felt_vibe() -> void:
	if dice_unmuted:
		%AudioStreamPlayerDiceTray.play()
	if dice_vibrate:
		Input.vibrate_handheld(dice_on_felt_vibe_length,dice_on_felt_vibe_strength)
