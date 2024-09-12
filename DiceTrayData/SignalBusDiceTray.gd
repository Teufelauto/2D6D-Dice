extends Node

##################################################################
## Signal Bus for the Dice Tray project, 
## so objects instantiated in code can talk to other scripts.
##################################################################

## For signalling sound and haptics from die
@warning_ignore("unused_signal")
signal dice_impact_sound(type_of_sound :String)

## For exporting roll results from die
@warning_ignore("unused_signal")
signal roll_finished(die_value :int) ## Output the die result to another script

## For ReRolling dice that are on the table. from die to dicetray
@warning_ignore("unused_signal")
signal dice_to_reroll(die_clicked :String)
