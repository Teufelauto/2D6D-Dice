class_name DiceTray
extends Node3D
###########################################################################
## This is the main script of the tray of dice.
###########################################################################


## Buttons
@onready var button_throw_xy = $DiceCanvas/ThrowButtons/XYThrowButton
@onready var button_throw_xy2 = $DiceCanvas/ThrowButtons/XYThrowButton2
@onready var button_throw_doubles = $DiceCanvas/ThrowButtons/DoubleThrowButton
@onready var button_throw_exit_direction = $DiceCanvas/ThrowButtons/LCRThrowButton
@onready var button_throw_lock_check = $DiceCanvas/ThrowButtons/ExitLockThrowButton
@onready var button_throw_primary = $DiceCanvas/ThrowButtons/PrimeThrowButton
@onready var button_throw_secondary = $DiceCanvas/ThrowButtons/SecondaryThrowButton
@onready var button_throw_d3 = $DiceCanvas/ThrowButtons/D3ThrowButton
@onready var pick_up_all_dice_button_huge = $DiceCanvas/PickUpAllDiceButtonHuge
@onready var fatigue_reset_button = $DiceCanvas/FatigueResetButton

## Labels
@onready var room_doubles_alert_label = %DiceCanvas/RoomDoublesAlertLabel
@onready var x_result_label = %DiceCanvas/XResultLabel
@onready var y_result_label = %DiceCanvas/YResultLabel
@onready var exit_number_label = $DiceCanvas/ExitNumberLabel
@onready var d_66_primary_label = $DiceCanvas/D66ScoreBoard/D66PrimaryLabel
@onready var d_66_secondary_label = $DiceCanvas/D66ScoreBoard/D66SecondaryLabel
@onready var primary_label = $DiceCanvas/TwoD6ScoreBoard/PrimaryLabel
@onready var secondary_label = $DiceCanvas/TwoD6ScoreBoard/SecondaryLabel
@onready var exit_direction_label = $DiceCanvas/ExitDirectionLabel
@onready var exit_lock_label = $DiceCanvas/ExitLockLabel
@onready var d_3_result_label = $DiceCanvas/D3ResultLabel

## Room first throw die results
static var room_size_x_roll_int : int = 0
static var room_size_y_roll_int : int = 0
static var room_size_rolled_doubles_bool : bool = false

## Room second throw (if doubles) die results
static var room_size_x_add_int : int = 0
static var room_size_y_add_int : int = 0

## room size results
static var room_size_x_int : int = 0
static var room_size_y_int : int = 0
static var room_area_rolled : int = 0

## die throw results
static var doubles_primary_int : int = 0
static var doubles_secondary_int : int = 0
static var room_number_of_exits_int : int = 0
static var room_exit_direction_int : int = 0
static var door_lock_status_int : int = 0
static var primary_die_int : int = 0
static var secondary_die_int : int = 0
static var d3_die_int : int = 0

## Dice Instance scene preloads (for d6 dice)
const DIE_DOOR_DIRECTION : PackedScene = preload("res://DiceTrayData/DiceScenes/die_door_direction.tscn")
@export var die_door_direction : DiceControl
const DIE_DOOR_LOCKS : PackedScene = preload("res://DiceTrayData/DiceScenes/die_door_locks.tscn")
@export var die_door_locks : DiceControl
const DIE_DOOR_QTY : PackedScene = preload("res://DiceTrayData/DiceScenes/die_door_qty.tscn")
@export var die_door_qty : DiceControl
const DIE_DOUBLE_PRIMARY : PackedScene = preload("res://DiceTrayData/DiceScenes/die_double_primary.tscn")
@export var die_double_primary : DiceControl
const DIE_DOUBLE_SECONDARY : PackedScene = preload("res://DiceTrayData/DiceScenes/die_double_secondary.tscn")
@export var die_double_secondary : DiceControl
const DIE_D_3 : PackedScene = preload("res://DiceTrayData/DiceScenes/die_d_3.tscn")
@export var die_d_3 : DiceControl
const DIE_SINGLE_PRIMARY : PackedScene = preload("res://DiceTrayData/DiceScenes/die_single_primary.tscn")
@export var die_single_primary : DiceControl
const DIE_SINGLE_SECONDARY : PackedScene = preload("res://DiceTrayData/DiceScenes/die_single_secondary.tscn")
@export var die_single_secondary : DiceControl
const DIE_X_DIMENSION: PackedScene = preload("res://DiceTrayData/DiceScenes/die_x_dimension.tscn")
@export var die_x_dimension: DiceControl
const DIE_Y_DIMENSION : PackedScene = preload("res://DiceTrayData/DiceScenes/die_y_dimension.tscn")
@export var die_y_dimension: DiceControl

