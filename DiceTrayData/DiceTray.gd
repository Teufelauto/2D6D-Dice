class_name DiceTray
extends Node3D
###########################################################################
## This is the main script of the tray of dice.
###########################################################################

## Buttons
@onready var button_throw_xy : Button= $DiceCanvas/ThrowButtons/XYThrowButton
@onready var button_throw_xy2 : Button= $DiceCanvas/ThrowButtons/XYThrowButton2
@onready var button_throw_doubles: Button = $DiceCanvas/ThrowButtons/DoubleThrowButton
@onready var button_throw_exit_direction: Button = $DiceCanvas/ThrowButtons/LCRThrowButton
@onready var button_throw_lock_check: Button = $DiceCanvas/ThrowButtons/ExitLockThrowButton
@onready var button_throw_primary : Button= $DiceCanvas/ThrowButtons/PrimeThrowButton
@onready var button_throw_secondary : Button= $DiceCanvas/ThrowButtons/SecondaryThrowButton
@onready var button_throw_d3 : Button= $DiceCanvas/ThrowButtons/D3ThrowButton
@onready var pick_up_all_dice_button_huge: Button = $DiceCanvas/PickUpAllDiceButtonHuge
@onready var fatigue_reset_button: Button = $DiceCanvas/FatigueResetButton
@onready var fatigue_increment_button: Button = $DiceCanvas/FatigueIncrementButton
@onready var combat_select_button: Button = $DiceCanvas/CombatSelectButton

## Labels
@onready var room_doubles_alert_label : Label= %DiceCanvas/RoomDoublesAlertLabel
@onready var x_result_label : Label= %DiceCanvas/XResultLabel
@onready var y_result_label: Label = %DiceCanvas/YResultLabel
@onready var exit_number_label: Label = $DiceCanvas/ExitNumberLabel
@onready var d_66_primary_label: Label = $DiceCanvas/D66ScoreBoard/D66PrimaryLabel
@onready var d_66_secondary_label: Label = $DiceCanvas/D66ScoreBoard/D66SecondaryLabel
@onready var primary_label: Label = $DiceCanvas/TwoD6ScoreBoard/PrimaryLabel
@onready var secondary_label: Label = $DiceCanvas/TwoD6ScoreBoard/SecondaryLabel
@onready var exit_direction_label: Label = $DiceCanvas/ExitDirectionLabel
@onready var exit_lock_label: Label = $DiceCanvas/ExitLockLabel
@onready var d_3_result_label : Label= $DiceCanvas/D3ResultLabel
@onready var d_66_sum_label: Label = $DiceCanvas/D66SumLabel
@onready var singles_sum_label: Label = $DiceCanvas/SinglesSumLabel

## Room first throw die results
static var room_size_x_roll_int : int = 0
static var room_size_y_roll_int : int = 0
static var room_size_rolled_doubles_bool : bool = false

## Room second throw (if doubles) die results
static var room_size_x_add_int : int = 0
static var room_size_y_add_int : int = 0
static var die_doubles_primary_done : bool = false
static var die_doubles_secondary_done : bool = false

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

static var doubles_die_sum :int = 0
static var singles_die_sum :int = 0

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

signal resize_room_rectangle(x_size:int,y_size:int) #### report room dimensions to drawing funcion
signal clear_room_rectangle() #### report to make room rectangle invisible


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## Signal Bus connections (receptions)
	SignalBusDiceTray.dice_to_reroll.connect(_roll_from_table)
	SignalBusDiceTray.roll_finished.connect(_sort_roll_finished_result)
	
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


