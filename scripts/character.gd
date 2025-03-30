extends Area2D


@export var speed = 400
signal collect_xp;
signal collect_coin;
signal death;

var max_hp = 100
var current_hp = 100

# minecraft variables
const CLOCKWISE = 1;
const COUNTERCLOCKWISE = -1;
var minecraft_mode: bool;
var pickaxe_angle_speed = PI/3;
var pickaxe_direction = CLOCKWISE;
var pickaxe_sprite_counter = 0;
var pickaxe_sprites = [
	"res://assets/pickaxes/Wooden_Pickaxe_JE3_BE3.webp",
	"res://assets/pickaxes/Stone_Pickaxe_JE2_BE2 (1).webp",
	"res://assets/pickaxes/Iron_Pickaxe_JE3_BE2.webp",
	"res://assets/pickaxes/Diamond_Pickaxe_JE3_BE3.webp",
	"res://assets/pickaxes/Netherite_Pickaxe_JE3.webp"
]
var helmet_sprite_counter = -1;
var helmet_sprites = [
	"res://assets/helmets/leather_helmet.png",
	"res://assets/helmets/iron_helmet.png",
	"res://assets/helmets/diamond_helmet.png",
	"res://assets/helmets/netherite_helmet.png",
]

const mc_music = "sweden"
const subway_music = "subway"

var audio_list = {
	"sweden": "res://assets/audio/c418-sweden-minecraft-volume-alpha.ogg",
	"subway":"res://assets/audio/Subway-Surfers-Theme-Sound-Effect.mp3",
	"bombardino":"res://assets/audio/Bombardino Crocodilo.mp3",
	"scary":"res://assets/audio/Scary Tiktok Music - Meme Effect Sound.mp3"
}

var current_track = "scary"

var damage_multiplier = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	minecraft_mode = false;
	$Pickaxe.monitoring = false;
	$Pickaxe.hide();
	$Sprite/helmet.hide()
	play_audio("bombardino");


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
		$Sprite.scale.x = - abs($Sprite.scale.x);
	elif (velocity.x > 0):
		$Sprite.scale.x = abs($Sprite.scale.x);
	
	position += velocity * delta;
	
	if(minecraft_mode):
		swing_pickaxe(delta);
	
	render_hp_bar();
	
	if(current_hp == 0):
		death.emit()
	
func render_hp_bar():
	var ratio = 1.0 * current_hp / max_hp
	var full_bar = $"HP/Full bar"
	var hpbar_len = abs(full_bar.points[1].x - full_bar.points[0].x);
	var current_bar = $"HP/Full bar/Current bar"
	current_bar.points[1].x = (current_bar.points[0].x + hpbar_len * ratio)
	
func swing_pickaxe(delta: float):
	$Pickaxe.rotate(pickaxe_angle_speed * pickaxe_direction * delta);
	
# can only interact with xp
func _on_area_entered(area: Area2D) -> void:
	
	if(area.is_in_group("coin")):
		area.queue_free();
		collect_coin.emit();
	else:
		area.queue_free();
		collect_xp.emit();


func _on_huds_lvl_up(mode: String) -> void:
	if(mode == "minecraft"):
		
		minecraft_mode = true;
		$Pickaxe.monitoring = true;
		$Pickaxe.show();
		current_track = mc_music;

	if(mode == "pickaxe"):
		pickaxe_angle_speed *= 1.5;
		pickaxe_sprite_counter += 1;
		var texture = load(pickaxe_sprites[pickaxe_sprite_counter])
		$Pickaxe/Sprite2D.texture = texture;
		current_track = mc_music;
	if(mode == "helmet"):
		$Sprite/helmet.show();
		helmet_sprite_counter += 1;
		var texture = load(helmet_sprites[helmet_sprite_counter]);
		$Sprite/helmet.texture = texture;
		damage_multiplier -= 0.1;
		current_track = mc_music
	if(mode == "tetris"):
		$Tetris.set_process(true);
	if(mode == "subway"):
		current_track = subway_music;
	
	play_audio(current_track)

func _on_pickaxe_area_entered(area: Area2D) -> void:
	pickaxe_direction = -pickaxe_direction;
	area.die();
	
func take_damage(dmg: int):
	current_hp = max(0, current_hp - dmg*damage_multiplier);
	

func play_audio(name: String):
	var audio = load(audio_list[name])
	$AudioPlayer.stream = audio;
	
	if(name == "subway"):
		$AudioPlayer.volume_db = -10
	else:
		$AudioPlayer.volume_db = 0
	$AudioPlayer.play()

func _on_audio_player_finished() -> void:
	play_audio(current_track)
