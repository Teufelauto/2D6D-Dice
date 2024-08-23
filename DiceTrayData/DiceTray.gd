class_name DiceTray
extends Node3D

@onready var pick_up_all_dice_button_huge = $PickUpAllDiceButtonHuge

@onready var button_throw_xy = $RoomSizeDice/XYThrowButton
@onready var button_throw_xy2 = $RoomSizeDice/XYThrowButton2
@onready var button_throw_doubles = $DoublesDice/DoubleThrowButton
@onready var button_throw_exit_direction = $RoomExitDirectionDie/LCRThrowButton
@onready var button_throw_lock_check = $ExitLockCheckDie/ExitLockThrowButton
@onready var button_throw_primary = $PrimaryDie/PrimeThrowButton
@onready var button_throw_secondary = $SecondaryDie/SecondaryThrowButton
@onready var button_throw_d3 = $D3Die/D3ThrowButton

@onready var center_result_label = %DiceCanvas/CenterResultLabel
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





static var room_size_x_roll_int : int = 0
static var room_size_y_roll_int : int = 0
static var room_size_rolled_doubles_bool : bool = false

static var room_size_x_add_int : int = 0
static var room_size_y_add_int : int = 0

static var room_size_x_int : int = 0
static var room_size_y_int : int = 0

static var doubles_primary_int : int = 0
static var doubles_secondary_int : int = 0
static var room_number_of_exits_int : int = 0
static var room_exit_direction_int : int = 0
static var door_lock_status_int : int = 0
static var primary_die_int : int = 0
static var secondary_die_int : int = 0
static var d3_die_int : int = 0



signal resize_room_rectangle(x_size,y_size) # report room dimensions to drawing funcion
signal clear_room_rectangle() # report to make room rectangle invisible

# Called when the node enters the scene tree for the first time.
func _ready():
	#clear scoreboard
	_remove_left_dice_scoreboard()
	_remove_right_dice_scoreboard()
	
	# load the dice colors
	if ResourceLoader.exists("res://savedice.tres") : #Load custom colors
		DiceColor.load_dice_colors()
	else: # load standard colors chosen by the developer!
		DiceColor.load_default_dice_colors()
	#print(DiceColor.d_body_color_d3)
	_assign_colors()
	