## Currently has color, style, vis... 
func _fatigue_die_visibility() -> void:
	
	## make VISIBLE or invisible
	if DicePreferences.d_vis_fatigue == true:
		## to put in scene:
		$FatigueDie/DieFatigue.visible = true  ## The roller die
		#fatigue_increment_button.visible = true
		$FatigueDie/DieFatigue._ready()
		
	else:
		## to remove:
		$FatigueDie/StaticBody3DFatigue.set_collision_layer_value( 3, false) # the big collision box
		$FatigueDie/DieFatigue.visible = false ## The roller die
		fatigue_increment_button.visible = false
		
	
	## Fatigue die STYLE
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_fatigue") :
		if member.is_in_group(DicePreferences.d_style_fatigue) : member.visible = true
		else : member.visible = false
	
	## Fatigue die COLOR
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_fatigue"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_fatigue
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_fatigue


func _assign_sound_volumes() -> void:
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dice On Dice"), linear_to_db(DicePreferences.d_volume_plastic))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dice On Felt"), linear_to_db(DicePreferences.d_volume_felt))


#region ########## Styles Assignment ##########################################
## The First function does them all, for when tray scene first comes in.
## Individul functions will be used when picking up dice and reinstancing them.
###############################################################################

func _assign_die_styles() -> void:
	_assign_die_styles_x()
	_assign_die_styles_y()
	_assign_die_styles_exit_qty()
	_assign_die_styles_dub_prime()
	_assign_die_styles_dub_secondary()
	_assign_die_styles_lcr()
	_assign_die_styles_lock()
	_assign_die_styles_single_prime()
	_assign_die_styles_single_secondary()
	_assign_die_styles_d3()


func _assign_die_styles_x() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_x") :
		if member.is_in_group(DicePreferences.d_style_x) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_y() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_y") :
		if member.is_in_group(DicePreferences.d_style_y) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_exit_qty() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_exit_qty") :
		if member.is_in_group(DicePreferences.d_style_exit_qty) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_dub_prime() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d66_primary") :
		if member.is_in_group(DicePreferences.d_style_d66_prime) :
			member.visible = true
		else : member.visible = false


func _assign_die_styles_dub_secondary() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d66_secondary") :
		if member.is_in_group(DicePreferences.d_style_d66_secondary) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_lcr() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_lcr") :
		if member.is_in_group(DicePreferences.d_style_exit_direction) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_lock() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_door_lock") :
		if member.is_in_group(DicePreferences.d_style_exit_lock) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_single_prime() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_single_primary") :
		if member.is_in_group(DicePreferences.d_style_single_primary) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_single_secondary() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_single_secondary") :
		if member.is_in_group(DicePreferences.d_style_single_secondary) : 
			member.visible = true
		else : member.visible = false


func _assign_die_styles_d3() -> void:
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d3") :
		if member.is_in_group(DicePreferences.d_style_d3) : 
			member.visible = true
		else : member.visible = false
#endregion

#region .........  Color Assignment  ..............................

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
	
	_assign_colors_x()
	_assign_colors_y()
	_assign_colors_door_qty()
	_assign_colors_dub_primary()
	_assign_colors_dub_secondary()
	_assign_colors_lcr()
	_assign_colors_lock()
	_assign_colors_single_primary() 
	_assign_colors_single_secondary()
	_assign_colors_d3()
	_assign_colors_felt()
	
	
## Door X Die
func _assign_colors_x() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_x"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_x
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_x
		
		
## Door Y Die
func _assign_colors_y() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_y"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_y
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_y
		
## Door Exit Qty
func _assign_colors_door_qty() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_exit_qty"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_numbers
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_numbers
	
## D66 Primary
func _assign_colors_dub_primary() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d66_primary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d66_prime
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d66_prime
	
## D66 Secondary
func _assign_colors_dub_secondary() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d66_secondary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d66_secondary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d66_secondary
	
## die LCR
func _assign_colors_lcr() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_lcr"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_direction
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_direction
	
	
## Lock check
func _assign_colors_lock() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_door_lock"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_exit_lock
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_exit_lock
	
	
## single Primary
func _assign_colors_single_primary() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_single_primary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_single_primary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_single_primary
		
		
## single secondary
func _assign_colors_single_secondary() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_single_secondary"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_single_secondary
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_single_secondary
		
		
## d3 die
func _assign_colors_d3() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_d3"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_text_color_d3
		DieMeshMat = member.get_surface_override_material(1)
		DieMeshMat.albedo_color = DicePreferences.d_body_color_d3
	
	
