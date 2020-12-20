extends RigidBody2D


# Hitting ball
var aiming: bool = false
var aiming_direction: float = 0.0
var mouse_pos: Vector2 = get_global_mouse_position()
var ball_strength: int = 0
export var base_strength: int = 5

# Ball moving
var ball_hit: bool = false


# Aiming ball
const AimBall = preload("res://Ball/AimBall.tscn")
var aim_ball
var aiming_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	aiming = false


func _aim():
	if aiming and mouse_pos.distance_to(position) < 100:
		aiming_direction = get_angle_to(mouse_pos) + deg2rad(270)
		var distance = mouse_pos.distance_to(position)
		if distance < 100:
			ball_strength = distance 
			_update_strength_bar(distance)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not aiming and event.pressed:
			aiming = true
		if aiming and not event.pressed:
			aiming = false
	# Update with location of mouse if aiming (left click held)
	if event is InputEventMouseMotion and aiming == true:
		mouse_pos = event.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_aim()
	if !is_sleeping():
		ball_hit = true
	else:
		_draw_aim_ball()
		ball_hit = false

func _draw_aim_ball():
	if aiming:
		if aiming_array.size() < 1:
			aim_ball = AimBall.instance()
			add_child(aim_ball)
			aiming_array.append(aim_ball)
			aim_ball.draw_aim(mouse_pos, position, _ball_strength())
		else:
			if !aiming_array[0]:
				aiming_array.pop_front()
	else:
		for item in aiming_array:
			if item:
				item.queue_free()
				aiming_array.pop_front()

# Calculates the strength of the ball/hit
func _ball_strength():
	var percent_strength = float(ball_strength) / 100.0
	var strength = base_strength * percent_strength
	return strength

# Called when the button to hit the ball is pressed
func on_ball_hit_pressed():
	if ball_hit == false:
		apply_impulse(Vector2(25, 0), ((mouse_pos - position) * -1) * _ball_strength())
		PlayerVariables.swings += 1

func _update_strength_bar(distance):
	get_tree().get_nodes_in_group('StrengthBar')[0].value = distance


func _on_Ball_body_entered(body):
	$Audio.play()
