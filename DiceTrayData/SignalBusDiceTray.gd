extends Node

##################################################################
## Signal Bus for the Dice Tray project, 
## so objects instantiated in code can talk to other scripts.
##################################################################

## For signalling sound and haptics from die
signal dice_impact_sound(type_of_sound :String)

## For exporting roll results from die
signal roll_finished(die_value :int) ## Output the die result to another script
