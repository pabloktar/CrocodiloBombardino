extends CanvasLayer

@export var activate_key1 = KEY_1
@export var activate_key2 = KEY_2

var deathscreen = preload("res://death_screen.tscn").instantiate()

signal collect_xp;
signal pause;
signal unpause;
signal lvl_up(mode: String);
signal restart;

var lvl_up_options: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MinecraftHud.hide()
	$SubwayHud.hide()
	lvl_up_options = 5;#$Lvl_up.get_child_count() - 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(activate_key1)):
		collect_xp.emit(100);



func _on_character_collect_xp() -> void:
	collect_xp.emit()


func _on_exp_lvl_up() -> void:
	if(lvl_up_options != 0):
		lvl_up_options -= 1;
		pause.emit()
		$Lvl_up.show();
		
func wrap_lvl_up():
	$Lvl_up.hide();
	$Lvl_up_Minecraft.hide();
	$Lvl_up_Subway.hide();
	unpause.emit();

func _on_choice_minecraft_pressed() -> void:
	$Lvl_up.hide();
	$Lvl_up_Minecraft.show()
	
func _on_choice_tetris_pressed() -> void:
	activate_tetris();
	wrap_lvl_up();



func activate_tetris():
	$TetrisHud.show();
	$Lvl_up/ChoiceTetris.hide();
	lvl_up.emit("tetris");

func activate_minecraft():
	$MinecraftHud.show();

func activate_subway():
	$SubwayHud.show();
	$Lvl_up_Subway.hide();
	lvl_up.emit("subway");

func _on_choice_skip_pressed() -> void:
	wrap_lvl_up();



func _on_choice_subway_pressed() -> void:
	$Lvl_up.hide();
	$Lvl_up_Subway.show();
	


func _on_character_collect_coin() -> void:
	$SubwayHud/coins.coins += 1;


func _on_choice_back_Subway_pressed() -> void:
	$Lvl_up_Subway.hide();
	$Lvl_up.show()


func _on_choice_get_train_pressed() -> void:
	activate_subway();
	$Lvl_up_Subway/ChoiceGetTrain.hide()
	$Lvl_up_Subway/ChoiceUpgradeTrain.show();
	wrap_lvl_up();


func _on_choice_upgrade_train_pressed() -> void:
	lvl_up.emit("subway");
	$Lvl_up_Subway.hide();
	wrap_lvl_up();
	
func _on_character_death():
	print("oh no")
	get_tree().root.add_child(deathscreen)
	get_parent().queue_free()
	


func _on_choice_get_pickaxe_pressed() -> void:
	activate_minecraft()
	lvl_up.emit("minecraft");
	
	$Lvl_up_Minecraft/ChoiceGetPickaxe.hide()
	$Lvl_up_Minecraft/ChoiceUpgradePickaxe.show();
	
	wrap_lvl_up();


func _on_choice_upgrade_pickaxe_pressed() -> void:
	lvl_up.emit("pickaxe")
	wrap_lvl_up();


func _on_choice_get_armor_pressed() -> void:
	activate_minecraft();
	lvl_up.emit("helmet");
	wrap_lvl_up();


func _on_choice_upgrade_armor_pressed() -> void:
	lvl_up.emit("helmet");
	wrap_lvl_up();


func _on_character_nuke_error(time: float) -> void:
	$"Nuke cooldown".text = "Nuke cooldown: " +  str (int(time * 100) / 100.0 );
	$"Nuke cooldown".show();
	$"Nuke cooldown/error".start()
	


func _on_error_timeout() -> void:
	$"Nuke cooldown".hide();


func _on_inst_timer_timeout() -> void:
	$Instructions.hide();
