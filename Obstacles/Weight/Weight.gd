extends RigidBody2D


var altered_pos = Vector2()
var starting_pos

var last_tween

export var altered_y_position: int = -300
export var tween_speed: float = 2

func _ready():
	starting_pos = position
	altered_pos.x = position.x
	altered_pos.y += altered_y_position
	_tween_up()
	last_tween = "up"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if last_tween == "up":
		yield($Tween, "tween_completed")
		$Tween.stop_all()
		_tween_down()
		last_tween = "down"
	elif last_tween == "down":
		yield($Tween, "tween_completed")
		$Tween.stop_all()
		_tween_up()
		last_tween = "up"


func _tween_up():
	$Tween.interpolate_property(self, "position",
		starting_pos, altered_pos, tween_speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _tween_down():
	$Tween.interpolate_property(self, "position",
		altered_pos, starting_pos, tween_speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
