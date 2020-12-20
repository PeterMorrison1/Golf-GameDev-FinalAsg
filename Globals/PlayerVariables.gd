extends Node


var coins = 0
var swings = 0
var time_level_1 = 0
var time_level_2 = 0
var time_level_3 = 0
var time = []

enum level {level_1, level_2, level_3, end, start}
var current_level = level.level_1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _reset():
	coins = 0
	swings = 0
	time_level_1 = 0
	time_level_2 = 0
	time_level_3 = 0
	time = []
	current_level = level.level_1
