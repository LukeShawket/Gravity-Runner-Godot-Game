extends AnimatableBody2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.forced_jump()
		$AnimatedSprite2D.play("jump")


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		body.reduce_jump()

func _process(delta):
	if !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("Idle")