func _assign_colors():
	# D66 Scoreboard
	%D66PrimaryLabel.label_settings.font_color = DiceColor.d_text_color_d66_prime
	%D66PrimaryPolygon2D.self_modulate = DiceColor.d_body_color_d66_prime
	%D66SecondaryLabel.label_settings.font_color = DiceColor.d_text_color_d66_secondary
	%D66SecondaryPolygon2D.self_modulate = DiceColor.d_body_color_d66_secondary
	# D6 Scoreboard
	%PrimaryLabel.label_settings.font_color = DiceColor.d_text_color_single_primary
	%TwoD6PrimaryPolygon2D.self_modulate = DiceColor.d_body_color_single_primary
	%SecondaryLabel.label_settings.font_color = DiceColor.d_text_color_single_secondary
	%TwoD6SecondaryPolygon2D.self_modulate = DiceColor.d_body_color_single_secondary
	
	var DieMesh :StandardMaterial3D
	# Door X Die
	for member in get_tree().get_nodes_in_group("mesh_die_x"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_x
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_x
		
	# Door Y Die
	for member in get_tree().get_nodes_in_group("mesh_die_y"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_y
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_y
		
	# Door Exit Qty
	for member in get_tree().get_nodes_in_group("mesh_die_exit_qty"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_exit_numbers
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_exit_numbers
	
	# D66 Primary
	for member in get_tree().get_nodes_in_group("mesh_die_d66_primary"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_d66_prime
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_d66_prime
	
	# D66 Secondary
	for member in get_tree().get_nodes_in_group("mesh_die_d66_secondary"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_d66_secondary
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_d66_secondary
	
	# die LCR
	for member in get_tree().get_nodes_in_group("mesh_die_lcr"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_exit_direction
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_exit_direction
	
	# Lock check
	for member in get_tree().get_nodes_in_group("mesh_die_door_lock"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_exit_lock
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_exit_lock
	
	# single Primary
	for member in get_tree().get_nodes_in_group("mesh_die_single_primary"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_single_primary
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_single_primary
		
	# single secondary
	for member in get_tree().get_nodes_in_group("mesh_die_single_secondary"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_single_secondary
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_single_secondary
		
	# d3 die
	for member in get_tree().get_nodes_in_group("mesh_die_d3"):
		DieMesh = member.get_surface_override_material(0)
		DieMesh.albedo_color = DiceColor.d_text_color_d3
		DieMesh = member.get_surface_override_material(1)
		DieMesh.albedo_color = DiceColor.d_body_color_d3


func _rehome_dice():
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

func _remove_left_dice_scoreboard():
	%D66PrimaryPolygon2D.visible = false
	d_66_primary_label.text = ""
	%D66SecondaryPolygon2D.visible = false
	d_66_secondary_label.text = ""


func _remove_right_dice_scoreboard():
	_remove_right_primary_die_scoreboard()
	_remove_right_secondary_die_scoreboard()


func _remove_right_primary_die_scoreboard():
	%TwoD6PrimaryPolygon2D.visible = false
	primary_label.text = ""


func _remove_right_secondary_die_scoreboard():
	%TwoD6SecondaryPolygon2D.visible = false
	secondary_label.text = ""
	
	
#region -------------------------ROLL STARTED-----------------------------

func _on_room_dimension_roll_started():
	center_result_label.text = ""
	x_result_label.text = ""
	y_result_label.text = ""
	
	#  Remove ScoreBoard 
	_remove_left_dice_scoreboard()
	_remove_right_dice_scoreboard()
	
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
	clear_room_rectangle.emit()


func _on_die_double_roll_started():
	
	_remove_left_dice_scoreboard() # clear the old results
	if room_size_rolled_doubles_bool:
		center_result_label.text = ""
		room_size_x_add_int = 0
		room_size_y_add_int = 0
	else:
		doubles_primary_int = 0
		doubles_secondary_int = 0
	

func _on_die_lcr_roll_started():
	center_result_label.text = ""
	exit_direction_label.text = ""


func _on_die_locked_roll_started():
	center_result_label.text = ""
	exit_lock_label.text = ""


func _on_die_primary_numbered_roll_started():
	center_result_label.text = ""


func _on_die_secondary_numbered_roll_started():
	center_result_label.text = ""


func _on_die_d_3_roll_started():
	center_result_label.text = ""
	d_3_result_label.text = ""

#endregion


#region ---------------------- ROLL FINISHED -----------------------------


func _determine_room_doubles():
	# Determine if valid or need more rolls
	if room_size_x_roll_int == room_size_y_roll_int \
			&& room_size_x_roll_int != 6 && room_size_rolled_doubles_bool == false:
		center_result_label.text = "Doubles!\nRoll Doubles Dice"
		room_size_rolled_doubles_bool = true
		
	resize_room_rectangle.emit(room_size_x_roll_int,room_size_y_roll_int)


func _room_doubles_done():
	if room_size_x_add_int > 0 and room_size_y_add_int > 0 :
		center_result_label.text = ""
		room_size_rolled_doubles_bool = false
		room_size_x_int = room_size_x_int + room_size_x_add_int
		room_size_y_int = room_size_y_int + room_size_y_add_int
		x_result_label.text = str(room_size_x_int)
		y_result_label.text = str(room_size_y_int)
		resize_room_rectangle.emit(room_size_x_int,room_size_y_int)
		pick_up_all_dice_button_huge.visible = true # All dice must be picked up!
		

func _on_die_dx_dim_roll_finished(die_value):
	if !room_size_rolled_doubles_bool : # prevent flipped die from changing room size
		room_size_x_roll_int = die_value
		room_size_x_int = room_size_x_roll_int
		x_result_label.text = str(room_size_x_int)
		if room_size_x_roll_int > 0 && room_size_y_roll_int > 0 :
			_determine_room_doubles()


func _on_die_dy_dim_roll_finished(die_value):
	if !room_size_rolled_doubles_bool : # prevent flipped die from changing room size
		room_size_y_roll_int = die_value
		room_size_y_int = room_size_y_roll_int
		y_result_label.text = str(room_size_y_int)
		if room_size_x_roll_int > 0 && room_size_y_roll_int > 0 :
			_determine_room_doubles()


func _on_die_double_primary_roll_finished(die_value):
	#room size rolling not done
	if room_size_rolled_doubles_bool && room_size_y_add_int == 0 :
		room_size_x_add_int = die_value
	#room size rolling IS done
	elif room_size_rolled_doubles_bool && room_size_y_add_int > 0 :
		room_size_x_add_int = die_value
		_room_doubles_done()
	#roll 2 dice for d66 or 2d6
	else:
		doubles_primary_int = die_value
		%D66PrimaryPolygon2D.visible = true
		d_66_primary_label.text = str(doubles_primary_int)


func _on_die_double_secondary_roll_finished(die_value):
	#room size rolling not done
	if room_size_rolled_doubles_bool && room_size_x_add_int == 0:
		room_size_y_add_int = die_value
	#room size rolling IS done
	elif room_size_rolled_doubles_bool && room_size_x_add_int > 0 :
		room_size_y_add_int = die_value
		_room_doubles_done()
	#roll 2 dice for d66 or 2d6
	else:
		doubles_secondary_int = die_value
		%D66SecondaryPolygon2D.visible = true
		d_66_secondary_label.text = str(doubles_secondary_int)


func _on_die_door_pics_roll_finished(die_value):
	room_number_of_exits_int = die_value
	if room_number_of_exits_int == 1:
		exit_number_label.text = str(room_number_of_exits_int) + " Exit"
	else: 
		exit_number_label.text = str(room_number_of_exits_int) + " Exits"
	
	
func _on_die_lcr_roll_finished(die_value):
	room_exit_direction_int = die_value
	if room_exit_direction_int == 1 : exit_direction_label.text = "L"
	elif room_exit_direction_int == 2 : exit_direction_label.text = "C"
	else : exit_direction_label.text = "R"
	#exit_direction_label.text = str(room_exit_direction_int)


func _on_die_locked_roll_finished(die_value):
	door_lock_status_int = die_value
	if door_lock_status_int == 1 : exit_lock_label.text = "Metal Locked"
	elif door_lock_status_int == 2 : exit_lock_label.text = "Metal / Reinforced Locked"
	elif door_lock_status_int == 3 : exit_lock_label.text = "Locked"
	else : exit_lock_label.text = "Not Locked"
	#exit_lock_label.text = str(door_lock_status_int)
	

func _on_die_primary_numbered_roll_finished(die_value):
	primary_die_int = die_value
	%TwoD6PrimaryPolygon2D.visible = true
	primary_label.text = str(primary_die_int)


func _on_die_secondary_numbered_roll_finished(die_value):
	secondary_die_int = die_value
	%TwoD6SecondaryPolygon2D.visible = true
	secondary_label.text = str(secondary_die_int)


func _on_die_d_3_roll_finished(die_value):
	d3_die_int = die_value
	d_3_result_label.text = str(d3_die_int)

#endregion

#-----------------------------------------------------------------------------

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
