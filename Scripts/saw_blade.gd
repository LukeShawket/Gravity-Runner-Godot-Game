extends Area2D
var rotate_speed = 500.0

var start_pose
var end_pose
var move_left = true
var move_right = false
var distance
var start_end_dis
var random_speed
@export var min_speed = 0.03
@export var max_speed = 0.06

var isKiller = false
# Called when the node enters the scene tree for the first time.
func _ready():
	start_pose = position
	end_pose = $EndPose.global_position
	random_speed = randf_range(min_speed, max_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.rotate(rotate_speed * delta)
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
		position = lerp(position,end_pose, random_speed)
	else:
		pass
	if move_right:
		position = lerp(position,start_pose, random_speed)
	else:
		pass


func _on_body_entered(body):
	if body.name == "Player":
		isKiller = true
		$AudioStreamPlayer2D2.play()
		body.call_deferred_thread_group("player_death")
		$AnimatedSprite2D.play("bloody")
		$GPUParticles2D.emitting = true
		change_sfx()
		await get_tree().create_timer(5).timeout
		$GPUParticles2D.emitting = false


func _on_area_2d_body_entered(body):
	if  body.is_in_group("body_parts") && !isKiller:
		$AnimatedSprite2D.play("effected")

func change_sfx():
	$AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D3.play()
	await get_tree().create_timer(0.5).timeout
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D3.stop()
		
