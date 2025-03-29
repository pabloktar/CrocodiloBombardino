extends Area2D

const BLOCKSIZE = 24;

signal stop;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fall_timer_timeout() -> void:
	position += Vector2.DOWN * BLOCKSIZE * scale;
	


func _on_area_entered(area: Area2D) -> void:
	$fall_timer.stop();
	stop.emit();
	monitoring = false;