## Dice Tray Felt Color assignment
func _assign_colors_felt() -> void:
	var DieMeshMat :StandardMaterial3D
	for member:MeshInstance3D in get_tree().get_nodes_in_group("mesh_die_tray_felt"):
		DieMeshMat = member.get_surface_override_material(0)
		DieMeshMat.albedo_color = DicePreferences.d_tray_felt_color


#endregion

#region ---------   rehome / Reset the dice ------------------------------------

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
	
	if DicePreferences.d_vis_fatigue == true: ## if fatigue die visible, show buttons
		#fatigue_reset_button.visible = true ## Buttun unneeded when resetting with 'CombatSelect'
		combat_select_button.visible = true
		
	else:
		fatigue_reset_button.visible = false
		combat_select_button.visible = false
	
	_reset_all_dice()


## Remove, add, and apply preferences to dice going back to home position.
func _reset_all_dice() -> void:
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_x_dimension()
	_reset_die_y_dimension()
	_reset_die_door_qty()
	_reset_die_double_primary()
	_reset_die_double_secondary()
	_reset_die_door_direction()
	_reset_die_door_locks()
	_reset_die_single_primary()
	_reset_die_single_secondary()
	_reset_die_d_3()


## X, Y, and Door Qty Shared Labels reset
func _reset_die_x_y_qty_labels() -> void:
	
	##  Remove ScoreBoards because it's beginning of new section
	#_remove_left_dice_scoreboard()
	#_remove_right_dice_scoreboard()
	
	## Reset labels related to room size
	room_doubles_alert_label.text = ""
	x_result_label.text = ""
	y_result_label.text = ""
	exit_number_label.text = ""
	
	## Remove rectangle Drawing and size labels
	clear_room_rectangle.emit()
	_remove_small_or_large_room_labels()


func _reset_die_x_dimension() -> void:
	## Don't reset if die is already picked up.
	if die_x_dimension.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_x_dimension.rotation_of_die_at_rest
	
	remove_child(die_x_dimension)
	die_x_dimension.queue_free()
	die_x_dimension = DIE_X_DIMENSION.instantiate()
	add_child(die_x_dimension)
	_assign_die_styles_x()
	_assign_colors_x()
	
	#print("the rotation is " + str(_die_rotation))
	die_x_dimension.rotation_degrees = _die_rotation
	
	_reset_die_x_y_qty_labels() ## Only needs to be called in one of the three dice resets.


func _reset_die_y_dimension() -> void:
	## Don't reset if die is already picked up.
	if die_y_dimension.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_y_dimension.rotation_of_die_at_rest
	
	remove_child(die_y_dimension)
	die_y_dimension.queue_free()
	die_y_dimension = DIE_Y_DIMENSION.instantiate()
	add_child(die_y_dimension)
	_assign_die_styles_y()
	_assign_colors_y()
	
	#print("the rotation is " + str(_die_rotation))
	die_y_dimension.rotation_degrees = _die_rotation
	
	
func _reset_die_door_qty() -> void:
	## Don't reset if die is already picked up.
	if die_door_qty.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_door_qty.rotation_of_die_at_rest
	
	remove_child(die_door_qty)
	die_door_qty.queue_free()
	die_door_qty = DIE_DOOR_QTY.instantiate()
	add_child(die_door_qty)
	_assign_die_styles_exit_qty()
	_assign_colors_door_qty()
	
	#print("the rotation is " + str(_die_rotation))
	die_door_qty.rotation_degrees = _die_rotation
	
	
## Double dice shared labels reset
func _reset_die_doubles_labels() -> void:
	doubles_primary_int = 0
	doubles_secondary_int = 0
	doubles_die_sum = 0
	d_66_sum_label.text = ""
	_remove_left_dice_scoreboard() ## clear the old results
	room_doubles_alert_label.text = ""

