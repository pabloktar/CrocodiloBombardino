extends Label

var score: int;

var running = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	running = get_parent().visible;
	if(!running):
		return;
		
	score+=2;
	text = str(score);
	while(len(text) < 6):
		text = "0" + text;
	
