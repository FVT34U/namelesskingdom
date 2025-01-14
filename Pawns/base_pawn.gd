extends CharacterBody2D
class_name BasePawn


@export var SPEED = 220.0

var path: Array = []
var cur_point = null
var path_idx = 0


func _physics_process(delta):
	if not path.is_empty():
		if cur_point == null:
			cur_point = _get_next_path_point()
			return
		
		var direction = global_position.direction_to(cur_point)
		velocity = direction * SPEED * delta * 10
		move_and_slide()
		_update_animation(direction.round())
	
		if global_position.round().is_equal_approx(cur_point):
			cur_point = null


func _get_next_path_point():
	if path_idx >= path.size():
		path_idx = 0
		path = []
		return null
	var value = path[path_idx]
	path_idx += 1
	return value


func _update_animation(dir: Vector2):
	pass
