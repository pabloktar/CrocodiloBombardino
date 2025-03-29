extends Node2D

@export var pieceScene: PackedScene;
var is_piece_falling = false;

const hight_blocks = 20;
const block_size = 24;
const block_scale = 2.5;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false);
	$ground.position.y = $PieceSpawnPath.curve.get_point_position(0).y + (hight_blocks-1) * block_size * block_scale; 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!is_piece_falling):
		is_piece_falling = true;
		drop_piece()

func drop_piece():
	var piece = pieceScene.instantiate();
	
	var spawner = $PieceSpawnPath/Spawner
	spawner.progress_ratio = randf();
	
	piece.position = spawner.position;
	piece.stop.connect(_on_piece_stop);
	
	add_child(piece);

func _on_piece_stop():
	is_piece_falling = false;
