extends Node

@export var mob_scene: PackedScene

var score 


# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("准备开始")



func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	pass # Replace with function body.


func _on_mob_timer_timeout():
	# 创建
	var mob =mob_scene.instantiate()
	
	# 选着随机路径
	var mob_spawn_localtion = $MobPath/MobSpawnLocation
	mob_spawn_localtion.progress_ratio = randf()
	
	var direction = mob_spawn_localtion.rotation + PI / 2
	
	mob.position = mob_spawn_localtion.position
	
	direction += randf_range(-PI / 4 , PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	
	pass # Replace with function body.
