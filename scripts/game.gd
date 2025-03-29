extends Node2D

var is_paused: bool;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;


func _on_huds_pause() -> void:
	get_tree().paused = true;


func _on_huds_unpause() -> void:
	get_tree().paused = false;
