extends Node


var astar = AStar2D.new()
@export var walkable_tilemap_layers: Array[TileMapLayer] = []


func _ready():
	_setup_astar()


func _process(delta):
	pass


func _setup_astar():
	var idx = 0
	for layer in walkable_tilemap_layers:
		for tile_position in layer.get_used_cells():
			astar.add_point(idx, tile_position)
			idx += 1
	
	var neighbours = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	for i in range(0, astar.get_point_count()):
		var point = astar.get_point_position(i)
		for n in neighbours:
			var cl_p = astar.get_closest_point(point + n)
			if i != cl_p:
				astar.connect_points(i, cl_p)


func get_astar_path(start: Vector2, end: Vector2):
	var layer = walkable_tilemap_layers[0]
	var s = astar.get_closest_point(layer.local_to_map(start))
	var e = astar.get_closest_point(layer.local_to_map(end))
	
	var path_position = []
	
	for point in astar.get_point_path(s, e):
		path_position.append(layer.map_to_local(point))
	
	return path_position
