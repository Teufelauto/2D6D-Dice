class_name DiceTray
extends Node3D


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
signal clear_room_rectangle() # report to make invisible

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _remove_left_dice_scoreboard():
	%D66PrimaryPolygon2D.visible = false
	d_66_primary_label.text = ""
	%D66SecondaryPolygon2D.visible = false
	d_66_secondary_label.text = ""

func _remove_right_dice_scoreboard():
	%TwoD6PrimaryPolygon2D2.visible = false
	primary_label.text = ""
	%TwoD6SecondaryPolygon2D2.visible = false
	secondary_label.text = ""
	
# -----------------------------------ROLL STARTED-----------------------------
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
		
	doubles_primary_int = 0
	doubles_secondary_int = 0
	

func _on_die_lcr_roll_started():
	center_result_label.text = ""
	


func _on_die_locked_roll_started():
	center_result_label.text = ""
	


func _on_die_primary_numbered_roll_started():
	center_result_label.text = ""
	


func _on_die_secondary_numbered_roll_started():
	center_result_label.text = ""
	


func _on_die_d_3_roll_started():
	center_result_label.text = ""
	



# --------------------------------- ROLL FINISHED -----------------------------

func _determine_room_doubles():
	# Determine if valid or need more rolls
	if room_size_x_roll_int == room_size_y_roll_int \
			&& room_size_x_roll_int != 6 && room_size_rolled_doubles_bool == false:
		center_result_label.text = "Doubles!\nRoll Doubles Dice"
		room_size_rolled_doubles_bool = true
		
	resize_room_rectangle.emit(room_size_x_roll_int,room_size_y_roll_int)


func _room_doubles_done():
	center_result_label.text = ""
	room_size_rolled_doubles_bool = false
	room_size_x_int = room_size_x_int + room_size_x_add_int #hope that flipped xy dice don't update...
	room_size_y_int = room_size_y_int + room_size_y_add_int
	x_result_label.text = str(room_size_x_int)
	y_result_label.text = str(room_size_y_int)
	resize_room_rectangle.emit(room_size_x_int,room_size_y_int)
	

func _on_die_dx_dim_roll_finished(die_value):
	room_size_x_roll_int = die_value
	room_size_x_int = room_size_x_roll_int
	x_result_label.text = str(room_size_x_roll_int)
	if room_size_x_roll_int > 0 && room_size_y_roll_int > 0 :
		_determine_room_doubles()
	


func _on_die_dy_dim_roll_finished(die_value):
	room_size_y_roll_int = die_value
	room_size_y_int = room_size_y_roll_int
	y_result_label.text = str(room_size_y_roll_int)
	if room_size_x_roll_int > 0 && room_size_y_roll_int > 0 :
		_determine_room_doubles()
	


func _on_die_double_primary_roll_finished(die_value):
	if room_size_rolled_doubles_bool && room_size_y_add_int == 0 :
		room_size_x_add_int = die_value
	elif room_size_rolled_doubles_bool && room_size_y_add_int > 0 :
		room_size_x_add_int = die_value
		_room_doubles_done()
	else:
		doubles_primary_int = die_value
	

func _on_die_double_secondary_roll_finished(die_value):
	if room_size_rolled_doubles_bool && room_size_x_add_int == 0:
		room_size_y_add_int = die_value
	elif room_size_rolled_doubles_bool && room_size_x_add_int > 0 :
		room_size_y_add_int = die_value
		_room_doubles_done()
	else:
		doubles_secondary_int = die_value
	

func _on_die_door_pics_roll_finished(die_value):
	room_number_of_exits_int = die_value
	if room_number_of_exits_int == 1:
		exit_number_label.text = str(room_number_of_exits_int) + " Exit"
	else: 
		exit_number_label.text = str(room_number_of_exits_int) + " Exits"
	
	
func _on_die_lcr_roll_finished(die_value):
	room_exit_direction_int = die_value
	

func _on_die_locked_roll_finished(die_value):
	door_lock_status_int = die_value
	

func _on_die_primary_numbered_roll_finished(die_value):
	primary_die_int = die_value
	

func _on_die_secondary_numbered_roll_finished(die_value):
	secondary_die_int = die_value
	

func _on_die_d_3_roll_finished(die_value):
	d3_die_int = die_value
	
#-----------------------------------------------------------------------------

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_start_menu.tscn")
