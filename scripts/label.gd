extends Label

var lvl = 1;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "LVL: " + str(lvl);


func _on_exp_lvl_up() -> void:
	lvl += 1;
