extends RigidBody3D
class_name FatigueDie

@export var battle_round :int = 1
@export var fatigue_die_angle :float = 2.692794 ## [Radians] set for displaying 1. 
@export var fatigue_die_in_combat_state :bool


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	return_fatigue_die_to_one()
	fatigue_die_in_combat_state = false
	position_for_exploration()

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


func position_determination_on_click() -> void:
	#print("fatigue_die_in_combat_state is " + str(fatigue_die_in_combat_state))
	if fatigue_die_in_combat_state: ## In Combat before button pressed to switch to exploration.
		position_for_exploration()
		#print("Now Exploring")
		fatigue_die_in_combat_state = false ## Make opposite
		$"../../DiceCanvas/CombatSelectButton".text = "Begin Combat" ## New button text
		
	else: ## in Exploration before button pressed to change to combat.
		position_for_combat()
		#print("In Mortal Combat!")
		fatigue_die_in_combat_state = true ## Make opposite
		$"../../DiceCanvas/CombatSelectButton".text = "End Combat" ## New button text.


## Tip up the roller on its end.
func position_for_exploration() -> void:
	rotation_degrees.x = -90
	position.x = -0.03
	position.y = 0.145
	position.z = -0.14
	$"../../DiceCanvas/FatigueIncrementButton".visible = false
	$"../StaticBody3DFatigue".set_collision_layer_value( 3, false) ## Sloped Collision box


## Lay the roller down on its side.
func position_for_combat() -> void:
	rotation_degrees.x = 0
	position.x = 0
	position.y = 0
	position.z = 0
	$"../../DiceCanvas/FatigueIncrementButton".visible = true
	$"../StaticBody3DFatigue".set_collision_layer_value( 3, true) ## Sloped Collision box
