extends Node2D

var is_paused: bool;
var is_subway = false;

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


func _on_huds_lvl_up(mode: String) -> void:
	if(mode == "subway"):
		if(!is_subway):
			is_subway = true;
			$TrainSpawner/SpawnTimer.start()
		else:
			$TrainSpawner.counter += 1;
		
func restart_game():
	queue_free();
	get_tree().reload_current_scene();
