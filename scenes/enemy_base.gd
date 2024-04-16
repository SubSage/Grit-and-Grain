extends Node2D
class_name UNIT

@export var health = 2
@onready var player_node : Node = get_tree().root.find_child("PLAYER", true, false)


func take_hit(damage):
	health -= damage
	if health <= 0:
		die()
		
func die():
	queue_free()
