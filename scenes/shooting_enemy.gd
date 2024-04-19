extends UNIT

@export var move_to_player_proximity = 250
@export var fire_at_player_proximity = 300
var steer = 90


func _ready() -> void:
	if randf() < .5:
		#steer = -90
		pass
	
	
func _process(delta: float) -> void:
	if global_position.distance_to(player_node.global_position) > move_to_player_proximity:
		var target_location = player_node.global_position
		if $check_ahead.get_overlapping_areas().size() > 0:
			if $check_left.get_overlapping_areas().size() > 0:
				target_location = global_position + global_position.direction_to(player_node.global_position).rotated(deg_to_rad(steer)) * global_position.distance_to(player_node.global_position)
			elif $check_left.get_overlapping_areas().size() > 0:
				target_location = global_position + global_position.direction_to(player_node.global_position).rotated(deg_to_rad(-steer)) * global_position.distance_to(player_node.global_position)
			else:
				#target_location = global_position + global_position.direction_to(player_node.global_position).rotated(deg_to_rad(randf_range(-45,45))) * global_position.distance_to(player_node.global_position) * -1
				target_location = global_position
			
		if $Area2D.get_overlapping_areas().size() > 0 and randf() < .5:
			target_location = global_position + global_position.direction_to(player_node.global_position).rotated(deg_to_rad( steer + randf_range(-45,45))) * global_position.distance_to(player_node.global_position)*-1
		
		global_position = global_position.move_toward(target_location, speed * delta * global_position.distance_to(target_location)/ 600.0)
	
	if global_position.distance_to(player_node.global_position) <= fire_at_player_proximity:
		for gun in $WEAPONS.get_children():
			gun.fire()

	look_at(player_node.global_position)
