extends Node2D
class_name BasePlayerController


@export var pawns: Array[BasePawn] = []

@onready var world = get_parent()
@onready var astar_pathfinding: AStarPathfinding = world.get_node("AStarPathfinding")
@onready var camera = $Camera2D

@onready var active_pawn: BasePawn = pawns[0]

var path: Array = []


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		EventBus.battle_starts.emit()


func _input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_click"):
		var new_path = astar_pathfinding\
		.get_astar_path(global_position, camera.get_global_mouse_position())
		
		path = new_path
		_move_pawns()

func _move_pawns():
	pass
