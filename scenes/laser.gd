extends Area2D
class_name LASER

@export var speed = 600
@export var angle_radian = deg_to_rad(-90)
@export var damage = 1
@export var duration = 12.0
@export var can_hit_multiple = false

#func _ready() -> void:
	#set_friendly()

func _process(delta: float) -> void:
	duration -= delta
	if duration <= 0:
		queue_free()
	position += speed * Vector2.from_angle(angle_radian) * delta
	rotation = angle_radian - deg_to_rad(-90)

func set_friendly():
	set_collision_mask_value(1, true)

func set_hostile():
	set_collision_mask_value(2, true)
	
func _on_area_entered(area: Area2D) -> void:
	if can_hit_multiple or not is_queued_for_deletion():
		area.owner.take_hit(damage)
	#queue_free()
