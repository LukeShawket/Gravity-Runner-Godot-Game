extends Area2D

@export var animating_dis = 10.0
var start_pose
var end_pose
var move_left
var move_right
var distance
var start_end_dis
func _ready():
	start_pose = position
	end_pose = Vector2(start_pose.x, start_pose.y - animating_dis)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	distance = position.distance_to(end_pose)
	start_end_dis = end_pose.distance_to(start_pose)
	if transform.x.x >= 0.4:
		move_right = false
		move_left = true
	elif transform.x.x <= -0.4:
		move_left = false
		move_right = true

func _physics_process(delta):
	if move_left:
		transform.x.x = lerp(float(transform.x.x), float(-1), 0.01)
	else:
		pass
	if move_right:
		transform.x.x = lerp(float(transform.x.x), float(1), 0.01)
	else:
		pass

func animate_object(speed):
	transform.x.x = lerp(1, -1, 0.05)

func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
