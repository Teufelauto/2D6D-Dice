extends Control
class_name DicePreferences

# Colors
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
static var d_tray_felt_color : Color

# Styles
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

# Fatigue die
static var d_text_color_fatigue :Color
static var d_body_color_fatigue :Color
static var d_style_fatigue : String
static var d_vis_fatigue : bool


func _ready():
	if ResourceLoader.exists("user://savedice.tres") : #Load custom colors
		DicePreferences.load_dice_colors()
		DicePreferences.load_dice_styles()
		DicePreferences.load_fatigue_die()
		
	else: # load standard colors chosen by the developer!
		DicePreferences.load_default_dice_colors()
		DicePreferences.load_default_dice_styles()
		DicePreferences.load_default_fatigue_die()
	
func _on_ready_color_menu(): # called only by Color menu when opened
	_paint_buttons_and_text_in_menu()


func _on_ready_set_style_popups(): # called only by Style menu when opened
	_update_displayed_style_buttons()


func _on_ready_fatigue_options_menu(): # called only by fatigue menu when opened
	_paint_buttons_and_update_style_in_fatigue_menu()


func _update_displayed_style_buttons():
	var index :int 
	match d_style_x:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_x.selected = index
	
	match d_style_y:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_y.selected = index
	
	match d_style_d66_prime:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_d66_prime.selected = index
	
	match d_style_d66_secondary:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_d66_secondary.selected = index
	
	match d_style_single_primary:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_single_primary.selected = index
	
	match d_style_single_secondary:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_single_secondary.selected = index
	
	match d_style_exit_direction:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_exit_direction.selected = index
	
	match d_style_exit_qty:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_exit_qty.selected = index
	
	match d_style_exit_lock:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_exit_lock.selected = index
	
	match d_style_d3:
		"die_num" : index = 0
		"die_dot" : index = 1
		"die_let" : index = 2
	$MarginContainer/GridContainer/d_style_d3.selected = index


func _paint_buttons_and_update_style_in_fatigue_menu():
	
	# Fatigue die visibility
	if d_vis_fatigue == true:
		%FatigueDieVisiblity.selected = 1
	else:
		%FatigueDieVisiblity.selected = 0
	
	# Fatigue Color
	%ColorPickerButton_FatigueText.color = d_text_color_fatigue
	%ColorPickerButton_Fatigue.color = d_body_color_fatigue
	%LabelFatigue.label_settings.font_color = d_text_color_fatigue
	
	# Fatigue Style
	var index :int 
	match d_style_fatigue:
		"die_1" : index = 0
		"die_2" : index = 1
		"die_3" : index = 2
	$MarginContainer/VBoxContainer/GridContainer/d_style_fatigue.selected = index


func _paint_buttons_and_text_in_menu(): # in color menu
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
	# Tray Felt color
	%ColorPickerButton_TrayFelt.color = d_tray_felt_color
	
	
func _on_load_default_colors_pressed():
	DicePreferences.load_default_dice_colors()
	_paint_buttons_and_text_in_menu()


func _on_load_default_styles_pressed():
	DicePreferences.load_default_dice_styles()
	_update_displayed_style_buttons()
	
	
func _on_load_default_fatigue_pressed():
	DicePreferences.load_default_fatigue_die()
	_paint_buttons_and_update_style_in_fatigue_menu()


static func load_dice_colors(): # from file
	var saved_dice:SavedDice = SafeResourceLoader.load("user://savedice.tres") as SavedDice
		
	if saved_dice == null:
		print("SaveDice.tres file was unsafe!")
		return
	
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
	d_tray_felt_color = saved_dice.die_tray_felt_color


