extends RigidBody3D



@onready var raycasts = $Raycasts.get_children()


var start_pos
var roll_strength = 40    # 30
var spin_strength = .9   # 0.5
var is_rolling = false


signal roll_started(string)
signal roll_finished(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position

#func _input(event):
#	if event.is_action_pressed("ui_accept") && !is_rolling:
#		_roll()

func _on_xy_room_dice_roll_xy_dice():
	if !is_rolling:
		
		$CollisionShape3D.disabled = false
		_roll()




func	_roll():
	# Reset State
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# Clear Roll Results
	roll_started.emit()
	
	
	# Random Rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	# Random Throw Impulse  --- Change vector for direction
	var throw_vector = Vector3(randf_range(-1, 1), 0, randf_range(-1, -.1)).normalized()
	angular_velocity = throw_vector * roll_strength * spin_strength
	apply_central_impulse(throw_vector * roll_strength)
	is_rolling = true


func _on_sleeping_state_changed():
	if sleeping:
		var landed_on_side = false
		for raycast in raycasts:
			if raycast.is_colliding():
				roll_finished.emit(raycast.opposite_side)
				is_rolling = false
				landed_on_side = true
		
		if !landed_on_side:
			_roll()


