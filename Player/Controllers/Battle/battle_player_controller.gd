extends BasePlayerController
class_name BattlePlayerController


func _ready():
	print("BattlePlayerController was initialized")


func _move_pawns():
	active_pawn.set_path(path)
