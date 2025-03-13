extends Node2D

@export var mob_scene : PackedScene
var score 




func game_over() -> void:
	$Music.stop()
	$GameOverSound.play()
	$scoretimer.stop()
	$mobtimer.stop()
	$HUD.show_game_over()
func new_game():
	$Music.play()
	score = 0
	$player.start($startposition.position)
	$starttimer.start()
	$HUD.update_score(score)
	$HUD.show_message("GET READY!")


func _on_starttimer_timeout():
	$mobtimer.start()
	$scoretimer.start()


func _on_scoretimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_mobtimer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("mobpath/mobspawnlocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI/2
	
	mob.position = mob_spawn_location.position;
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
