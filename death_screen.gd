extends Node

var game_resource = "res://scenes/game.tscn"
var game: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = load(game_resource).instantiate();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().root.add_child(game)
	get_tree().paused = false
	print("hi hi  hi")
	queue_free()
