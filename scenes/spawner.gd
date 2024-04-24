extends Node2D

@export var initial_delay = 1.0
@export var spawn_delay = 1.0
@export var spawn_count = 5
@export var unit_to_spawn : PackedScene
@onready var enemy_holding_node : Node = get_tree().root.find_child("ENEMIES", true, false)
@export var turn_rate_degrees = 45


func _ready() -> void:
	$"Noun-dashed-square-230519-ffffff".self_modulate.a = 0.0
	
	$spawn.wait_time = spawn_delay
	$initial_delay.wait_time = initial_delay
	$initial_delay.start()
	
	
func _process(delta: float) -> void:
	if $initial_delay.time_left < 3.0:
		$"Noun-dashed-square-230519-ffffff".self_modulate.a = 1 - clamp($initial_delay.time_left, 0.0, 3.0)*.3
	rotation_degrees += turn_rate_degrees * delta


func spawn() -> void:
	if spawn_count > 0:
		var unit = unit_to_spawn.instantiate()
		unit.global_position = global_position
		enemy_holding_node.add_child(unit)
		spawn_count -= 1
	else:
		die()


func die():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, .3)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .3)
	tween.set_parallel(false)
	tween.tween_callback(self.queue_free)


func delay_start() -> void:
	$spawn.start()
