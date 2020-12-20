extends Node

var level_1 = preload("res://Levels/level_1.tscn")

var current_level

var level_win_text = "Passed Level "
var game_win_text = "You Passed all Levels!"

var ball

var level_time = []

export (Array, String) var levels = ["res://Levels/level_2.tscn", "res://Levels/level_3.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables._reset()
	current_level = level_1.instance()
	self.add_child(current_level)
	level_time.append(OS.get_system_time_secs())

func _process(delta):
	var ball_group = get_tree().get_nodes_in_group("Ball")
	if ball_group.size() != 0:
		ball = ball_group[0]
	if PlayerVariables.current_level < 3:
		$Control.show()
		$Control/Time.text = "Time: " + str(OS.get_system_time_secs() - level_time[0]) + " Seconds"
		$Control/Swings.text = "Swings: " + str(PlayerVariables.swings)
		$Control/Coins.text = "Coins: " + str(PlayerVariables.coins)
		
		if $Control/StrengthBar.value > 66:
			$Control/StrengthBar.get("custom_styles/fg").bg_color = Color(0, 0.6, 0.1)
		elif $Control/StrengthBar.value > 33:
			$Control/StrengthBar.get("custom_styles/fg").bg_color = Color(1, 0.8, 0)
		else:
			$Control/StrengthBar.get("custom_styles/fg").bg_color = Color(0.95, 0.2, 0.1)
	else:
		$Control.hide()


func next_level():
	_finish_level_time()
	if PlayerVariables.current_level != PlayerVariables.level.level_3:
		_show_rich_text(level_win_text, PlayerVariables.current_level + 1)
		_hide_rich_text()
		LevelManager.goto_scene(levels.pop_front())
	else:
		get_tree().change_scene("res://EndScreen.tscn")
	PlayerVariables.current_level += 1


func _finish_level_time():
	level_time.append(OS.get_system_time_secs())
	PlayerVariables.time.append(level_time[1] - level_time[0])
	level_time = [OS.get_system_time_secs()]


func _update_label_time_from_level_start(start_time, current_time):
	var timer_time = current_time - start_time
	$Control/Time.text = str(timer_time)


func _print_level_num():
	var text = PlayerVariables.current_level
	text = str(text + 1)
	return text


func _show_rich_text(text, level = ""):
	var bbcode = "[center][wave amp=120 freq=2][rainbow freq=0.1 sat=5 val=20]" + text + str(level) + "[/rainbow][/wave][/center]"
	$RichText.bbcode_text = bbcode
	$RichText.show()


func _hide_rich_text():
	yield(get_tree().create_timer(3.0), "timeout")
	$RichText.hide()


func _on_Button_pressed():
	ball.on_ball_hit_pressed()
