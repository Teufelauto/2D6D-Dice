extends Node3D


@onready var x_result_add_label = $/root/world/CanvasLayer/XResultAddLabel
@onready var y_result_add_label = $/root/world/CanvasLayer/YResultAddLabel

signal roll_xy_add_dim(string)




func _on_xy_room_dice_roll_xy_add_dice():
	
	
	_on_d_primary_add_num_roll_started()



func _on_d_primary_add_num_roll_started():
	roll_xy_add_dim.emit() # Start up the dice children
	
	


func _on_d_primary_add_num_roll_finished(value):
	x_result_add_label.text = " + " + str(value)


func _on_d_secondary_add_num_roll_finished(value):
	y_result_add_label.text = " + " + str(value)

