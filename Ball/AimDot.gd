extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", 
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_completed(object, key):
	queue_free()
