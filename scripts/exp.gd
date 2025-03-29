extends Node2D

@export var max_exp = 5
var current_exp = 0
signal lvl_up;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ratio = 1.0 * current_exp / max_exp
	var xpbar_len = abs($"Full bar".points[1].x - $"Full bar".points[0].x);
	$"Current bar".points[1].x = ($"Current bar".points[0].x + xpbar_len * ratio)

func _on_gain_exp(exp: int) -> void:
	current_exp = min(exp + current_exp, max_exp) 
	if(current_exp == max_exp):
		lvl_up.emit();
		max_exp *= 2;
		current_exp = 0;


func _on_timer_timeout() -> void:
	_on_gain_exp(1)


func _on_huds_collect_xp() -> void:
	_on_gain_exp(1)