func _reset_die_double_primary() -> void:
	## Don't reset if die is already picked up.
	if die_double_primary.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_double_primary.rotation_of_die_at_rest
	
	remove_child(die_double_primary)
	die_double_primary.queue_free()
	die_double_primary = DIE_DOUBLE_PRIMARY.instantiate()
	add_child(die_double_primary)
	_assign_die_styles_dub_prime()
	_assign_colors_dub_primary()
	
	#print("the rotation is " + str(_die_rotation))
	die_double_primary.rotation_degrees = _die_rotation
	
	_reset_die_doubles_labels()
	
	
func _reset_die_double_secondary() -> void:
	## Don't reset if die is already picked up.
	if die_double_secondary.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_double_secondary.rotation_of_die_at_rest
	
	remove_child(die_double_secondary)
	die_double_secondary.queue_free()
	die_double_secondary = DIE_DOUBLE_SECONDARY.instantiate()
	add_child(die_double_secondary)
	_assign_die_styles_dub_secondary()
	_assign_colors_dub_secondary()
	
	#print("the rotation is " + str(_die_rotation))
	die_double_secondary.rotation_degrees = _die_rotation
	
	
func _reset_die_door_direction() -> void:
	## Don't reset if die is already picked up.
	if die_door_direction.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_door_direction.rotation_of_die_at_rest
	
	remove_child(die_door_direction)
	die_door_direction.queue_free()
	die_door_direction = DIE_DOOR_DIRECTION.instantiate()
	add_child(die_door_direction)
	_assign_die_styles_lcr()
	_assign_colors_lcr()
	
	#print("the rotation is " + str(_die_rotation))
	die_door_direction.rotation_degrees = _die_rotation
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	exit_direction_label.text = ""
	
	
func _reset_die_door_locks() -> void:
	## Don't reset if die is already picked up.
	if die_door_locks.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_door_locks.rotation_of_die_at_rest
	
	remove_child(die_door_locks)
	die_door_locks.queue_free()
	die_door_locks = DIE_DOOR_LOCKS.instantiate()
	add_child(die_door_locks)
	_assign_die_styles_lock()
	_assign_colors_lock()
	
	#print("the rotation is " + str(_die_rotation))
	die_door_locks.rotation_degrees = _die_rotation
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	exit_lock_label.text = ""
	
func _reset_die_singles_shared() -> void:
	singles_die_sum = 0
	singles_sum_label.text = ""
	room_doubles_alert_label.text = ""
	
func _reset_die_single_primary() -> void:
	
	## Don't reset if die is already picked up.
	if die_single_primary.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_single_primary.rotation_of_die_at_rest
	
	remove_child(die_single_primary)
	die_single_primary.queue_free()
	die_single_primary = DIE_SINGLE_PRIMARY.instantiate()
	add_child(die_single_primary)
	_assign_die_styles_single_prime()
	_assign_colors_single_primary()
	
	#print("the rotation is " + str(_die_rotation))
	die_single_primary.rotation_degrees = _die_rotation
	
	## Reset Variables
	primary_die_int = 0
	_reset_die_singles_shared()
	_remove_right_primary_die_scoreboard()
	
	
func _reset_die_single_secondary() -> void:
	## Don't reset if die is already picked up.
	if die_single_secondary.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_single_secondary.rotation_of_die_at_rest
	
	remove_child(die_single_secondary)
	die_single_secondary.queue_free()
	die_single_secondary = DIE_SINGLE_SECONDARY.instantiate()
	add_child(die_single_secondary)
	_assign_die_styles_single_secondary()
	_assign_colors_single_secondary()
	
	#print("the rotation is " + str(_die_rotation))
	die_single_secondary.rotation_degrees = _die_rotation
	
	## Reset Variables
	secondary_die_int = 0
	_reset_die_singles_shared()
	_remove_right_secondary_die_scoreboard()
	
	
