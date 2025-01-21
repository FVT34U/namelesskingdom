extends Node2D
class_name BasePlayerController


@export var pawns: Array[BasePawn] = []

@onready var world = get_parent()
@onready var astar_pathfinding: AStarPathfinding = world.get_node("AStarPathfinding")
@onready var camera = $Camera2D

@onready var active_pawn: BasePawn = pawns[0]

var path: Array[Vector2] = []

var prev_position = Vector2(0, 0)


func _physics_process(delta):
	if prev_position != active_pawn.global_position:
		global_position = active_pawn.global_position
		prev_position = global_position


func _unhandled_input(event):
	if Input.is_action_just_pressed("left_click"):
		var new_path = astar_pathfinding.get_astar_path(
			active_pawn.global_position,
			camera.get_global_mouse_position(),
		)
		
		path = new_path
		_move_pawns()

func _move_pawns():
	pass