static func load_default_dice_colors():
	# Dice Colors
	d_text_color_x = Color.ANTIQUE_WHITE
	d_body_color_x = Color.ROYAL_BLUE
	d_text_color_y = Color.ANTIQUE_WHITE
	d_body_color_y = Color.FIREBRICK
	d_text_color_d66_prime = Color("7f6e19")
	d_body_color_d66_prime = Color.DEEP_SKY_BLUE
	d_text_color_d66_secondary = Color.ANTIQUE_WHITE
	d_body_color_d66_secondary = Color.DARK_ORANGE
	d_text_color_single_primary = Color.ANTIQUE_WHITE
	d_body_color_single_primary = Color.MEDIUM_BLUE
	d_text_color_single_secondary = Color.ANTIQUE_WHITE
	d_body_color_single_secondary = Color.ORANGE_RED
	d_text_color_exit_numbers = Color.BLACK
	d_body_color_exit_numbers = Color.BURLYWOOD
	d_text_color_exit_direction = Color.ANTIQUE_WHITE
	d_body_color_exit_direction = Color.WEB_MAROON
	d_text_color_exit_lock = Color.BLACK
	d_body_color_exit_lock = Color.ANTIQUE_WHITE
	d_text_color_d3 = Color.ANTIQUE_WHITE
	d_body_color_d3 = Color.REBECCA_PURPLE
	d_tray_felt_color = Color.DARK_GREEN
	

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
	d_style_d66_prime = "die_dot"
	d_style_d66_secondary = "die_dot"
	d_style_single_primary = "die_num"
	d_style_single_secondary = "die_num"
	d_style_exit_qty = "die_dot"
	d_style_exit_direction = "die_let"
	d_style_exit_lock = "die_dot"
	d_style_d3 = "die_dot"
	

static func load_fatigue_die():
	
	var saved_dice:SavedDice = SafeResourceLoader.load("user://savedice.tres") as SavedDice
	
	if saved_dice == null:
		print("SaveDice.tres file was unsafe!")
		return
	
	# color
	d_text_color_fatigue = saved_dice.die_text_color_fatigue
	d_body_color_fatigue = saved_dice.die_body_color_fatigue
	
	# style
	d_style_fatigue = saved_dice.die_style_fatigue
	
	# option
	d_vis_fatigue = saved_dice.die_vis_fatigue


static func load_default_fatigue_die():
	
	# color
	d_text_color_fatigue = Color.ANTIQUE_WHITE
	d_body_color_fatigue = Color.DIM_GRAY
	
	# style
	d_style_fatigue = "die_1"
	
	# option
	d_vis_fatigue = true


func _save_dice_preferences():
	var saved_dice:SavedDice = SavedDice.new()
	
	#colors
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
	saved_dice.die_tray_felt_color = d_tray_felt_color
	saved_dice.die_text_color_fatigue = d_text_color_fatigue
	saved_dice.die_body_color_fatigue = d_body_color_fatigue
	
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
	saved_dice.die_style_fatigue = d_style_fatigue
	
	#option
	saved_dice.die_vis_fatigue = d_vis_fatigue
	
	ResourceSaver.save(saved_dice, "user://savedice.tres")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://DiceTrayData/dice_options_menu.tscn")

#region ------- Color Menu Signals --------------------------------------------
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

func _on_color_picker_button_tray_felt_color_changed(color):
	d_tray_felt_color = color
	
#endregion

#region -------- Style Menu Signals -----------------------------------
func _on_option_button_x_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_x = die_style


func _on_option_button_y_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_y = die_style


func _on_option_button_d_66_primary_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_d66_prime = die_style


func _on_option_button_d_66_secondary_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_d66_secondary = die_style


func _on_option_button_single_primary_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_single_primary = die_style


func _on_option_button_single_secondary_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_single_secondary = die_style
	

func _on_option_button_exit_qty_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_exit_qty = die_style


func _on_option_button_exit_direction_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_exit_direction = die_style


func _on_option_button_lock_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_exit_lock = die_style


func _on_option_button_d_3_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_num"
		1: die_style = "die_dot"
		2: die_style = "die_let"
	d_style_d3 = die_style
#endregion



#region -----------  Fatigue Menu Signals ---------------------------------------
func _on_fatigue_die_visiblity_item_selected(index):
	match index:
		0: d_vis_fatigue = false
		1: d_vis_fatigue = true

func _on_color_picker_button_fatigue_text_color_changed(color):
	%LabelFatigue.label_settings.font_color = color
	d_text_color_fatigue = color


func _on_color_picker_button_fatigue_color_changed(color):
	d_body_color_fatigue = color


func _on_d_style_fatigue_item_selected(index):
	var die_style : String
	match index:
		0: die_style = "die_1"
		1: die_style = "die_2"
		2: die_style = "die_3"
	d_style_fatigue = die_style

#endregion
