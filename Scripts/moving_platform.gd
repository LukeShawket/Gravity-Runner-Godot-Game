extends StaticBody2D

@export var move_speed = 100.0

var start_pose
var end_pose
var move_left = true
var move_right = false
var distance
var start_end_dis
# Called when the node enters the scene tree for the first time.
func _ready():
	start_pose = position
	end_pose = $EndPose.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	distance = position.distance_to(end_pose)
	start_end_dis = end_pose.distance_to(start_pose)
	if distance <= 10:
		move_right = true
		move_left = false
	elif distance >= start_end_dis - 10:
		move_left = true
		move_right = false
	
func _physics_process(delta):	
	if move_left:
		position = position.move_toward(end_pose, move_speed * delta)
		#position = lerp(position,end_pose, 0.02)
	else:
		pass
	if move_right:
		position = position.move_toward(start_pose, move_speed * delta)
		#position = lerp(position,start_pose, 0.02)
	else:
		pass
		


func _on_area_2d_body_entered(body):
	if body.is_in_group("body_parts"):
		$AnimatedSprite2D.play("bloody")
