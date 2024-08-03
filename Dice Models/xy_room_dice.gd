extends Node3D
class_name RoomSize



@onready var result_label = $/root/world/CanvasLayer/CenterLabel
@onready var x_result_label = $/root/world/CanvasLayer/XResultLabel
@onready var y_result_label = $/root/world/CanvasLayer/YResultLabel
@onready var x_result_add_label = $/root/world/CanvasLayer/XResultAddLabel
@onready var y_result_add_label = $/root/world/CanvasLayer/YResultAddLabel

static var room_size_x_roll : int = 0
static var room_size_y_roll : int = 0
static var room_size_x_add : int = 0
static var room_size_y_add : int = 0
static var room_size_x : int = 0
static var room_size_y : int = 0



signal roll_xy_dice(string)








func _on_dx_dim_roll_started():
	x_result_label.text = ""
	y_result_label.text = ""
	x_result_add_label.text = ""
	y_result_add_label.text = ""
	room_size_x_roll = 0
	room_size_y_roll = 0
	room_size_x_add = 0
	room_size_y_add = 0
	room_size_x = 0
	room_size_y = 0

func _on_dx_dim_roll_finished(value):
	x_result_label.text = "X = " + str(value)
	room_size_x_roll = value
	if room_size_x_roll > 0 && room_size_y_roll > 0 :
		_determine_doubles()
	
func _on_dy_dim_roll_finished(value):
	y_result_label.text = "Y = " + str(value)
	room_size_y_roll = value
	if room_size_x_roll > 0 && room_size_y_roll > 0 :
		_determine_doubles()
	

func _determine_doubles():
	# Determine if valid or need more rolls
	if room_size_x_roll == room_size_y_roll && room_size_x_roll != 6 :
		print("Doubles")
		
	
	room_size_x = room_size_x_roll + room_size_x_add
	room_size_y = room_size_y_roll + room_size_y_add
	x_result_label.text = " X = " + str(room_size_x)
	y_result_label.text = " Y = " + str(room_size_y)













