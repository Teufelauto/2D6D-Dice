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
	
	



