extends Control
class_name DiceStyle

static var d_style_x : String
static var d_style_y : String
static var d_style_d66_prime : String
static var d_style_d66_secondary : String
static var d_style_single_primary : String
static var d_style_single_secondary : String
static var d_style_exit_qty : String
static var d_style_exit_direction : String
static var d_style_exit_lock : String
static var d_style_d3 : String


func _ready():
	if ResourceLoader.exists("user://savedice.tres") : #Load custom colors
		DiceColor.load_dice_colors()
		DiceStyle.load_dice_styles()
		
	else: # load standard colors and styles chosen by the developer!
		DiceColor.load_default_dice_colors()
		DiceStyle.load_default_dice_styles()
	
func _on_ready():
	_paint_buttons_and_text_in_menu()


func _paint_buttons_and_text_in_menu():
	# X
	%ColorPickerButton_Xtext.color = DiceColor.d_text_color_x
	%ColorPickerButton_X.color = DiceColor.d_body_color_x
	%LabelX.label_settings.font_color = DiceColor.d_text_color_x
	# Y
	%ColorPickerButton_Ytext.color = DiceColor.d_text_color_y
	%ColorPickerButton_Y.color = DiceColor.d_body_color_y
	%LabelY.label_settings.font_color = DiceColor.d_text_color_y
	# D66 Prime
	%ColorPickerButton_D66Ptext.color = DiceColor.d_text_color_d66_prime
	%ColorPickerButton_D66Prime.color = DiceColor.d_body_color_d66_prime
	%LabelD66Prime.label_settings.font_color = DiceColor.d_text_color_d66_prime
	# D66 Secondary
	%ColorPickerButton_D66Stext.color = DiceColor.d_text_color_d66_secondary
	%ColorPickerButton_D66Secondary.color = DiceColor.d_body_color_d66_secondary
	%LabelD66Secondary.label_settings.font_color = DiceColor.d_text_color_d66_secondary
	# D6 Primary
	%ColorPickerButton_PrimeText.color = DiceColor.d_text_color_single_primary
	%ColorPickerButton_Primary.color = DiceColor.d_body_color_single_primary
	%LabelD6Prime.label_settings.font_color = DiceColor.d_text_color_single_primary
	# D6 Secondary
	%ColorPickerButton_secondaryText.color = DiceColor.d_text_color_single_secondary
	%ColorPickerButton_Secondary.color = DiceColor.d_body_color_single_secondary
	%LabelD6Secondary.label_settings.font_color = DiceColor.d_text_color_single_secondary
	# Exit Number / Qty
	%ColorPickerButton_ExitNumText.color = DiceColor.d_text_color_exit_numbers
	%ColorPickerButton_ExitNum.color = DiceColor.d_body_color_exit_numbers
	%LabelExitQty.label_settings.font_color = DiceColor.d_text_color_exit_numbers
	# Exit Direction
	%ColorPickerButton_ExitDirText.color = DiceColor.d_text_color_exit_direction
	%ColorPickerButton_ExitDirection.color = DiceColor.d_body_color_exit_direction
	%LabelExitDir.label_settings.font_color = DiceColor.d_text_color_exit_direction
	# Exit Lock
	%ColorPickerButton_ExitLockText.color = DiceColor.d_text_color_exit_lock
	%ColorPickerButton_ExitLock.color = DiceColor.d_body_color_exit_lock
	%LabelExitLock.label_settings.font_color = DiceColor.d_text_color_exit_lock
	# D3 Die
	%ColorPickerButton_D3Text.color = DiceColor.d_text_color_d3
	%ColorPickerButton_D3.color = DiceColor.d_body_color_d3
	%LabelD3.label_settings.font_color = DiceColor.d_text_color_d3
	# Tray Felt color
	%ColorPickerButton_TrayFelt.color = DiceColor.d_tray_felt_color
	

func _save_dice_styles(): 
	
	var saved_dice:SavedDice = SavedDice.new()
	
	#styles
	saved_dice.die_style_x = d_style_x
	saved_dice.die_style_y = d_style_y
	saved_dice.die_style_d66_prime = d_style_d66_prime
	saved_dice.die_style_d66_secondary = d_style_d66_secondary
	saved_dice.die_style_single_primary = d_style_single_primary 
	saved_dice.die_style_single_secondary = d_style_single_secondary
	saved_dice.die_style_exit_qty = d_style_exit_qty
	saved_dice.die_style_exit_direction = d_style_exit_direction
	saved_dice.die_style_exit_lock = d_style_exit_lock
	saved_dice.die_style_d3 = d_style_d3
	
	ResourceSaver.save(saved_dice, "res://savedice.tres")

