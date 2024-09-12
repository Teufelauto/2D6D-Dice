class_name SavedDice
extends Resource

## This file lists all variables saved in the dice preferences

## Dice Colors
@export var die_text_color_x : Color
@export var die_body_color_x : Color
@export var die_text_color_y : Color
@export var die_body_color_y : Color
@export var die_text_color_d66_prime : Color
@export var die_body_color_d66_prime : Color
@export var die_text_color_d66_secondary : Color
@export var die_body_color_d66_secondary : Color
@export var die_text_color_single_primary : Color
@export var die_body_color_single_primary : Color
@export var die_text_color_single_secondary : Color
@export var die_body_color_single_secondary : Color
@export var die_text_color_exit_numbers : Color
@export var die_body_color_exit_numbers : Color
@export var die_text_color_exit_direction : Color
@export var die_body_color_exit_direction : Color
@export var die_text_color_exit_lock : Color
@export var die_body_color_exit_lock : Color
@export var die_text_color_d3 : Color
@export var die_body_color_d3 : Color
@export var die_tray_felt_color : Color

## Dice Styles
@export var die_style_x : String
@export var die_style_y : String
@export var die_style_d66_prime : String
@export var die_style_d66_secondary : String
@export var die_style_single_primary : String
@export var die_style_single_secondary : String
@export var die_style_exit_qty : String
@export var die_style_exit_direction : String
@export var die_style_exit_lock : String
@export var die_style_d3 : String

## Fatigue Die
@export var die_text_color_fatigue : Color
@export var die_body_color_fatigue : Color
@export var die_style_fatigue : String
@export var die_vis_fatigue : bool ## Dice Option

## Dice Vibration and sound
@export var die_vibration_on : bool
@export var die_unmuted : bool
@export var die_volume_felt : float
@export var die_volume_plastic : float

## Future music Feature?
@export var die_music_unmuted  : bool
@export var die_music_volume : float
@export var die_music_variant : int
