extends Area2D


var isKilled = false


func _on_body_entered(body):
	if body.name == "Player":
		body.call_deferred_thread_group("player_death")
		$Sprite2D.texture = load("res://Assets/iron_spikes/iron_spikes2.png")
		isKilled = true
		$AudioStreamPlayer2D.play()

func _on_area_2d_body_entered(body):
	if body.is_in_group("body_parts"):
		if !isKilled:
			$Sprite2D.texture = load("res://Assets/iron_spikes/iron_spikes3.png")
