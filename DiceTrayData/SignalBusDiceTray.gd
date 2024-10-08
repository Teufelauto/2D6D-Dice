extends Node

##################################################################
## Signal Bus for the Dice Tray project, 
## so objects instantiated in code can talk to other scripts.
##################################################################

## For signalling sound and haptics from die
signal dice_impact_sound(type_of_sound :String)

## For exporting roll results from die
signal roll_finished(die_value: int, die_name: String) ## Output the die result to another script

## For ReRolling dice that are on the table. from die to dicetray
signal dice_to_reroll(die_clicked :String)
