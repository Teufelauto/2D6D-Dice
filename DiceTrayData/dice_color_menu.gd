extends Control
class_name DiceColor

@onready var d_text_color_x
@onready var d_body_color_x
@onready var d_text_color_y
@onready var d_body_color_y
@onready var d_text_color_d66_prime
@onready var d_body_color_d66_prime
@onready var d_text_color_d66_secondary
@onready var d_body_color_d66_secondary
@onready var d_text_color_single_primary
@onready var d_body_color_single_primary
@onready var d_text_color_single_secondary
@onready var d_body_color_single_secondary
@onready var d_text_color_exit_numbers
@onready var d_body_color_exit_numbers
@onready var d_text_color_exit_direction
@onready var d_body_color_exit_direction
@onready var d_text_color_exit_lock
@onready var d_body_color_exit_lock
@onready var d_text_color_d3
@onready var d_body_color_d3



func _ready():
	load_dice_colors()


func save_dice_colors():
	var saved_dice:SavedDice = SavedDice.new()
	
	saved_dice.die_text_color_x = d_text_color_x 
	saved_dice.die_body_color_x = d_body_color_x 
	saved_dice.die_text_color_y = d_text_color_y
	saved_dice.die_body_color_y = d_body_color_y
	saved_dice.die_text_color_d66_prime = d_text_color_d66_prime
	saved_dice.die_body_color_d66_prime = d_body_color_d66_prime
	saved_dice.die_text_color_d66_secondary = d_text_color_d66_secondary
	saved_dice.die_body_color_d66_secondary = d_body_color_d66_secondary
	saved_dice.die_text_color_single_primary = d_text_color_single_primary
	saved_dice.die_body_color_single_primary = d_body_color_single_primary
	saved_dice.die_text_color_single_secondary = d_text_color_single_secondary
	saved_dice.die_body_color_single_secondary = d_body_color_single_secondary
	saved_dice.die_text_color_exit_numbers = d_text_color_exit_numbers
	saved_dice.die_body_color_exit_numbers = d_body_color_exit_numbers
	saved_dice.die_text_color_exit_direction = d_text_color_exit_direction
	saved_dice.die_body_color_exit_direction = d_body_color_exit_direction
	saved_dice.die_text_color_exit_lock = d_text_color_exit_lock
	saved_dice.die_body_color_exit_loc = d_body_color_exit_lock
	saved_dice.die_text_color_d3 = d_text_color_d3
	saved_dice.die_body_color_d3 = d_body_color_d3
	
	ResourceSaver.save(saved_dice, "user://savedice.tres")
	
func load_dice_colors():
	if ResourceLoader.exists("user://savedice.tres") == false :
		return
	
	var saved_dice:SavedDice = load("user://savedice.tres") as SavedDice
	
	d_text_color_x = saved_dice.die_text_color_x
	d_body_color_x = saved_dice.die_body_color_x
	d_text_color_y = saved_dice.die_text_color_y
	d_body_color_y = saved_dice.die_body_color_y
	d_text_color_d66_prime = saved_dice.die_text_color_d66_prime
	d_body_color_d66_prime = saved_dice.die_body_color_d66_prime
	d_text_color_d66_secondary = saved_dice.die_text_color_d66_secondary
	d_body_color_d66_secondary = saved_dice.die_body_color_d66_secondary
	d_text_color_single_primary = saved_dice.die_text_color_single_primary
	d_body_color_single_primary = saved_dice.die_body_color_single_primary
	d_text_color_single_secondary = saved_dice.die_text_color_single_secondary
	d_body_color_single_secondary = saved_dice.die_body_color_single_secondary
	d_text_color_exit_numbers = saved_dice.die_text_color_exit_numbers
	d_body_color_exit_numbers = saved_dice.die_body_color_exit_numbers
	d_text_color_exit_direction = saved_dice.die_text_color_exit_direction 
	d_body_color_exit_direction = saved_dice.die_body_color_exit_direction
	d_text_color_exit_lock = saved_dice.die_text_color_exit_lock
	d_body_color_exit_lock = saved_dice.die_body_color_exit_lock
	d_text_color_d3 = saved_dice.die_text_color_d3
	d_body_color_d3 = saved_dice.die_body_color_d3
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")


func _on_color_picker_button_xtext_color_changed(color):
	%LabelX.label_settings.font_color = color
	d_text_color_x = color
	
	
func _on_color_picker_button_x_color_changed(color):
	d_body_color_x = color


func _on_color_picker_button_ytext_color_changed(color):
	%LabelY.label_settings.font_color = color
	d_text_color_y = color


func _on_color_picker_button_y_color_changed(color):
	d_body_color_y = color


func _on_color_picker_button_d_66_ptext_color_changed(color):
	%LabelD66Prime.label_settings.font_color = color
	d_text_color_d66_prime = color
	

func _on_color_picker_button_d_66_prime_color_changed(color):
	d_body_color_d66_prime = color
	
	
func _on_color_picker_button_d_66_stext_color_changed(color):
	%LabelD66Secondary.label_settings.font_color = color
	d_text_color_d66_secondary = color
	
func _on_color_picker_button_d_66_secondary_color_changed(color):
	d_body_color_d66_secondary = color
	

func _on_color_picker_button_prime_text_color_changed(color):
	%LabelD6Prime.label_settings.font_color = color
	d_text_color_single_primary = color


func _on_color_picker_button_primary_color_changed(color):
	d_body_color_single_primary = color
	

func _on_color_picker_button_secondary_text_color_changed(color):
	%LabelD6Secondary.label_settings.font_color = color
	d_text_color_single_secondary = color


func _on_color_picker_button_secondary_color_changed(color):
	d_body_color_single_secondary = color
	

func _on_color_picker_button_exit_num_text_color_changed(color):
	%LabelExitQty.label_settings.font_color = color
	d_text_color_exit_numbers = color


func _on_color_picker_button_exit_num_color_changed(color):
	d_body_color_exit_numbers = color


func _on_color_picker_button_exit_dir_text_color_changed(color):
	%LabelExitDir.label_settings.font_color = color
	d_text_color_exit_direction = color


func _on_color_picker_button_exit_direction_color_changed(color):
	d_body_color_exit_direction = color
	

func _on_color_picker_button_exit_lock_text_color_changed(color):
	%LabelExitLock.label_settings.font_color = color
	d_text_color_exit_lock = color
	

func _on_color_picker_button_exit_lock_color_changed(color):
	d_body_color_exit_lock = color
	

func _on_color_picker_button_d_3_text_color_changed(color):
	%LabelD3.label_settings.font_color = color
	d_text_color_d3 = color


func _on_color_picker_button_d_3_color_changed(color):
	d_body_color_d3 = color

