extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var end_list = preload("res://Text/EndGameList.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer.add_child(_create_pair("Coins: ", str(PlayerVariables.coins)))
	$CenterContainer/VBoxContainer.add_child(_create_pair("Swings: ",str(PlayerVariables.swings)))
	$CenterContainer/VBoxContainer.add_child(_create_pair("Time Level 1: ", str(PlayerVariables.time[0]) + " Seconds"))
	$CenterContainer/VBoxContainer.add_child(_create_pair("Time Level 2: ", str(PlayerVariables.time[1]) + " Seconds"))
	$CenterContainer/VBoxContainer.add_child(_create_pair("Time Level 3: ", str(PlayerVariables.time[2]) + " Seconds"))
	


func _on_Button_pressed():
	get_tree().change_scene("res://World.tscn")


func _create_pair(label, score):
	var list = end_list.instance()
	var list_items = list.get_children()
	for item in list_items:
		if item.name == "Label":
			item.text = label
		else:
			item.text = score
	return list
