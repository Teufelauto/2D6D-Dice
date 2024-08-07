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

@onready var x_result_label = %DiceCanvas/XResultLabel
@onready var y_result_label = %DiceCanvas/YResultLabel
@onready var x_result_add_label = %DiceCanvas/XResultAddLabel
@onready var y_result_add_label = %DiceCanvas/YResultAddLabel

static var room_size_x_roll_int : int = 0
static var room_size_y_roll_int : int = 0
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


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# For all Rigidbody3D in DiceTray, set collision to false so you can roll 
	# through docked dice
	for RigidBody3d in get_tree().get_nodes_in_group("Dice") :
		RigidBody3d.set_collision_layer_value ( 2, false)
		RigidBody3d.set_collision_mask_value ( 2, false)
	
	
# Ensure throw buttons can be clicked
	button_throw_xy.visible = true
	button_throw_xy2.visible = true
	button_throw_doubles.visible = true
	button_throw_exit_direction.visible = true
	button_throw_lock_check.visible = true
	button_throw_primary.visible = true
	button_throw_secondary.visible = true
	button_throw_d3.visible = true
	

func _on_room_dimension_roll_started():
	x_result_label.text = ""
	y_result_label.text = ""
	x_result_add_label.text = ""
	y_result_add_label.text = ""
	room_size_x_roll_int = 0
	room_size_y_roll_int = 0
	room_size_x_add_int = 0
	room_size_y_add_int = 0
	room_size_x_int = 0
	room_size_y_int = 0