signal resize_room_rectangle(x_size,y_size) #### report room dimensions to drawing funcion
signal clear_room_rectangle() #### report to make room rectangle invisible


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## Instantiate all 10 dice and add as child of DiceTray.
	die_door_direction = DIE_DOOR_DIRECTION.instantiate()
	add_child(die_door_direction)
	die_door_locks = DIE_DOOR_LOCKS.instantiate()
	add_child(die_door_locks)
	die_door_qty = DIE_DOOR_QTY.instantiate()
	add_child(die_door_qty)
	die_double_primary = DIE_DOUBLE_PRIMARY.instantiate()
	add_child(die_double_primary)
	die_double_secondary = DIE_DOUBLE_SECONDARY.instantiate()
	add_child(die_double_secondary)
	die_d_3 = DIE_D_3.instantiate()
	add_child(die_d_3)
	die_single_primary = DIE_SINGLE_PRIMARY.instantiate()
	add_child(die_single_primary)
	die_single_secondary = DIE_SINGLE_SECONDARY.instantiate()
	add_child(die_single_secondary)
	die_x_dimension = DIE_X_DIMENSION.instantiate()
	add_child(die_x_dimension)
	die_y_dimension = DIE_Y_DIMENSION.instantiate()
	add_child(die_y_dimension)
	
	## clear scoreboard
	_remove_left_dice_scoreboard()
	_remove_right_dice_scoreboard()
	
	## Change visuals and such based on saved or default preferences.
	_assign_die_styles()
	_assign_colors()
	_fatigue_die_visibility()
	_assign_sound_volumes()


func _assign_sound_volumes() -> void:
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dice On Dice"), linear_to_db(DicePreferences.d_volume_plastic))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dice On Felt"), linear_to_db(DicePreferences.d_volume_felt))


func _assign_die_styles() -> void:
	## Room X die
	for member in get_tree().get_nodes_in_group("mesh_die_x") :
		if member.is_in_group(DicePreferences.d_style_x) : member.visible = true
		else : member.visible = false
	## Room Y die
	for member in get_tree().get_nodes_in_group("mesh_die_y") :
		if member.is_in_group(DicePreferences.d_style_y) : member.visible = true
		else : member.visible = false
	## Room exit qty
	for member in get_tree().get_nodes_in_group("mesh_die_exit_qty") :
		if member.is_in_group(DicePreferences.d_style_exit_qty) : member.visible = true
		else : member.visible = false
	
	for member in get_tree().get_nodes_in_group("mesh_die_d66_primary") :
		if member.is_in_group(DicePreferences.d_style_d66_prime) : member.visible = true
		else : member.visible = false
	
	for member in get_tree().get_nodes_in_group("mesh_die_d66_secondary") :
		if member.is_in_group(DicePreferences.d_style_d66_secondary) : member.visible = true
		else : member.visible = false
		
	for member in get_tree().get_nodes_in_group("mesh_die_lcr") :
		if member.is_in_group(DicePreferences.d_style_exit_direction) : member.visible = true
		else : member.visible = false
		
	for member in get_tree().get_nodes_in_group("mesh_die_door_lock") :
		if member.is_in_group(DicePreferences.d_style_exit_lock) : member.visible = true
		else : member.visible = false
		
	for member in get_tree().get_nodes_in_group("mesh_die_single_primary") :
		if member.is_in_group(DicePreferences.d_style_single_primary) : member.visible = true
		else : member.visible = false
		
	for member in get_tree().get_nodes_in_group("mesh_die_single_secondary") :
		if member.is_in_group(DicePreferences.d_style_single_secondary) : member.visible = true
		else : member.visible = false
		
	for member in get_tree().get_nodes_in_group("mesh_die_d3") :
		if member.is_in_group(DicePreferences.d_style_d3) : member.visible = true
		else : member.visible = false
	
	
