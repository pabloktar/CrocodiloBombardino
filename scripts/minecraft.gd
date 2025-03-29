extends CanvasLayer

@export var activate_key1 = KEY_1
@export var activate_key2 = KEY_2


signal collect_xp;
signal pause;
signal unpause;
signal lvl_up(mode: String);

var lvl_up_options: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MinecraftHud.hide()
	$TetrisHud.hide()
	lvl_up_options = $Lvl_up.get_child_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(activate_key1)):
		$MinecraftHud.visible = !$MinecraftHud.visible
	if(Input.is_key_pressed(activate_key2)):
		$TetrisHud.visible = !$TetrisHud.visible
	


func _on_character_collect_xp() -> void:
	collect_xp.emit()


func _on_exp_lvl_up() -> void:
	if(lvl_up_options != 0):
		lvl_up_options -= 1;
		pause.emit()
		$Lvl_up.show();
		
func wrap_lvl_up():
	$Lvl_up.hide();
	unpause.emit();

func _on_choice_minecraft_pressed() -> void:
	$MinecraftHud.show();
	$Lvl_up/ChoiceMinecraft.hide();
	lvl_up.emit("minecraft");
	wrap_lvl_up();
	
func _on_choice_tetris_pressed() -> void:
	$TetrisHud.show();
	$Lvl_up/ChoiceTetris.hide();
	lvl_up.emit("tetris");
	wrap_lvl_up();