func _reset_die_d_3() -> void:
	## Don't reset if die is already picked up.
	if die_d_3.position.y > 0.7:
		return
	## Get the rotation info on die.
	var _die_rotation:Vector3 = die_d_3.rotation_of_die_at_rest
	
	remove_child(die_d_3)
	die_d_3.queue_free()
	die_d_3 = DIE_D_3.instantiate()
	add_child(die_d_3)
	_assign_die_styles_d3()
	_assign_colors_d3()
	
	#print("the rotation is " + str(_die_rotation))
	die_d_3.rotation_degrees = _die_rotation
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	d_3_result_label.text = ""
	
	
#endregion


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
	

#region ------ ROLL DICE --------------------------------------------------

## This funcion is called from clicking on a die in the tray through a signal.
## It will determine if any additional dice should be thrown with it and calls throw function.
## Match items are in optimised order for efficiency
func _roll_from_table(die_clicked: String) -> void:
	#print("roll from table function called with " + die_clicked)
	match die_clicked:
		"DieDoublePrimary", "DieDoubleSecondary":
			_on_double_throw_button_pressed()
		"DieSinglePrimary":
			_on_prime_throw_button_pressed()
		"DieSingleSecondary":
			_on_secondary_throw_button_pressed()
		"DieDoorDirection":
			_on_lcr_throw_button_pressed()
		"DieDoorLocks":
			_on_exit_lock_throw_button_pressed()
		"DieD3":
			_on_d_3_throw_button_pressed()
		
		"DieXDimension", "DieYDimension", "DieDoorQty":
			## Do not reroll if doubles were rolled. 
			## It's a small convenience tweak for repetative bug-busting-rolling.
			## And prevent accidents during play, I guess.
			if room_size_rolled_doubles_bool:
				return
			else:
				_on_x_y_throw_button_pressed()


func _on_x_y_throw_button_pressed() -> void:
	
	## Remove buttons for launching dice
	button_throw_xy.visible = false ## Main
	button_throw_xy2.visible = false ##  exit die location
	
	_reset_die_x_y_qty_labels()
	
	## Reset variables related to room size
	room_size_x_roll_int = 0
	room_size_y_roll_int = 0
	room_size_x_add_int = 0
	room_size_y_add_int = 0
	room_size_x_int = 0
	room_size_y_int = 0
	room_size_rolled_doubles_bool = false
	doubles_primary_int = 0
	doubles_secondary_int = 0
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_x_dimension()
	_reset_die_y_dimension()
	_reset_die_door_qty()

	## Throw the dice in their own instances.
	die_x_dimension.roll()
	die_y_dimension.roll()
	die_door_qty.roll()


func _on_double_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_doubles.visible = false
	
	_reset_die_doubles_labels()
	
	## Reset Variables
	room_size_x_add_int = 0
	room_size_y_add_int = 0
	doubles_primary_int = 0
	doubles_secondary_int = 0
	die_doubles_primary_done = false
	die_doubles_secondary_done = false
	doubles_die_sum = 0
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_double_primary()
	_reset_die_double_secondary()
	
	## Throw the dice in their own instances.
	die_double_primary.roll()
	die_double_secondary.roll()


func _on_lcr_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_exit_direction.visible = false 
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	exit_direction_label.text = ""
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_door_direction()
	
	## Throw the dice in their own instances.
	die_door_direction.roll()


func _on_exit_lock_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_lock_check.visible = false
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	exit_lock_label.text = ""
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_door_locks()
	
	## Throw the dice in their own instances.
	die_door_locks.roll()


func _on_prime_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_primary.visible = false
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	singles_die_sum = 0
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_single_primary()
	
	## Throw the dice in their own instances.
	die_single_primary.roll()


func _on_secondary_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_secondary.visible = false
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	singles_die_sum = 0
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_single_secondary()
	
	## Throw the dice in their own instances.
	die_single_secondary.roll()


