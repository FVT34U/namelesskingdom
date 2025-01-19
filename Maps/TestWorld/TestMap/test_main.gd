extends Node2D


@export var debug = false

@onready var astar = %AStarPathfinding.astar


func _ready():
	z_index = 10


func _draw():
	if not debug:
		return
	
	for i in range(0, astar.get_point_count()):
		var pairs = astar.get_point_connections(i)
		for p in pairs:
			draw_line(
				%AStarPathfinding.walkable_tilemap_layer.map_to_local(astar.get_point_position(i)),
				%AStarPathfinding.walkable_tilemap_layer.map_to_local(astar.get_point_position(p)),
				Color(1, 0, 0),
				1.0
			)
