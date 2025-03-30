extends Area2D

signal died(position: Vector2)

var is_dead = false
var character;

var is_damaging = false;
var is_on_cooldown = false;
@export var speed = 200;
@export var damage = 10;
@export var xp_scene: PackedScene;
@export var hp = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE;
	$Bang.hide();
	character = $"../Character";
	$Tralalero.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!is_dead):
		var velocity = character.global_position - global_position
		position += velocity.normalized() * speed * delta
		if(velocity.x < 0):
			$Tralalero.scale.x = - abs($Tralalero.scale.x);
		elif (velocity.x > 0):
			$Tralalero.scale.x = abs($Tralalero.scale.x);
		if(Input.is_key_pressed(KEY_SPACE)):
			if(character.nuke_radius >= velocity.length() and !character.nuke_cooldown):
				hp -= 1;
				if(hp == 0):
					die()
	
		
	if(is_damaging and !is_on_cooldown):
		character.take_damage(damage);
		cooldown()
		
	

func die():
	if(is_dead):
		return;
	is_dead = true;
	$Tralalero.hide();
	$CollisionShape2D.queue_free()
	$Bang.show();
	$DeathTimer.start();
	
func _on_death_timer_timeout() -> void:
	spawn_xp();
	queue_free();

func spawn_xp():
	var xp_orb = xp_scene.instantiate()
	xp_orb.global_position = global_position;
	get_parent().add_child(xp_orb)
	
func cooldown():
	$CooldownTimer.start();
	is_on_cooldown = true;

func _on_cooldown_timer_timeout() -> void:
	is_on_cooldown = false


func _on_area_entered(area: Area2D) -> void:
	is_damaging = true;


func _on_area_exited(area: Area2D) -> void:
	is_damaging = false;
