extends AnimatableBody2D

var flip_time = 4.0
var start_pose
var isKiller = false

func _ready():
	start_pose = position

func _physics_process(delta):
	flip_time -= delta
	if flip_time <= 3:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 2.7:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y-1), 0.5)
	if flip_time <= 2.5:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 2.3:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y-1), 0.5)
	if flip_time <= 2.2:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 2:
		position.y = start_pose.y-1
		transform.y.y = -1
		
	
	if flip_time <= 1:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 0.7:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y-1), 0.5)
	if flip_time <= 0.5:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 0.3:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y-1), 0.5)
	if flip_time <= 0.2:
		position = position.move_toward(Vector2(start_pose.x, start_pose.y+1), 0.5)
	if flip_time <= 0:
		position.y = start_pose.y-1
		transform.y.y = 1
		flip_time = 4.0


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.call_deferred_thread_group("player_death")
		$Sprite2D.texture = load("res://Assets/bloodyrp1.png")
		isKiller = true
		$AudioStreamPlayer2D.play()


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("body_parts"):
		if !isKiller:
			$Sprite2D.texture = load("res://Assets/bloodyrp2.png")
