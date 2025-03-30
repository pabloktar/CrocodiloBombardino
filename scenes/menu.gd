extends Node

var game = preload("res://scenes/game.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().root.add_child(game)

	queue_free()