static func load_dice_styles(): # from file
	
	var saved_dice:SavedDice = SafeResourceLoader.load("user://savedice.tres") as SavedDice
	
	if saved_dice == null:
		print("SaveDice.tres file was unsafe!")
		return
	
	#styles
	d_style_x = saved_dice.die_style_x
	d_style_y = saved_dice.die_style_y
	d_style_d66_prime = saved_dice.die_style_d66_prime
	d_style_d66_secondary = saved_dice.die_style_d66_secondary
	d_style_single_primary = saved_dice.die_style_single_primary
	d_style_single_secondary = saved_dice.die_style_single_secondary
	d_style_exit_qty = saved_dice.die_style_exit_qty
	d_style_exit_direction = saved_dice.die_style_exit_direction
	d_style_exit_lock = saved_dice.die_style_exit_lock
	d_style_d3 = saved_dice.die_style_d3


static func load_default_dice_styles():
	# dice styles
	d_style_x = "die_let"
	d_style_y = "die_let"
	d_style_d66_prime = "die_num"
	d_style_d66_secondary = "die_num"
	d_style_single_primary = "die_num"
	d_style_single_secondary = "die_num"
	d_style_exit_qty = "die_dot"
	d_style_exit_direction = "die_let"
	d_style_exit_lock = "die_dot"
	d_style_d3 = "die_let"
	
	
func _on_load_default_pressed():
	DiceStyle.load_default_dice_styles()
	_paint_buttons_and_text_in_menu()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")

##-----------------------------------------------------------------------------
##-----------------------------------------------------------------------------

func _on_color_picker_button_xtext_color_changed(color):
	%LabelX.label_settings.font_color = color
	DiceColor.d_text_color_x = color
	
	
func _on_color_picker_button_x_color_changed(color):
	DiceColor.d_body_color_x = color


func _on_color_picker_button_ytext_color_changed(color):
	%LabelY.label_settings.font_color = color
	DiceColor.d_text_color_y = color


func _on_color_picker_button_y_color_changed(color):
	DiceColor.d_body_color_y = color


func _on_color_picker_button_d_66_ptext_color_changed(color):
	%LabelD66Prime.label_settings.font_color = color
	DiceColor.d_text_color_d66_prime = color
	

func _on_color_picker_button_d_66_prime_color_changed(color):
	DiceColor.d_body_color_d66_prime = color
	
	
func _on_color_picker_button_d_66_stext_color_changed(color):
	%LabelD66Secondary.label_settings.font_color = color
	DiceColor.d_text_color_d66_secondary = color
	
func _on_color_picker_button_d_66_secondary_color_changed(color):
	DiceColor.d_body_color_d66_secondary = color
	

func _on_color_picker_button_prime_text_color_changed(color):
	%LabelD6Prime.label_settings.font_color = color
	DiceColor.d_text_color_single_primary = color


func _on_color_picker_button_primary_color_changed(color):
	DiceColor.d_body_color_single_primary = color
	

func _on_color_picker_button_secondary_text_color_changed(color):
	%LabelD6Secondary.label_settings.font_color = color
	DiceColor.d_text_color_single_secondary = color


func _on_color_picker_button_secondary_color_changed(color):
	DiceColor.d_body_color_single_secondary = color
	

func _on_color_picker_button_exit_num_text_color_changed(color):
	%LabelExitQty.label_settings.font_color = color
	DiceColor.d_text_color_exit_numbers = color


func _on_color_picker_button_exit_num_color_changed(color):
	DiceColor.d_body_color_exit_numbers = color


func _on_color_picker_button_exit_dir_text_color_changed(color):
	%LabelExitDir.label_settings.font_color = color
	DiceColor.d_text_color_exit_direction = color


func _on_color_picker_button_exit_direction_color_changed(color):
	DiceColor.d_body_color_exit_direction = color
	

func _on_color_picker_button_exit_lock_text_color_changed(color):
	%LabelExitLock.label_settings.font_color = color
	DiceColor.d_text_color_exit_lock = color
	

func _on_color_picker_button_exit_lock_color_changed(color):
	DiceColor.d_body_color_exit_lock = color
	

func _on_color_picker_button_d_3_text_color_changed(color):
	%LabelD3.label_settings.font_color = color
	DiceColor.d_text_color_d3 = color


func _on_color_picker_button_d_3_color_changed(color):
	DiceColor.d_body_color_d3 = color

func _on_color_picker_button_tray_felt_color_changed(color):
	DiceColor.d_tray_felt_color = color
	
	







