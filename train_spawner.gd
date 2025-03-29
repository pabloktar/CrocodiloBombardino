extends Path2D

@export var trainScene: PackedScene;
var counter = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var character = $"../Character"
	global_position = character.global_position


func _on_spawn_timer_timeout() -> void:
	$SpawnTimer.stop();
	var train = trainScene.instantiate()
	
	var enemy_spawn_location = $PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	train.global_position = enemy_spawn_location.global_position
	train.rotation = ($"../Character".global_position - train.global_position).angle() + PI/2 - PI/4
	train.rotate(randf() * PI/2);
	train.die.connect(_on_train_die);
	train.car = counter;
	get_parent().add_child(train);
	
func _on_train_die():
	$SpawnTimer.start()
