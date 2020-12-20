extends RigidBody2D

var altered_pos = Vector2()
var starting_pos

var last_tween

export var altered_x_position: int = 100

func _ready():
	starting_pos = position
	altered_pos.x += altered_x_position
	altered_pos.y = position.y
	_tween_left()
	last_tween = "left"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if last_tween == "left":
		yield($Tween, "tween_completed")
		$Tween.stop_all()
		_tween_right()
		last_tween = "right"
	elif last_tween == "right":
		yield($Tween, "tween_completed")
		$Tween.stop_all()
		_tween_left()
		last_tween = "left"


func _tween_left():
	$Tween.interpolate_property(self, "position",
		starting_pos, altered_pos, 3.5,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()

func _tween_right():
	$Tween.interpolate_property(self, "position",
		altered_pos, starting_pos, 3.5,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
