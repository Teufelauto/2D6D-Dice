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
			## Reset State for reRoll. This will not be called more than once or twice,
			##   so should be fine not reinstating dice.
			axis_lock_linear_y = false
			sleeping = false
			transform.origin = start_pos
			linear_velocity = Vector3.ZERO
			angular_velocity = Vector3.ZERO
			roll()


## ----------------- ReROLL Previously thrown DICE when clicked  --------------
func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, \
					_normal: Vector3, _shape_idx: int) -> void:
	if event.is_pressed() and not is_rolling:
		
		## We need to get this die back in the hand, along with any of its friends.
		## We'll create signal that sends name of die we clicked and do the 
		## resetting, then rerolling in DiceTray.
		var _die_clicked: String = self.name
		#print(_die_clicked + " is the clicked die")
		SignalBusDiceTray.dice_to_reroll.emit(_die_clicked)


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
