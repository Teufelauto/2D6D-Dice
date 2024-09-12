extends RigidBody3D
class_name FatigueDie

@export var battle_round :int = 1
@export var fatigue_die_angle :float = 2.692794 ## [Radians] set for displaying 1. 



## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	return_fatigue_die_to_one()
	

## when signaled to increment 1
func increment_fatigue_die_to_next_round() -> void:
	
	if battle_round == 7 :
		battle_round = 0
		
	battle_round = 1 + battle_round
	
	match battle_round:
		1: fatigue_die_angle = 2.692794 ## Radians
		2: fatigue_die_angle = 1.795196
		3: fatigue_die_angle = 0.897598 ## ( 2*pi / 7 sides = radians per side)
		4: fatigue_die_angle = 0.0      ## Default position, because that is the way I happened to model it.
		5: fatigue_die_angle = 5.385587
		6: fatigue_die_angle = 4.487989
		7: fatigue_die_angle = 3.590392
	
	rotation.z = fatigue_die_angle
	
	
## when signalled to reset to 1
func return_fatigue_die_to_one() -> void:
	battle_round = 0
	increment_fatigue_die_to_next_round()
