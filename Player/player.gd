extends CharacterBody2D


@export var SPEED = 220.0

@onready var world = get_parent()
@onready var camera = $Camera2D

var path: Array = []
var cur_point = null
var path_idx = 0


func _physics_process(delta):
	#var direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#if direction:
		#velocity = direction * SPEED * delta * 10
	#
		#move_and_slide()
	#
	#_update_animation(direction)
	
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


func _input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_click"):
		var new_path = world.get_node("AStarPathfinding")\
		.get_astar_path(global_position, camera.get_global_mouse_position())
		
		path = new_path


func _get_next_path_point():
	if path_idx >= path.size():
		path_idx = 0
		path = []
		return null
	var value = path[path_idx]
	path_idx += 1
	return value


func _update_animation(dir: Vector2):
	match dir:
		Vector2.UP: $AnimationPlayer.play("move_forward")
		Vector2.DOWN: $AnimationPlayer.play("move_backward")
		Vector2.LEFT: $AnimationPlayer.play("move_left")
		Vector2.RIGHT: $AnimationPlayer.play("move_right")
		_ :
			if dir.x > 0 and dir.y > 0:
				$AnimationPlayer.play("move_backward")
			elif dir.x < 0 and dir.y > 0:
				$AnimationPlayer.play("move_backward")
			elif dir.x < 0 and dir.y < 0:
				$AnimationPlayer.play("move_forward")
			elif dir.x > 0 and dir.y < 0:
				$AnimationPlayer.play("move_forward")
			else:
				$AnimationPlayer.play("RESET")
