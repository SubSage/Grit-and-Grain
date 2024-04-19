extends UNIT

@export var is_kill_wall = false

func _ready() -> void:
	if is_kill_wall:
		add_to_group("kill_wall")
		$NounHexagon1117056.self_modulate = Color.BLACK
		$NounHexagon1117056/NounHexagon1117054.self_modulate = Color.CRIMSON

func die():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, .3)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .3)
	tween.set_parallel(false)
	tween.tween_callback(self.queue_free)
