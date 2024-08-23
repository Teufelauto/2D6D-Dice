2D6D Dice

A Dice Simulator for use with the solo RPG '2D6 Dungeon' by Toby Lancaster. This program is not an official product of Toby Lancaster or DR Games.

Game Engine:		Godot 4.2.2.stable

Required Assets:	Rapier 3d Physics 

Features:
- Currently, dice rolling basically works, but relies on physics sleep to report dice values, or for reroll / pickup.
- Recognizes when to roll additive dice for room size
- Creates a small drawing of the room rolled for quick orientation.
- 'Scoreboard' for normal rolls indicate when physics is done and the dice can be interacted with. - Rerolling before values come up could cause dice to get locked, and require backing out of the tray and opening it again.
- Dice colors (text and bodies) can be changed and saved to disk. (While in dev, saved to res instead of user. Must be changed to 'user' before export!  DiceTray and DiceColorMenu)

Future Features:
- Dice style selector
- Fatigue die
