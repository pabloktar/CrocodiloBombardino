extends Path2D

@export var enemyScene1: PackedScene;
@export var enemyScene2: PackedScene;
@export var bossScene: PackedScene;

var enemyList;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyList = [enemyScene1, enemyScene2];


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var character = $"../Character"
	global_position = character.global_position


func _on_spawn_timer_timeout() -> void:
	var enemyScene = enemyList[randi_range(0, len(enemyList) - 1)];
	spawn(enemyScene)
	
func _on_boss_timer_timeout() -> void:
	spawn(bossScene);

func spawn(enemyScene: PackedScene):
	var enemy = enemyScene.instantiate()
	
	var enemy_spawn_location = $PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.global_position = enemy_spawn_location.global_position
	enemy.scale *= 0.8
	get_parent().add_child(enemy);