func _on_d_3_throw_button_pressed() -> void:
	
	## Remove button for launching dice
	button_throw_d3.visible = false
	
	## Reset Variables
	room_doubles_alert_label.text = ""
	d_3_result_label.text = ""
	
	## Reset the dice (to eliminate momentum bug in Rapier 0.7.x)
	_reset_die_d_3()
	
	## Throw the dice in their own instances.
	die_d_3.roll()

#endregion


#region ---------------------- ROLL FINISHED Do math and display results-----

########################################################################
## First, we need to collect and parse the roll results from the signal
########################################################################
func _sort_roll_finished_result(die_value:int, die_name:String) -> void:
	match die_name:
		"DieDoublePrimary":
			_on_die_double_primary_roll_finished(die_value)
		"DieDoubleSecondary":
			_on_die_double_secondary_roll_finished(die_value)
		"DieSinglePrimary":
			_on_die_single_primary_roll_finished(die_value)
		"DieSingleSecondary":
			_on_die_single_secondary_roll_finished(die_value)
		"DieXDimension":
			_on_die_dx_dim_roll_finished(die_value)
		"DieYDimension":
			_on_die_dy_dim_roll_finished(die_value)
		"DieDoorQty":
			_on_die_door_exit_qty_roll_finished(die_value)
		"DieDoorDirection":
			_on_die_lcr_roll_finished(die_value)
		"DieDoorLocks":
			_on_die_locked_roll_finished(die_value)
		"DieD3":
			_on_die_d_3_roll_finished(die_value)


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
		
		room_size_x_int = room_size_x_roll_int + room_size_x_add_int
		room_size_y_int = room_size_y_roll_int + room_size_y_add_int
		
		x_result_label.text = str(room_size_x_int)
		y_result_label.text = str(room_size_y_int)
		
		room_doubles_alert_label.text = ""
		
		%D66PrimaryPolygon2D.visible = true
		d_66_primary_label.text = str(room_size_x_add_int)
		%D66SecondaryPolygon2D.visible = true
		d_66_secondary_label.text = str(room_size_y_add_int)
		
		## Rectangle drawing
		resize_room_rectangle.emit(room_size_x_int,room_size_y_int)
		_add_small_or_large_room_labels(room_size_x_int,room_size_y_int)
		room_size_rolled_doubles_bool = false
		pick_up_all_dice_button_huge.visible = true ## All dice must be picked up!
		

func _on_die_dx_dim_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false

	## Roll should be zero after thrown until this function changes it.
	## If it's not zero, that means it got nudged or something. Running it twice
	## would call determine room doubles after the doubles dice have already been thrown.
	if room_size_x_roll_int > 0: 
		#print("X Error Save!") ## Illustrates importance of this check
		return
	room_size_x_roll_int = die_value
	room_size_x_int = room_size_x_roll_int
	x_result_label.text = str(room_size_x_int)
	if room_size_x_roll_int > 0 and room_size_y_roll_int > 0 :
		_determine_room_doubles()


func _on_die_dy_dim_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	## Trial code to fix room doubles math
	if room_size_y_roll_int > 0: 
		#print("Y Error Saved! ") ## Illustrates importance of this check
		return
	room_size_y_roll_int = die_value
	room_size_y_int = room_size_y_roll_int
	y_result_label.text = str(room_size_y_int)
	if room_size_x_roll_int > 0 and room_size_y_roll_int > 0 :
		_determine_room_doubles()


func _on_die_double_primary_roll_finished(die_value :int) -> void:
	## Following ensures this function can only happen once per throw.
	if die_doubles_primary_done:
		#print("Room Doubles Dice Save!") ## Illustrates importance of this check
		return
	die_doubles_primary_done = true
	
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	## room size rolling not done
	if room_size_rolled_doubles_bool and room_size_y_add_int == 0 :
		room_size_x_add_int = die_value
		
	## room size rolling IS done
	elif room_size_rolled_doubles_bool and room_size_y_add_int > 0 :
		room_size_x_add_int = die_value
		_room_doubles_done()
		
	## roll 2 dice for d66 or 2d6
	else:
		doubles_primary_int = die_value
		%D66PrimaryPolygon2D.visible = true
		d_66_primary_label.text = str(doubles_primary_int)
		_determine_doubles_dice_summing() ## For 2D6 math


