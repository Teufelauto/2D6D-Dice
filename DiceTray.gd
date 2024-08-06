extends Node3D


@onready var die_dx = $RoomSizeDice/DXDim
@onready var die_dy = $RoomSizeDice/DYDim
@onready var die_num_exits = $RoomSizeDice/DieDoorPics
@onready var die_double_primary =   $DoublesDice/DPrimaryAddNum
@onready var die_double_secondary = $DoublesDice/DSecondaryAddNum
@onready var die_exit_direction = $RoomExitDirectionDie/DieLCR
@onready var die_exit_lock_check = $ExitLockCheckDie/DieLocked
@onready var die_primary = $PrimaryDie/DieNumberedPrimary
@onready var die_secondary = $SecondaryDie/DieNumberedSecondary
@onready var die_d3 = $D3Die/DieD3

@onready var button_throw_xy = $RoomSizeDice/XYThrowButton
@onready var button_throw_xy2 = $RoomSizeDice/XYThrowButton2
@onready var button_throw_doubles = $DoublesDice/DoubleThrowButton
@onready var button_throw_exit_direction = $RoomExitDirectionDie/LCRThrowButton
@onready var button_throw_lock_check = $ExitLockCheckDie/ExitLockThrowButton
@onready var button_throw_primary = $PrimaryDie/PrimeThrowButton
@onready var button_throw_secondary = $SecondaryDie/SecondaryThrowButton
@onready var button_throw_d3 = $D3Die/D3ThrowButton







# Called when the node enters the scene tree for the first time.
func _ready():
	
	# For all Rigidbody3D in DiceTray, set collision to false
	die_dx.set_collision_layer_value ( 2, false)
	die_dy.set_collision_layer_value ( 2, false)
	die_num_exits.set_collision_layer_value ( 2, false)
	die_double_primary.set_collision_layer_value ( 2, false)
	die_double_secondary.set_collision_layer_value ( 2, false)
	die_exit_direction.set_collision_layer_value ( 2, false)
	die_exit_lock_check.set_collision_layer_value ( 2, false)
	die_primary.set_collision_layer_value ( 2, false)
	die_secondary.set_collision_layer_value ( 2, false)
	die_d3.set_collision_layer_value ( 2, false)


	button_throw_xy.visible = true
	button_throw_xy2.visible = true
	button_throw_doubles.visible = true
	button_throw_exit_direction.visible = true
	button_throw_lock_check.visible = true
	button_throw_primary.visible = true
	button_throw_secondary.visible = true
	button_throw_d3.visible = true
	

