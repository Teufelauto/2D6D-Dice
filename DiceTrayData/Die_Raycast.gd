extends RayCast3D


@export var opposite_side: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_exception(owner)
	
