# 2D6 Digital Dice
![smallDigitalDice](https://github.com/user-attachments/assets/830682bd-dc72-488b-910e-b1858aa712e8)


A Dice Simulator for use with the solo RPG '2D6 Dungeon' by Toby Lancaster. 

*2D6D Dice is an independent production by Jamie Halford and is not affiliated with DR Games or Toby Lancaster. It is published under the 2D6 Dungeon Third Party License.*

Dice colors can be changed, as well as styles; dots or numbers. Dice sounds and vibration can be changed in Options. Any changes must be saved in the same menu, or they will disappear when leaving that menu. Default colors can be reset without affecting dot styles, and vice versa. The saved preference file is human-readable. In the Windows Demo, the save file is found at C:\Users\ *user_name* \AppData\Roaming\Godot\app_userdata\2D6_Digital_Dice

## Information on Downloading:
The compiled zip files found here on GitHub in Releases to the right do not require downloading anything else. They are ready to unzip and run from that folder. They are considered an Alpha build for use on a computer to look for bugs. They are totally usable as a desktop app, though. The Android APK file will *NOT* be distributed here for sideloading. It will be distributed as a Google Play Open-Beta when ready. I will not be distributing this app on IOS because I don't feel like giving Apple $100 every year for the privilege of distributing a free app on iPhone. Someone else may compile this for iOS under the terms of the MIT License. They will need to confirm function of Back Button, especially.

## Features:
- Recognizes when to roll additive dice for room size
- Creates a small drawing of the room rolled for quick orientation.
- 'Scoreboard' for normal rolls indicate when physics is done and the dice can be interacted with. - Rerolling before values come up could cause dice to get locked, and require picking the dice up twice.
- Dice style selector, and dice colors (text and bodies) can be changed and saved to disk.
- Combat Round tracking roller die (Fatigue die) can be removed from scene, or tipped on end during exploration.
- Sound of plastic hitting faux-velvet covered cardstock and each other can be muted or amped up.

## Game Engine:
- Godot 4.3 stable

### Required Godot Addons for development:
- Rapier 3d Physics 0.7.27, Newer versions are broken.
- Godot Safe Resource Loader

![FatigueIncluded](https://github.com/user-attachments/assets/d62beab4-bf8c-462d-b5b3-425e93d9f653)

