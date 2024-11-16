extends CharacterBody2D


const SPEED = 200.0
var JUMP_VELOCITY = -300.0
var animated


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gravity_changed = false

var scene_cam

var body_path = preload("res://Scenes/body_parts.tscn")

var body_instance

var is_right_pressed = false
var is_left_pressed = false

@onready var height_ray : RayCast2D =  $RayCast2D


func _ready():
	#velocity.x = SPEED
	animated = $AnimatedSprite2D

func _process(delta):
	# jump too heigh
	calheight(delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated.play("Jumping")
		$GPUParticles2D.emitting = false
	if is_on_floor():
		gravity_changed = false
		if velocity.x != 0:
			animated.play("Running")
			$GPUParticles2D.emitting = true
		else:
			animated.play("Idle")
			$GPUParticles2D.emitting = false
		if gravity < 0:
			velocity.y += gravity * delta
	change_gravity()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		$GPUParticles2D.emitting = false
		if is_on_floor():
			if gravity > 0:
				velocity.y = JUMP_VELOCITY
			if gravity < 0:
				velocity.y = -JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			if gravity > 0:
				transform.x.x = 1
				transform.y.y = 1
			if gravity < 0:
				transform.x.x = 1
				transform.y.y = -1
		else:
			if gravity > 0:
				transform.x.x = -1
				transform.y.y = 1
			if gravity < 0:
				transform.x.x = -1
				transform.y.y = -1
	else:
		#$AudioStreamPlayer2D.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		pass
	move_and_slide()
	
func change_gravity():
	if Input.is_action_just_pressed("ui_up"):
		if not gravity_changed:
			gravity *= -1
			gravity_changed = true
	if gravity > 0:
		transform.y.y = 1
		self.up_direction = Vector2(0, -1)
	else:
		transform.y.y = -1
		self.up_direction = Vector2(0, 1)
		
func forced_jump():
	JUMP_VELOCITY = -400.0
	if gravity > 0:
		velocity.y = JUMP_VELOCITY
	if gravity < 0:
		velocity.y = -JUMP_VELOCITY
func reduce_jump():
	JUMP_VELOCITY = -300.0
	
func player_death():
	body_instance = body_path.instantiate()
	body_instance.position = position
	get_tree().root.add_child(body_instance)
	if gravity < 0:
		for i in 6:
			body_instance.get_child(i + 1).is_gravity_changed = true
	var blood = body_instance.get_child(0)
	blood.emitting = true
	var main = get_tree().root.get_node("Main")
	main.isPlayerDead = true
	queue_free()
	
func calheight(frame):
	pass
		
