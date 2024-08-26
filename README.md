2D6D Dice

A Dice Simulator for use with the solo RPG '2D6 Dungeon' by Toby Lancaster. This program is not an official product of Toby Lancaster or DR Games.

Dice colors can be changed, as well as styles; dots or numbers. Any changes must be saved in the same menu, or they will disappear when leaving that menu. Default colors can be reset without affecting dot styles, and vice versa. The saved preference file is human-readable.

Game Engine:		Godot 4.2.2.stable

Required Addons:	Rapier 3d Physics , Godot Safe Resource Loader

Features:
- Currently, dice rolling basically works, but relies on physics sleep to report dice values, or for reroll / pickup.
- Recognizes when to roll additive dice for room size
- Creates a small drawing of the room rolled for quick orientation.
- 'Scoreboard' for normal rolls indicate when physics is done and the dice can be interacted with. - Rerolling before values come up could cause dice to get locked, and require backing out of the tray and opening it again.
- Dice style selector, and dice colors (text and bodies) can be changed and saved to disk. C:\Users\YourName\AppData\Roaming\Godot\app_userdata\2D6D Dice.saedice.tres.
- Combat Round tracking roller die (Fatigue die)

Future Features:
- Make Fatigue Die optional
- Sound of plastic hitting faux-velvet covered cardstock
