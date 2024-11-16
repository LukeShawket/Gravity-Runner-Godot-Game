extends Control

var game_time = 0.0

@onready var game_tree = $GAME

@export var level_name: String 
var levels_folder = "res://Scenes/Levels/"
@onready var label = $HUD/Label
var text : String

@onready var main_menu = $MainMenu
@onready var HUD = $HUD

var isPlayerDead = false
var isEnded = false

func _ready():
	HUD.visible = false
	main_menu.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#text = "FPS: " + str(Engine.get_frames_per_second())
	#label.text = str(text)
	
	show_replay()


func show_replay():
	if isPlayerDead:
		await get_tree().create_timer(10).timeout
		isEnded = true
		get_tree().reload_current_scene()
	
func load_next_level():
	var full_path = levels_folder + level_name + ".tscn"
	var next_level = load(full_path)
	var instance = next_level.instantiate()
	game_tree.add_child(instance)
	


func _on_play_pressed():
	main_menu.visible = false
	HUD.visible = true
	load_next_level()


func _on_quit_pressed():
	get_tree().quit()
	

func _on_check_button_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
