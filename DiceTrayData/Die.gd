class_name DiceControl
extends RigidBody3D

@onready var raycasts = $Raycasts.get_children()

@export var roll_strength = 50    ## -------- Toss Strength ------------------
@export var spin_strength = -50   ##  Spin Speed  Negative for CCW spin (Right Handed)
@export var die_sound_tray_velocity_factor : float = 1.5 ## cutoff under which no sound emitted
@export var die_sound_velocity_factor : float = 1.5 ## cutoff under which no sound emitted

var start_pos ## Home position where the die gets returned to. May not be as important with instance killing...
var is_rolling = false


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	start_pos = global_position
	


func roll() -> void:
	#print("_______________________________ New Roll ________________________________")
	freeze = false ## Allow forces to act upon die.
	set_collision_layer_value( 2, true) ## Is a collidable die.
	set_collision_mask_value( 2, true)  ## Will collide with other dice.
	
	## Random Rotation : Die starts different every throw.
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2* PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2* PI)) * transform.basis
	
	## Random Throw  --- Change vector for direction. 
	## First position is for left-right spread of throw.
	## The last position is negative for throwing away from player.
	var throw_vector = Vector3(randf_range(-.4, .4), 0, randf_range(-1, -.8)).normalized()
	
	## CCW spin (right handed throw) by defining spin_strength negative applied
	##     to angular_velocity.  Is this the Right-Hand-Rule of Physics
	##     where a thumbs-up's thumb points direction of travel and fingers point
	##     in positive direction? Or is that just for electricity in a wire?
	angular_velocity = throw_vector * spin_strength 
	apply_central_impulse(throw_vector * roll_strength) ## Actual Throw
	is_rolling = true


func _on_sleeping_state_changed() -> void:
	if sleeping:
		var landed_on_side = false
		for raycast in raycasts:
			if raycast.is_colliding():
				
				SignalBusDiceTray.roll_finished.emit(raycast.opposite_side) ## INT   Send out the data!
				is_rolling = false
				landed_on_side = true
				axis_lock_linear_y = true
				
		if not landed_on_side: ## Auto reroll if rests at angle
			## Reset State for reRoll.
			axis_lock_linear_y = false
			sleeping = false
			transform.origin = start_pos
			linear_velocity = Vector3.ZERO
			angular_velocity = Vector3.ZERO
			roll()


## Put the dice back in the home position.
func _return_die() -> void:
	
	is_rolling = false
	## Return the dice to home
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
	
	## Clear Roll Results

	

## -------------------------- PICK UP DICE --------------------------------------
## Pick up ALL Dice
func _on_pick_up_all_dice_button_pressed() -> void:
	
	## commented out is not rolling to allow picking up frozen dice
	#if not is_rolling:
	#	_return_die()
	_return_die()


## ----------------- ReROLL Previously thrown DICE ------------------------------
#func _input(event) -> void:
	#if event.is_pressed() and not is_rolling:
		#self.roll()


## ----------------   SOUND FROM IMPACTS   -----------------------------
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
			SignalBusDiceTray.dice_impact_sound.emit("felt")

	elif body.name == "StaticBody3D" :  ## If hitting tray, because tray collisions were not named individually
		if greatest_observed_velocity > die_sound_tray_velocity_factor :
			#print("///////// Tray /////////" + str(greatest_observed_velocity))
			SignalBusDiceTray.dice_impact_sound.emit("felt")
			
	else:
		if greatest_observed_velocity > die_sound_velocity_factor :
			#print("======== Dice =========" + str(greatest_observed_velocity))
			SignalBusDiceTray.dice_impact_sound.emit("plastic")
