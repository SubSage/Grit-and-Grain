extends Node2D

@export var health = 2





func take_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
