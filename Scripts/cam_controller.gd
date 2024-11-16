extends Camera2D

@export var _x = 0.0
@export var _y = 0.0
@export var smoothing_weight : float = 0.2
var player
var follow_pose

func _ready():
	player = $"../Player"

func _process(delta):
	if player != null:
		follow_pose = Vector2(player.position.x + _x, player.position.y - _y)
		position = lerp(position, follow_pose, smoothing_weight)