func _assign_colors() -> void:
	## D66 Scoreboard
	%D66PrimaryLabel.label_settings.font_color = DicePreferences.d_text_color_d66_prime
	%D66PrimaryPolygon2D.self_modulate = DicePreferences.d_body_color_d66_prime
	%D66SecondaryLabel.label_settings.font_color = DicePreferences.d_text_color_d66_secondary
	%D66SecondaryPolygon2D.self_modulate = DicePreferences.d_body_color_d66_secondary
	## D6 Scoreboard
	%PrimaryLabel.label_settings.font_color = DicePreferences.d_text_color_single_primary
	%TwoD6PrimaryPolygon2D.self_modulate = DicePreferences.d_body_color_single_primary
	%SecondaryLabel.label_settings.font_color = DicePreferences.d_text_color_single_secondary
	%TwoD6SecondaryPolygon2D.self_modulate = DicePreferences.d_body_color_single_secondary
	
	
	var DieMeshMat :StandardMaterial3D
	## Door X Die
	for member in get_tree().get_nodes_in_group("mesh_die_x"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_x
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_x
		
	## Door Y Die
	for member in get_tree().get_nodes_in_group("mesh_die_y"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_y
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_y
		
	## Door Exit Qty
	for member in get_tree().get_nodes_in_group("mesh_die_exit_qty"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_numbers
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_numbers
	
	## D66 Primary
	for member in get_tree().get_nodes_in_group("mesh_die_d66_primary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d66_prime
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d66_prime
	
	## D66 Secondary
	for member in get_tree().get_nodes_in_group("mesh_die_d66_secondary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d66_secondary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d66_secondary
	
	## die LCR
	for member in get_tree().get_nodes_in_group("mesh_die_lcr"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_direction
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_direction
	
	## Lock check
	for member in get_tree().get_nodes_in_group("mesh_die_door_lock"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_lock
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_lock
	
	## single Primary
	for member in get_tree().get_nodes_in_group("mesh_die_single_primary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_single_primary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_single_primary
		
	## single secondary
	for member in get_tree().get_nodes_in_group("mesh_die_single_secondary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_single_secondary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_single_secondary
		
	## d3 die
	for member in get_tree().get_nodes_in_group("mesh_die_d3"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d3
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d3
	
	## Dice Tray Felt Color assignment
	for member in get_tree().get_nodes_in_group("mesh_die_tray_felt"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_tray_felt_color


func _rehome_dice() -> void:
	
	button_throw_xy.visible = true
	button_throw_xy2.visible = true
	button_throw_doubles.visible = true
	button_throw_exit_direction.visible = true
	button_throw_lock_check.visible = true
	button_throw_primary.visible = true
	button_throw_secondary.visible = true
	button_throw_d3.visible = true
	pick_up_all_dice_button_huge.visible = false
	room_size_rolled_doubles_bool = false
	%RoomSizeSmallLabel.visible = false
	%RoomSizeLargeLabel.visible = false
	
	if DicePreferences.d_vis_fatigue == true: ## if fatigue die visible
		fatigue_reset_button.visible = true
	else:
		fatigue_reset_button.visible = false
	

func _remove_left_dice_scoreboard() -> void:
	%D66PrimaryPolygon2D.visible = false
	d_66_primary_label.text = ""
	%D66SecondaryPolygon2D.visible = false
	d_66_secondary_label.text = ""


func _remove_right_dice_scoreboard() -> void:
	_remove_right_primary_die_scoreboard()
	_remove_right_secondary_die_scoreboard()


func _remove_right_primary_die_scoreboard() -> void:
	%TwoD6PrimaryPolygon2D.visible = false
	primary_label.text = ""


func _remove_right_secondary_die_scoreboard() -> void:
	%TwoD6SecondaryPolygon2D.visible = false
	secondary_label.text = ""


func _remove_small_or_large_room_labels() -> void:
	%RoomSizeSmallLabel.visible = false
	%RoomSizeLargeLabel.visible = false
	

func _fatigue_die_visibility() -> void:
	
	## make VISIBLE or invisible
	if DicePreferences.d_vis_fatigue == true:
		## to put in scene:
		%StaticBody3DFatigue.set_collision_layer_value( 3, true)
		%DieFatigue.visible = true
		%FatigueIncrementButton.visible = true
	else:
		## to remove:
		%StaticBody3DFatigue.set_collision_layer_value( 3, false)
		%DieFatigue.visible = false
		%FatigueIncrementButton.visible = false
	
	## Fatigue die STYLE
	for member in get_tree().get_nodes_in_group("mesh_die_fatigue") :
		if member.is_in_group(DicePreferences.d_style_fatigue) : member.visible = true
		else : member.visible = false
	
	## Fatigue die COLOR
	var DieMeshMat :StandardMaterial3D
	for member in get_tree().get_nodes_in_group("mesh_die_fatigue"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_fatigue
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_fatigue


##region -------------------------ROLL STARTED-----------------------------

func _on_x_y_throw_button_pressed() -> void:
	
	## Remove buttons for launching dice
	#button_throw_xy.visible = false ## Main
	#button_throw_xy2.visible = false ##  exit die location
		
	##  Remove ScoreBoards because it's beginning of new section
	_remove_left_dice_scoreboard()
	_remove_right_dice_scoreboard()
	
	## Reset labels related to room size
	room_doubles_alert_label.text = ""
	x_result_label.text = ""
	y_result_label.text = ""
	
	## Reset variables related to room size
	exit_number_label.text = ""
	room_size_x_roll_int = 0
	room_size_y_roll_int = 0
	room_size_x_add_int = 0
	room_size_y_add_int = 0
	room_size_x_int = 0
	room_size_y_int = 0
	room_size_rolled_doubles_bool = false
	doubles_primary_int = 0
	doubles_secondary_int = 0
	
	## Remove rectangle Drawing and size labels
	clear_room_rectangle.emit()
	_remove_small_or_large_room_labels()
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	remove_child(die_x_dimension)
	die_x_dimension.queue_free()
	die_x_dimension = DIE_X_DIMENSION.instantiate()
	add_child(die_x_dimension)
	
	remove_child(die_y_dimension)
	die_y_dimension.queue_free()
	die_y_dimension = DIE_Y_DIMENSION.instantiate()
	add_child(die_y_dimension)
	
	remove_child(die_door_qty)
	die_door_qty.queue_free()
	die_door_qty = DIE_DOOR_QTY.instantiate()
	add_child(die_door_qty)

	## Throw the dice in their own instances.
	die_x_dimension._roll()
	die_y_dimension._roll()
	die_door_qty._roll()
	
func _on_double_throw_button_pressed() -> void:

	#button_throw_doubles.visible = false ## Remove button for launching dice
	
	_remove_left_dice_scoreboard() ## clear the old results
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	room_size_x_add_int = 0
	room_size_y_add_int = 0
	doubles_primary_int = 0
	doubles_secondary_int = 0
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	remove_child(die_double_primary)
	die_double_primary.queue_free()
	die_double_primary = DIE_DOUBLE_PRIMARY.instantiate()
	add_child(die_double_primary)
	
	remove_child(die_double_secondary)
	die_double_secondary.queue_free()
	die_double_secondary = DIE_DOUBLE_SECONDARY.instantiate()
	add_child(die_double_secondary)
	
	## Throw the dice in their own instances.
	die_double_primary._roll()
	die_double_secondary._roll()


func _on_die_lcr_roll_started() -> void:
	room_doubles_alert_label.text = ""
	exit_direction_label.text = ""
	


func _on_die_locked_roll_started() -> void:
	room_doubles_alert_label.text = ""
	exit_lock_label.text = ""
	


func _on_die_primary_numbered_roll_started() -> void:
	room_doubles_alert_label.text = ""
	


func _on_die_secondary_numbered_roll_started() -> void:
	room_doubles_alert_label.text = ""
	


func _on_die_d_3_roll_started() -> void:
	room_doubles_alert_label.text = ""
	d_3_result_label.text = ""
	

##endregion


##region ---------------------- ROLL FINISHED -----------------------------
func _add_small_or_large_room_labels( _room_x :int , _room_y :int) -> void:
	
	var _room_area :int = _room_x * _room_y
	if _room_x > 1 and _room_y > 1 : 
		if _room_area <= 6 : ## 2x3 or 3x2 room 'Small Room'
			%RoomSizeSmallLabel.visible = true
			
		elif _room_area >= 32 : ## 4x8 5x7 6x6, or larger
			%RoomSizeLargeLabel.visible = true
			

func _determine_room_doubles() -> void:
	
	## Determine if valid or need more rolls
	if room_size_x_roll_int == room_size_y_roll_int \
			and room_size_x_roll_int != 6 and room_size_rolled_doubles_bool == false:
		room_doubles_alert_label.text = "Doubles!\nRoll Doubles Dice"
		room_size_rolled_doubles_bool = true
	else: ##room is not doubles
		resize_room_rectangle.emit(room_size_x_roll_int,room_size_y_roll_int) 
		_add_small_or_large_room_labels(room_size_x_int,room_size_y_int)
	
	
	
	
func _room_doubles_done() -> void:
	if room_size_x_add_int > 0 and room_size_y_add_int > 0 :
		room_doubles_alert_label.text = ""
		
		%D66PrimaryPolygon2D.visible = true
		d_66_primary_label.text = str(room_size_x_add_int)
		%D66SecondaryPolygon2D.visible = true
		d_66_secondary_label.text = str(room_size_y_add_int)
		
		room_size_x_int = room_size_x_int + room_size_x_add_int
		room_size_y_int = room_size_y_int + room_size_y_add_int
		
		x_result_label.text = str(room_size_x_int)
		y_result_label.text = str(room_size_y_int)
		
		## Rectangle drawing
		resize_room_rectangle.emit(room_size_x_int,room_size_y_int)
		_add_small_or_large_room_labels(room_size_x_int,room_size_y_int)
		room_size_rolled_doubles_bool = false
		pick_up_all_dice_button_huge.visible = true ## All dice must be picked up!
		

func _on_die_dx_dim_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	if not room_size_rolled_doubles_bool : ## prevent flipped die from changing room size
		room_size_x_roll_int = die_value
		room_size_x_int = room_size_x_roll_int
		x_result_label.text = str(room_size_x_int)
		if room_size_x_roll_int > 0 and room_size_y_roll_int > 0 :
			_determine_room_doubles()


func _on_die_dy_dim_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	if not room_size_rolled_doubles_bool : ## prevent flipped die from changing room size
		room_size_y_roll_int = die_value
		room_size_y_int = room_size_y_roll_int
		y_result_label.text = str(room_size_y_int)
		if room_size_x_roll_int > 0 and room_size_y_roll_int > 0 :
			_determine_room_doubles()


func _on_die_double_primary_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	
	##room size rolling not done
	if room_size_rolled_doubles_bool and room_size_y_add_int == 0 :
		room_size_x_add_int = die_value
		
	##room size rolling IS done
	elif room_size_rolled_doubles_bool and room_size_y_add_int > 0 :
		room_size_x_add_int = die_value
		_room_doubles_done()
		
	##roll 2 dice for d66 or 2d6
	else:
		doubles_primary_int = die_value
		%D66PrimaryPolygon2D.visible = true
		d_66_primary_label.text = str(doubles_primary_int)


func _on_die_double_secondary_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	
	##room size rolling not done
	if room_size_rolled_doubles_bool and room_size_x_add_int == 0:
		room_size_y_add_int = die_value
		
	##room size rolling IS done
	elif room_size_rolled_doubles_bool and room_size_x_add_int > 0 :
		room_size_y_add_int = die_value
		_room_doubles_done()
		
	##roll 2 dice for d66 or 2d6
	else:
		doubles_secondary_int = die_value
		%D66SecondaryPolygon2D.visible = true
		d_66_secondary_label.text = str(doubles_secondary_int)


func _on_die_door_pics_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	room_number_of_exits_int = die_value
	if room_number_of_exits_int == 1:
		exit_number_label.text = str(room_number_of_exits_int) + " Exit"
	else: 
		exit_number_label.text = str(room_number_of_exits_int) + " Exits"
	
	
func _on_die_lcr_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	room_exit_direction_int = die_value
	if room_exit_direction_int == 1 : exit_direction_label.text = "Left"
	elif room_exit_direction_int == 2 : exit_direction_label.text = "Center"
	else : exit_direction_label.text = "Right"
	


func _on_die_locked_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	door_lock_status_int = die_value
	if door_lock_status_int == 1 : exit_lock_label.text = "Metal Locked"
	elif door_lock_status_int == 2 : exit_lock_label.text = "Metal / Reinforced Locked"
	elif door_lock_status_int == 3 : exit_lock_label.text = "Locked"
	else : exit_lock_label.text = "Not Locked"
	
	

func _on_die_primary_numbered_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	primary_die_int = die_value
	%TwoD6PrimaryPolygon2D.visible = true
	primary_label.text = str(primary_die_int)


func _on_die_secondary_numbered_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	secondary_die_int = die_value
	%TwoD6SecondaryPolygon2D.visible = true
	secondary_label.text = str(secondary_die_int)


func _on_die_d_3_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	d3_die_int = die_value
	d_3_result_label.text = str(d3_die_int)

##endregion

##-----------------------------------------------------------------------------

func _on_exit_button_pressed() -> void:
	print("exit!!!")
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")

func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
