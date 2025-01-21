extends Node2D
class_name PathDrawer


@export var path_color: Color
@export var is_drawing = true

var path: Array[Vector2] = []


func set_path_to_draw(new_path: Array[Vector2]):
	path = new_path
	queue_redraw()


func _draw():
	if not path or not is_drawing:
		return
	
	for i in range(0, len(path) - 1):
		draw_line(
			path[i],
			path[i + 1],
			path_color,
			1.0
		)