func _on_die_double_secondary_roll_finished(die_value :int) -> void:
	## Following ensures this function can only happen once per throw.
	if die_doubles_secondary_done:
		return
	die_doubles_secondary_done = true
	
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	## room size rolling not done
	if room_size_rolled_doubles_bool and room_size_x_add_int == 0:
		room_size_y_add_int = die_value
		
	## room size rolling IS done
	elif room_size_rolled_doubles_bool and room_size_x_add_int > 0 :
		room_size_y_add_int = die_value
		_room_doubles_done()
		
	## roll 2 dice for d66 or 2d6
	else:
		doubles_secondary_int = die_value
		%D66SecondaryPolygon2D.visible = true
		d_66_secondary_label.text = str(doubles_secondary_int)
		_determine_doubles_dice_summing() ## For 2D6 math


func _determine_doubles_dice_summing() -> void:
	if doubles_secondary_int == 0 or doubles_primary_int == 0:
		return
	else:
		doubles_die_sum = doubles_primary_int + doubles_secondary_int
		d_66_sum_label.text = str(doubles_die_sum)


func _on_die_door_exit_qty_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	room_number_of_exits_int = die_value
	if room_number_of_exits_int == 1:
		exit_number_label.text = str(room_number_of_exits_int) + " Exit"
	else: 
		exit_number_label.text = str(room_number_of_exits_int) + " Exits"
	
	
func _on_die_lcr_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	room_exit_direction_int = die_value
	if room_exit_direction_int == 1 : exit_direction_label.text = "Left"
	elif room_exit_direction_int == 2 : exit_direction_label.text = "Center"
	else : exit_direction_label.text = "Right"
	

func _on_die_locked_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	door_lock_status_int = die_value
	if door_lock_status_int == 1 : exit_lock_label.text = "Metal Locked"
	elif door_lock_status_int == 2 : exit_lock_label.text = "Metal / Reinforced Locked"
	elif door_lock_status_int == 3 : exit_lock_label.text = "Locked"
	else : exit_lock_label.text = "Not Locked"
	
	
func _on_die_single_primary_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	primary_die_int = die_value
	%TwoD6PrimaryPolygon2D.visible = true
	primary_label.text = str(primary_die_int)
	_determine_singles_dice_sum()


func _on_die_single_secondary_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	secondary_die_int = die_value
	%TwoD6SecondaryPolygon2D.visible = true
	secondary_label.text = str(secondary_die_int)
	_determine_singles_dice_sum()


func _determine_singles_dice_sum() -> void:
	if primary_die_int == 0 or secondary_die_int == 0:
		return
	else:
		singles_die_sum = primary_die_int + secondary_die_int
		singles_sum_label.text = str(singles_die_sum)
		



func _on_die_d_3_roll_finished(die_value :int) -> void:
	fatigue_reset_button.visible = false
	combat_select_button.visible = false
	
	d3_die_int = die_value
	d_3_result_label.text = str(d3_die_int)

#endregion

##-----------------------------------------------------------------------------

## This is for the X button that is used during development. Back-Button is used in Android.
func _on_exit_button_pressed() -> void:
	print("exit!!!")
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")


@warning_ignore("untyped_declaration")
func _notification(what) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")



var fatigue_die_in_combat_state: bool = false #prevent spamming
## Inputs for experimenting
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		if not fatigue_die_in_combat_state: #prevent spamming
			return
		print("explore button")
		fatigue_die_in_combat_state = false

	
	if Input.is_action_pressed("ui_down"):
		if fatigue_die_in_combat_state: #prevent spamming
			return
		print("Mortal Combat!")
		fatigue_die_in_combat_state = true
