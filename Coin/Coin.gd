extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Sprite.frame == 4 or $Sprite.frame == 5:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false



func _on_Coin_body_entered(body):
	if body.name == "Ball":
		PlayerVariables.coins += 1
		$Audio.play()
		hide()
		yield($Audio, "finished")
		queue_free()

