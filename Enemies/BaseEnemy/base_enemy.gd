extends CharacterBody2D
class_name BaseEnemy


@export var SPEED = 220.0
@export var walking_radius = 5

@onready var world = get_parent()
@onready var astar_pathfinding: AStarPathfinding = world.get_node("AStarPathfinding")
@onready var spawn_point = global_position

var path: Array = []
var cur_point = null
var path_idx = 0

signal endpoint_reached


func _ready():
	endpoint_reached.connect(_on_endpoint_reached)
	endpoint_reached.emit()


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
		endpoint_reached.emit()
		return null
	var value = path[path_idx]
	path_idx += 1
	return value


func _update_animation(dir: Vector2):
	pass


func _on_endpoint_reached():
	await get_tree().create_timer(2).timeout
	
	var x = randi_range(spawn_point.x, spawn_point.x + walking_radius * 16) # hardcoded as fuck
	var y = randi_range(spawn_point.y, spawn_point.y + walking_radius * 16) # hardcoded as fuck
	path = astar_pathfinding.get_astar_path(global_position, Vector2(x, y))
