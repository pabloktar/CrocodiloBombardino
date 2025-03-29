extends Path2D

@export var enemyScene: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var character = $"../Character"
	global_position = character.global_position


func _on_spawn_timer_timeout() -> void:
	var enemy = enemyScene.instantiate()
	
	var enemy_spawn_location = $PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.global_position = enemy_spawn_location.global_position
	
	get_parent().add_child(enemy);
	
