extends Control
class_name DiceColor

static var d_text_color_x : Color
static var d_body_color_x : Color
static var d_text_color_y : Color
static var d_body_color_y : Color
static var d_text_color_d66_prime : Color
static var d_body_color_d66_prime : Color
static var d_text_color_d66_secondary : Color
static var d_body_color_d66_secondary : Color
static var d_text_color_single_primary : Color
static var d_body_color_single_primary : Color
static var d_text_color_single_secondary : Color
static var d_body_color_single_secondary : Color
static var d_text_color_exit_numbers : Color
static var d_body_color_exit_numbers : Color
static var d_text_color_exit_direction : Color
static var d_body_color_exit_direction : Color
static var d_text_color_exit_lock : Color
static var d_body_color_exit_lock : Color
static var d_text_color_d3 : Color
static var d_body_color_d3 : Color



func _ready():
	if ResourceLoader.exists("res://savedice.tres") : #Load custom colors
		DiceColor.load_dice_colors()
	else: # load standard colors chosen by the developer!
		DiceColor.load_default_dice_colors()
	
	
func _on_ready():
	_paint_buttons_and_text_in_menu()


func _paint_buttons_and_text_in_menu():
	# X
	%ColorPickerButton_Xtext.color = d_text_color_x
	%ColorPickerButton_X.color = d_body_color_x
	%LabelX.label_settings.font_color = d_text_color_x
	# Y
	%ColorPickerButton_Ytext.color = d_text_color_y
	%ColorPickerButton_Y.color = d_body_color_y
	%LabelY.label_settings.font_color = d_text_color_y
	# D66 Prime
	%ColorPickerButton_D66Ptext.color = d_text_color_d66_prime
	%ColorPickerButton_D66Prime.color = d_body_color_d66_prime
	%LabelD66Prime.label_settings.font_color = d_text_color_d66_prime
	# D66 Secondary
	%ColorPickerButton_D66Stext.color = d_text_color_d66_secondary
	%ColorPickerButton_D66Secondary.color = d_body_color_d66_secondary
	%LabelD66Secondary.label_settings.font_color = d_text_color_d66_secondary
	# D6 Primary
	%ColorPickerButton_PrimeText.color = d_text_color_single_primary
	%ColorPickerButton_Primary.color = d_body_color_single_primary
	%LabelD6Prime.label_settings.font_color = d_text_color_single_primary
	# D6 Secondary
	%ColorPickerButton_secondaryText.color = d_text_color_single_secondary
	%ColorPickerButton_Secondary.color = d_body_color_single_secondary
	%LabelD6Secondary.label_settings.font_color = d_text_color_single_secondary
	# Exit Number / Qty
	%ColorPickerButton_ExitNumText.color = d_text_color_exit_numbers
	%ColorPickerButton_ExitNum.color = d_body_color_exit_numbers
	%LabelExitQty.label_settings.font_color = d_text_color_exit_numbers
	# Exit Direction
	%ColorPickerButton_ExitDirText.color = d_text_color_exit_direction
	%ColorPickerButton_ExitDirection.color = d_body_color_exit_direction
	%LabelExitDir.label_settings.font_color = d_text_color_exit_direction
	# Exit Lock
	%ColorPickerButton_ExitLockText.color = d_text_color_exit_lock
	%ColorPickerButton_ExitLock.color = d_body_color_exit_lock
	%LabelExitLock.label_settings.font_color = d_text_color_exit_lock
	# D3 Die
	%ColorPickerButton_D3Text.color = d_text_color_d3
	%ColorPickerButton_D3.color = d_body_color_d3
	%LabelD3.label_settings.font_color = d_text_color_d3
	
		
static func load_default_dice_colors():
	
	d_text_color_x = Color.IVORY
	d_body_color_x = Color.ROYAL_BLUE
	d_text_color_y = Color.IVORY
	d_body_color_y = Color.FIREBRICK
	d_text_color_d66_prime = Color("7f6e19")
	d_body_color_d66_prime = Color.DEEP_SKY_BLUE
	d_text_color_d66_secondary = Color.IVORY
	d_body_color_d66_secondary = Color.DARK_ORANGE
	d_text_color_single_primary = Color.IVORY
	d_body_color_single_primary = Color.MEDIUM_BLUE
	d_text_color_single_secondary = Color.IVORY
	d_body_color_single_secondary = Color.ORANGE_RED
	d_text_color_exit_numbers = Color.BLACK
	d_body_color_exit_numbers = Color.BURLYWOOD
	d_text_color_exit_direction = Color.IVORY
	d_body_color_exit_direction = Color.WEB_MAROON
	d_text_color_exit_lock = Color.BLACK
	d_body_color_exit_lock = Color.GAINSBORO
	d_text_color_d3 = Color.IVORY
	d_body_color_d3 = Color.REBECCA_PURPLE
	

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
	saved_dice.die_body_color_exit_lock = d_body_color_exit_lock
	saved_dice.die_text_color_d3 = d_text_color_d3
	saved_dice.die_body_color_d3 = d_body_color_d3
	
	ResourceSaver.save(saved_dice, "res://savedice.tres")
	
	
static func load_dice_colors():
	
	var saved_dice:SavedDice = load("res://savedice.tres") as SavedDice
	
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



