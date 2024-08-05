extends Node3D

@onready var collision_dx = $/root/world/DiceTray/RoomSizeDice/DXDim/CollisionShape3D.disabled
@onready var collision_dy = $/root/world/DiceTray/RoomSizeDice/DYDim/CollisionShape3D.disabled



# Called when the node enters the scene tree for the first time.
func _ready():
	collision_dx = false
	collision_dy = false


