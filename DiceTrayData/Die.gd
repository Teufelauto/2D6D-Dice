class_name DiceControl
extends RigidBody3D

@onready var raycasts = $Raycasts.get_children()

@onready var button_throw_xy = %DiceTray/RoomSizeDice/XYThrowButton
@onready var button_throw_xy2 = %DiceTray/RoomSizeDice/XYThrowButton2
@onready var button_throw_doubles = %DiceTray/DoublesDice/DoubleThrowButton
@onready var button_throw_exit_direction = %DiceTray/RoomExitDirectionDie/LCRThrowButton
@onready var button_throw_lock_check = %DiceTray/ExitLockCheckDie/ExitLockThrowButton
@onready var button_throw_primary = %DiceTray/PrimaryDie/PrimeThrowButton
@onready var button_throw_secondary = %DiceTray/SecondaryDie/SecondaryThrowButton
@onready var button_throw_d3 = %DiceTray/D3Die/D3ThrowButton
@onready var dice_tray = %DiceTray

@export var roll_strength = 50    # -------- Toss Strength ------------------
@export var spin_strength = 0.8   # ---------- Spin It ------------------------
@export var die_sound_tray_velocity_factor : float = 1.5
@export var die_sound_velocity_factor : float = 1.5


@export var roll_vibe_length : int = 20 # time in milliseconds
@export var roll_vibe_strength : float = 2.0 
@export var roll_vibe_impact_die_length : int = 10 # time in milliseconds
@export var roll_vibe_impact_die_strength : float = 3.0 
@export var roll_vibe_impact_tray_length : int = 50 # time in milliseconds
@export var roll_vibe_impact_tray_strength : float = 1.0 



var start_pos
var is_rolling = false

# For displaying roll results
signal roll_started() # Also used to clear results when picking up dice
signal roll_finished(die_value :int) # Output the die result to another script

# For signalling sound and haptics
signal dice_impact_sound(type_of_sound :String)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = global_position


func _roll() -> void:
	
	#print("_______________________________ New Roll ___________________")
	# Reset State
	
	#lock_rotation = false
	axis_lock_linear_y = false
	
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	self.set_collision_layer_value( 2, true)
	self.set_collision_mask_value( 2, true)
	
	# Clear Roll Results
	roll_started.emit()
	
	# Random Rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	# Random Throw Impulse  --- Change vector for direction
	var throw_vector = Vector3(randf_range(-.4, .4), 0, randf_range(-1, -.8)).normalized()
	angular_velocity = throw_vector * roll_strength * spin_strength
	apply_central_impulse(throw_vector * roll_strength)
	is_rolling = true
	

func _on_sleeping_state_changed() -> void:
	if sleeping:
		var landed_on_side = false
		for raycast in raycasts:
			if raycast.is_colliding():
				
				roll_finished.emit(raycast.opposite_side) # INT   Send out the data!
				is_rolling = false
				landed_on_side = true
				#freeze = true #Works to keep dice from flipping, but they can't slide around
				#lock_rotation = true # This line breaks ability to unlock, even though value un checks - BUG reported
				axis_lock_linear_y = true
				
		if not landed_on_side: # Auto reroll if rests at angle
			_roll()


# Put the dice back in the home position.
func _return_die() -> void:
	
	is_rolling = false
	# Return the dice to home
	freeze = false
	sleeping = true
	axis_lock_linear_y = false
	set_collision_layer_value( 2, false)
	set_collision_mask_value( 2, false)
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	transform.origin = start_pos
	freeze = true
	sleeping = true
	
	# Clear Roll Results
	roll_started.emit()
	

# -------------------------- PICK UP DICE --------------------------------------
# Pick up ALL Dice
func _on_pick_up_all_dice_button_pressed() -> void:
	
	# commented out is not rolling to allow picking up frozen dice
	#if not is_rolling:
	#	_return_die()
	_return_die()


# ----------------- ReROLL Previously thrown DICE ------------------------------
func _on_input_event(_camera, event, _position, _normal, _shape_idx) -> void:
	if event.is_pressed() and not is_rolling:
		
		_roll()


#---------------------------- ROLL DICE FROM HOME ------------------------------
func _on_xy_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_xy.visible = false # Main
		button_throw_xy2.visible = false #  exit die location

		_roll()


func _on_double_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_doubles.visible = false

		_roll()


func _on_lcr_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_exit_direction.visible = false

		_roll()


func _on_exit_lock_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_lock_check.visible = false

		_roll()

func _on_prime_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_primary.visible = false

		_roll()


func _on_secondary_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_secondary.visible = false
		
		_roll()


func _on_d_3_throw_button_pressed() -> void:
	if not is_rolling:
		button_throw_d3.visible = false
		
		_roll()


# ----------------   SOUND FROM IMPACTS   -----------------------------

func _on_body_entered(body) -> void:
	#print(body.name)
	var greatest_observed_velocity
	
	if abs(linear_velocity.x) > abs(linear_velocity.y):
		greatest_observed_velocity = abs(linear_velocity.x)
	else:
		greatest_observed_velocity = abs(linear_velocity.y)
	if abs(linear_velocity.z) > greatest_observed_velocity:
		greatest_observed_velocity = abs(linear_velocity.z)
		
	#var hit
	#hit = get_colliding_bodies() 
	#print(hit)

	if body == self:
		if greatest_observed_velocity > die_sound_tray_velocity_factor :
			#print("xxxxxxx Self Contact xxxxxxx" + str(greatest_observed_velocity))
			dice_impact_sound.emit("felt")

	elif body.name == "StaticBody3D" :  # If hitting tray
		if greatest_observed_velocity > die_sound_tray_velocity_factor :
			#print("///////// Tray /////////" + str(greatest_observed_velocity))
			dice_impact_sound.emit("felt")
			
	else:
		if greatest_observed_velocity > die_sound_velocity_factor :
			#print("======== Dice =========" + str(greatest_observed_velocity))
			dice_impact_sound.emit("plastic")
