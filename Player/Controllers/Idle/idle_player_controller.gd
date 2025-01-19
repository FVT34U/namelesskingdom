extends BasePlayerController
class_name IdlePlayerController


func _ready():
	print("IdlePlayerController was initialized")


func _move_pawns():
	var i = 0
	for pawn in pawns:
		pawn.set_path(path.slice(0, len(path) - i))
		i += 1
