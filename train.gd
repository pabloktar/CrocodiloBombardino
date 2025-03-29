extends Area2D

var speed = 1500;
var backroll = 500;
var is_first = true;
var car: int;
signal die;

@export var coinScene: PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(is_first):
		position -= Vector2.UP.rotated(rotation) * backroll;
	else:
		position -= Vector2.UP.rotated(rotation) * ($CollisionShape2D.shape.size.y + 10);
	$nextcar.wait_time = 1.0 / speed * (backroll);
	$nextcar.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.UP.rotated(rotation) * speed * delta;


func _on_timer_timeout() -> void:
	die.emit();
	queue_free();


func _on_area_entered(area: Area2D) -> void:
	area.die()
	
func _on_coin_timer_timeout() -> void:
	if(car != 1):
		return
	var coin = coinScene.instantiate()
	coin.global_position = self.global_position;
	get_parent().add_child(coin);


func _on_nextcar_timeout() -> void:
	if(car == 1):
		return;
	var trainScene = preload("res://train.tscn");
	var train = trainScene.instantiate();
	train.global_position = self.position;
	train.rotation = self.rotation;
	train.die.connect(_on_train_die);
	train.car = self.car - 1;
	train.is_first = false;
	get_parent().add_child(train);
	
func _on_train_die():
	die.emit();
	queue_free();
	
