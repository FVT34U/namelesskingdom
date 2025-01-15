extends Node2D
class_name PlayerController


@export var pawns: Array[BasePawn] = []

@onready var world = get_parent()
@onready var astar_pathfinding: AStarPathfinding = world.get_node("AStarPathfinding")
@onready var camera = $Camera2D

@onready var active_pawn: BasePawn = pawns[0]

enum states {
	WALKING,
	BATTLE,
}
var state = states.WALKING

var path: Array = []
var cur_point = null
var path_idx = 0


func _input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_click"):
		var new_path = astar_pathfinding\
		.get_astar_path(global_position, camera.get_global_mouse_position())
		
		path = new_path
		# control how to move pawns by state


func _move():
	match state:
		states.WALKING: _move_pawns()
		states.BATTLE: _move_pawn()


func _move_pawns():
	pass


func _move_pawn():
	pass
