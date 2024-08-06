extends RigidBody3D



@onready var raycasts = $Raycasts.get_children()

@onready var button_throw_xy = $/root/world/DiceTray/RoomSizeDice/XYThrowButton
@onready var button_throw_xy2 = $/root/world/DiceTray/RoomSizeDice/XYThrowButton2
@onready var button_throw_doubles = $/root/world/DiceTray/DoublesDice/DoubleThrowButton
@onready var button_throw_exit_direction = $/root/world/DiceTray/RoomExitDirectionDie/LCRThrowButton
@onready var button_throw_lock_check = $/root/world/DiceTray/ExitLockCheckDie/ExitLockThrowButton
@onready var button_throw_primary = $/root/world/DiceTray/PrimaryDie/PrimeThrowButton
@onready var button_throw_secondary = $/root/world/DiceTray/SecondaryDie/SecondaryThrowButton
@onready var button_throw_d3 = $/root/world/DiceTray/D3Die/D3ThrowButton





var start_pos
var roll_strength = 20    
var spin_strength = 1.0   
var is_rolling = false


signal roll_started(string)
signal roll_finished(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	


func _roll():
	# Reset State
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	#$CollisionShape3D.disabled = false
	self.set_collision_layer_value ( 2, true)
	
	# Clear Roll Results
	roll_started.emit()
	
	# Random Rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	# Random Throw Impulse  --- Change vector for direction
	var throw_vector = Vector3(randf_range(-.1, .1), 0, randf_range(-1, -.8)).normalized()
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
	# Return the dice to home
	self.set_collision_layer_value ( 2, false)
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	transform.origin = start_pos
	freeze = true
	sleeping = true
	
	# Turn on the Roll Buttons again
	button_throw_xy.visible = true
	button_throw_xy2.visible = true
	button_throw_doubles.visible = true
	button_throw_exit_direction.visible = true
	button_throw_lock_check.visible = true
	button_throw_primary.visible = true
	button_throw_secondary.visible = true
	button_throw_d3.visible = true
	

# -------------------------- PICK UP DICE --------------------------------------
# Pick up ALL Dice
func _on_pick_up_all_dice_button_pressed():
	if !is_rolling:
		_return_die()


# --------------------------- REROLL DICE --------------------------------------
# ReRoll 1 Die such as D3
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


#---------------------------- ROLL DICE ----------------------------------------
func _on_xy_throw_button_pressed():
	if !is_rolling:
		button_throw_xy.visible = false
		button_throw_xy2.visible = false
		_roll()


func _on_double_throw_button_pressed():
	if !is_rolling:
		button_throw_doubles.visible = false
		_roll()


func _on_lcr_throw_button_pressed():
	if !is_rolling:
		button_throw_exit_direction.visible = false
		_roll()


func _on_exit_lock_throw_button_pressed():
	if !is_rolling:
		button_throw_lock_check.visible = false
		_roll()

func _on_prime_throw_button_pressed():
	if !is_rolling:
		button_throw_primary.visible = false
		_roll()


func _on_secondary_throw_button_pressed():
	if !is_rolling:
		button_throw_secondary.visible = false
		_roll()


func _on_d_3_throw_button_pressed():
	if !is_rolling:
		button_throw_d3.visible = false
		_roll()
		
