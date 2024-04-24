extends Node2D

@onready var UI_NODE = get_tree().root.get_node("UI")
var showmenu = false
var time = 0.0
var won = false

func _ready() -> void:
	UI_NODE.test2()
	UI_NODE.hided()
	

func _process(delta: float) -> void:
	time += delta
	if Input.is_action_just_pressed("restart_level"):
		#UI_NODE.test()
		#showmenu = false
		UI_NODE.start()
		get_tree().reload_current_scene()
		
	if $PLAYER.dead and not showmenu  and not won:
		showmenu = true
		UI_NODE.test()
		for spawner in $SPAWNERS.get_children():
			spawner.queue_free()
		for enemy in $ENEMIES.get_children():
			enemy.queue_free()
	
	if showmenu and not won:
		UI_NODE.gameover()
	
	if not $PLAYER.dead and time > 120.0 and $ENEMIES.get_child_count() <= 0 and not won:
		UI_NODE.all_enemies_killed()
		won = true
		pass
