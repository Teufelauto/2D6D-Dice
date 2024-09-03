extends RigidBody3D
class_name FatigueDie

@export var battle_round :int = 1
@export var fatigue_die_angle :float = 2.692794 # Radians (deg*pi/180=rad)



# Called when the node enters the scene tree for the first time.
func _ready():
	
	return_fatigue_die_to_one()
	

# when signaled to increment 1
func increment_fatigue_die_to_next_round():
	
	if battle_round == 7 :
		battle_round = 0
		
	battle_round = 1 + battle_round
	
	match battle_round:
		1: fatigue_die_angle = 2.692794 # Radians
		2: fatigue_die_angle = 1.795196
		3: fatigue_die_angle = 0.897598
		4: fatigue_die_angle = 0.0
		5: fatigue_die_angle = 5.385587
		6: fatigue_die_angle = 4.487989
		7: fatigue_die_angle = 3.590392
	
	rotation.z = fatigue_die_angle
	Input.vibrate_handheld(50,1)
	%AudioStreamPlayerDiceTray.play()
	
# when signalled to reset to 1
func return_fatigue_die_to_one():
	battle_round = 0
	increment_fatigue_die_to_next_round()
