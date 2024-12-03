extends Area2D


@onready var cloud1 = $"1"
@onready var cloud2 = $"2"
@onready var cloud3 = $"3"
var random_cloud_value = randi_range(0, 2)
var random_cloud_speed = randf_range(-30, -100)
# Called when the node enters the scene tree for the first time.
func _ready():
	if random_cloud_value == 0:
		cloud1.visible = true
		cloud2.visible = false
		cloud3.visible = false
	if random_cloud_value == 1:
		cloud1.visible = false
		cloud2.visible = true
		cloud3.visible = false
	if random_cloud_value == 2:
		cloud1.visible = false
		cloud2.visible = false
		cloud3.visible = true
		
	var layer_randomns = randi_range(0, 1)
	if layer_randomns == 0:
		visibility_layer = -101


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += random_cloud_speed * delta
	
