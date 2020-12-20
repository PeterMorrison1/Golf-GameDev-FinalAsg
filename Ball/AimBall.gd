
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dot_resource = preload("res://Ball/AimDot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset(ball_pos):
	position = ball_pos

func draw_aim(mouse_pos, ball_pos, force):
	apply_impulse(Vector2(25, 0), ((mouse_pos - ball_pos) * -1) * force)
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()


func _on_Timer_timeout():
	var dot = dot_resource.instance()
	add_child(dot)
	dot.position = position
