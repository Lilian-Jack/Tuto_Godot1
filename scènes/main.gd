extends Node2D

@export var mob_scene : PackedScene
var score 

func _ready():
	new_game()


func game_over() -> void:
	$scoretimer.stop()
	$mobtimer.stop()
	
func new_game():
	score = 0
	$player.start($startposition.position)
	$starttimer.start()


func _on_starttimer_timeout():
	$mobtimer.start()
	$scoretimer.start()


func _on_scoretimer_timeout() -> void:
	score += 1


func _on_mobtimer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("mobpath/mobspawnlocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI/2
	
	mob.position = mob_spawn_location.position;
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
