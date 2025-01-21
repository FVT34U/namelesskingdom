extends Node
class_name AStarPathfinding

var astar = AStar2D.new()
@export var walkable_tilemap_layer: TileMapLayer = null


func _ready():
	_setup_astar()


func _process(delta):
	pass


func _setup_astar():
	var idx = 0
	for tile_position in walkable_tilemap_layer.get_used_cells():
		astar.add_point(idx, tile_position)
		idx += 1
	
	var neighbours = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	for i in range(0, astar.get_point_count()):
		var point = astar.get_point_position(i)
		for n in neighbours:
			var cl_p = astar.get_closest_point(point + n)
			if i != cl_p:
				astar.connect_points(i, cl_p)


func get_astar_path(start: Vector2, end: Vector2) -> Array[Vector2]:
	var s = astar.get_closest_point(walkable_tilemap_layer.local_to_map(start))
	var e = astar.get_closest_point(walkable_tilemap_layer.local_to_map(end))
	
	var path_position: Array[Vector2] = []
	
	for point in astar.get_point_path(s, e):
		path_position.append(walkable_tilemap_layer.map_to_local(point))
	
	return path_position
