extends Area2D


@export var speed = 400
signal collect_xp;



# minecraft variables
const CLOCKWISE = 1;
const COUNTERCLOCKWISE = -1;
var minecraft_mode: bool;
var pickaxe_angle_speed = PI/2;
var pickaxe_direction = CLOCKWISE;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	minecraft_mode = false;
	$Pickaxe.monitoring = false;
	$Pickaxe.hide();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if(Input.is_action_pressed("move_right")):
		velocity.x += 1;
	if(Input.is_action_pressed("move_down")):
		velocity.y += 1;
	if(Input.is_action_pressed("move_left")):
		velocity.x -= 1;
	if(Input.is_action_pressed("move_up")):
		velocity.y -= 1;
	
	if(velocity.length() > 0):
		velocity = velocity.normalized() * speed;
		
	if(velocity.x < 0):
		$Sprite.flip_h = true;
	elif (velocity.x > 0):
		$Sprite.flip_h = false;
	
	position += velocity * delta;
	
	if(minecraft_mode):
		swing_pickaxe(delta);
	
	
func swing_pickaxe(delta: float):
	$Pickaxe.rotate(pickaxe_angle_speed * pickaxe_direction * delta);
	
# can only interact with xp
func _on_area_entered(area: Area2D) -> void:
	area.queue_free();
	collect_xp.emit();


func _on_huds_lvl_up(mode: String) -> void:
	if(mode == "minecraft"):
		minecraft_mode = true;
		$Pickaxe.monitoring = true;
		$Pickaxe.show();


func _on_pickaxe_area_entered(area: Area2D) -> void:
	pickaxe_direction = -pickaxe_direction;
	area.die();
	
