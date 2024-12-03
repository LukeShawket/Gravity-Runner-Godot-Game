extends Node2D

@onready var game_cam : Camera2D = $Camera2D

var a = 4.0
	


func spawn_clouds():
	var instance = load("res://Scenes/clouds.tscn")
	var cloud = instance.instantiate()
	cloud.position = Vector2(game_cam.position.x + 500, game_cam.position.y - randf_range(100, 150))
	add_child(cloud)
