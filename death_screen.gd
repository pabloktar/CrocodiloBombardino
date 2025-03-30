extends Node

var game_resource = "res://scenes/game.tscn"
var victory_resource = "res://victory.tscn"
var game: Node
var victory: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = load(game_resource).instantiate();
	victory = load(victory_resource).instantiate();
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().root.add_child(game)
	get_tree().paused = false
	print("hi hi  hi")
	queue_free()


func _on_restart_2_pressed() -> void:
	get_tree().root.add_child(victory)
	get_tree().paused = false
	print("hi hi  hi")
	queue_free()
