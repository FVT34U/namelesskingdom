extends Node2D
class_name GameState

@export var idle_player_controller: PackedScene
@export var battle_player_controller: PackedScene

@export var pawns_to_load: Array[PackedScene] = []

enum states {
	IDLE,
	BATTLE,
}
var state = states.IDLE

var player_controller: BasePlayerController


func _ready():
	EventBus.battle_starts.connect(_on_battle_starts)
	EventBus.battle_ends.connect(_on_battle_ends)
	
	player_controller = idle_player_controller.instantiate()
	get_parent().add_child.call_deferred(player_controller)
	
	var idx = 0
	for pawn in pawns_to_load:
		var p = pawn.instantiate()
		get_parent().add_child.call_deferred(p)
		p.global_position = Vector2(idx * 32, 0)
		player_controller.pawns.append(p)
		idx += 1


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		match state:
			states.IDLE: EventBus.battle_starts.emit()
			states.BATTLE: EventBus.battle_ends.emit()


func _on_battle_starts():
	print("Battle starts")
	state = states.BATTLE
	
	var pawns_copy = []
	for pawn in player_controller.pawns:
		pawns_copy.append(pawn)
	
	get_parent().remove_child.call_deferred(player_controller)
	
	player_controller = battle_player_controller.instantiate()
	for pawn in pawns_copy:
		player_controller.pawns.append(pawn)
	
	player_controller.global_position = player_controller.pawns[0].global_position
	
	get_parent().add_child.call_deferred(player_controller)


func _on_battle_ends():
	print("Battle ends")
	state = states.IDLE
	
	var pawns_copy = []
	for pawn in player_controller.pawns:
		pawns_copy.append(pawn)
	
	get_parent().remove_child.call_deferred(player_controller)
	
	player_controller = idle_player_controller.instantiate()
	for pawn in pawns_copy:
		player_controller.pawns.append(pawn)
	
	player_controller.global_position = player_controller.pawns[0].global_position
	
	get_parent().add_child.call_deferred(player_controller)
