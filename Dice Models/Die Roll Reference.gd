extends RigidBody3D



@onready var raycasts = $Raycasts.get_children()


var start_pos
var roll_strength = 25    
var spin_strength = 1.5   
var is_rolling = false


signal roll_started(string)
signal roll_finished(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	$CollisionShape3D.disabled = true


func _roll():
	# Reset State
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	$CollisionShape3D.disabled = false
	
	# Clear Roll Results
	roll_started.emit()
	
	# Random Rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	# Random Throw Impulse  --- Change vector for direction
	var throw_vector = Vector3(randf_range(-.02, .02), 0, randf_range(-1, -.8)).normalized()
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


# Put the dice back in the home position.
func _return_die():
	$CollisionShape3D.disabled = true
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	transform.origin = start_pos
	freeze = true
	sleeping = true
	

# ------------------------------------------------------------------------------
# Pick up ALL Dice
func _on_pick_up_all_dice_button_pressed():
	if !is_rolling:
		_return_die()

# ------------------------------------------------------------------------------
# Roll 1 Die such as D3
func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()


func _on_d_primary_add_num_input_event(_camera, event,_position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()


func _on_dx_dim_input_event(_camera, event,_position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()


func _on_dy_dim_input_event(_camera, event,_position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()


func _on_die_door_pics_input_event(_camera, event,_position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()


func _on_d_secondary_add_num_input_event(_camera, event,_position, _normal, _shape_idx):
	if event.is_pressed() && !is_rolling:
		_roll()
		
		
