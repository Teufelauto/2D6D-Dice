class_name RoomRectangleDrawing
extends Line2D


var rectangle_size_factor : int = 20 # pixels wide that one rolled on die will be
var rectangle_max_size : int = rectangle_size_factor * 11 # max size of room in pixels (5,5 then 6,6 is max sized room that can be rolled)


# resize the drawing for the room dice dimensioned rectangle
func resize_room_rectangle(x_size,y_size):
	x_size = x_size * rectangle_size_factor
	y_size = rectangle_max_size - ( y_size * rectangle_size_factor ) # 0,0 is upper left, but we need lower left
	set_point_position(0,Vector2( 0, rectangle_max_size )) # Lower Left corner
	set_point_position(1,Vector2( x_size, rectangle_max_size )) # Lower Right corner
	set_point_position(2,Vector2( x_size, y_size )) # Upper Right corner
	set_point_position(3,Vector2( 0, y_size )) # Upper Left corner
	visible = true


func _on_dice_tray_clear_room_rectangle():
	visible = false
