extends UNIT
class_name PLAYER

@export var turn_rate = 20
var dead = false
var maxhealth = 20.0
var mode = 0
var bombcount = 2

var screen_shake = 0
var screen_shake_decay = 4.0
@onready var BOMB_CLASS = preload("res://scenes/bomb.tscn")
@onready var bullet_holding_node : Node = get_tree().root.find_child("BULLETS", true, false)

func _ready() -> void:
	#Engine.time_scale = 10
	$TextureProgressBar.max_value = maxhealth
	$TextureProgressBar.value = health
	
func _process(delta: float) -> void:
	if dead:
		return
	screen_shake -= screen_shake_decay * delta
	screen_shake = clamp(screen_shake, 0.0, 4.0)
	
	if screen_shake > 0.1:
		$Camera2D.offset = Vector2(randf_range(-6, 6) * screen_shake,randf_range(-6, 6) * screen_shake) 
		$Camera2D.zoom = Vector2.ONE + Vector2.ONE * screen_shake / 40.0
		
	if $Area2D.get_overlapping_areas().size() > 0:
		take_hit(delta)
	var movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += movement_input * speed * delta
	if movement_input.length() > .1:
		rotation = lerp_angle(rotation, movement_input.angle() - deg_to_rad(-90), turn_rate * delta)
	
	if Input.is_action_just_pressed("BOMB") and bombcount > 0:
		if bombcount == 2:
			$NounCircle1117027.visible = false
		elif bombcount == 1:
			$NounCircle1117026.visible = false
		bombcount -= 1
		var bomb = BOMB_CLASS.instantiate()
		bomb.set_friendly()
		bomb.global_position = global_position
		bullet_holding_node.add_child(bomb)
		
	if Input.is_action_just_pressed("next_mode"):
		for gun in $WEAPONS.get_child(mode).get_children():
			gun.stop()
			gun.enabled = false
			
		$WEAPONS.get_child(mode).visible = false
		mode += 1
		mode = wrap(mode, 0, $WEAPONS.get_child_count())
		$WEAPONS.get_child(mode).visible = true
		
		for gun in $WEAPONS.get_child(mode).get_children():
			gun.enabled = true
	
	$TextureProgressBar.value = health

func _on_area_2d_area_entered(area: Area2D) -> void:
	var dmg = 1
	if area.owner:
		if area.owner.is_in_group("kill_wall"):
			die()
		take_hit(1)

func take_hit(damage):
	screen_shake += damage
	health -= damage
	if health <= 0:
		die()

func die():
	for gun in $WEAPONS.get_child(mode).get_children():
			gun.stop()
			gun.enabled = false
	dead = true
	visible = false
