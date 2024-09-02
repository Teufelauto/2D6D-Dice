# 2D6D Dice

![titleCapture](https://github.com/user-attachments/assets/8454851c-23c8-4458-9e9d-c5b8f99ff938)

A Dice Simulator for use with the solo RPG '2D6 Dungeon' by Toby Lancaster. 

2D6D Dice is an independent production by Jamie Halford and is not affiliated with DR Games or Toby Lancaster. It is published under the 2D6 Dungeon Third Party License.

Dice colors can be changed, as well as styles; dots or numbers. Any changes must be saved in the same menu, or they will disappear when leaving that menu. Default colors can be reset without affecting dot styles, and vice versa. The saved preference file is human-readable.
In the Windows Demo, the save file is found at C:\Users\your_name_here\AppData\Roaming\Godot\app_userdata\2D6D Dice

The compiled zip file does not require downloading Godot.

## Game Engine:
- Godot 4.3 stable

## Required Godot Addons:
- Rapier 3d Physics 0.7.27, Newer versions are broken.
- Godot Safe Resource Loader

![FatigueIncluded](https://github.com/user-attachments/assets/d62beab4-bf8c-462d-b5b3-425e93d9f653)

## Features:
- Recognizes when to roll additive dice for room size
- Creates a small drawing of the room rolled for quick orientation.
- 'Scoreboard' for normal rolls indicate when physics is done and the dice can be interacted with. - Rerolling before values come up could cause dice to get locked, and require backing out of the tray and opening it again.
- Dice style selector, and dice colors (text and bodies) can be changed and saved to disk.
- Combat Round tracking roller die (Fatigue die) can be removed from scene.
- Sound of plastic hitting faux-velvet covered cardstock and each other.
