extends Node


var current_scene = null
var root

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().get_root()
#	current_scene = root.get_child(root.get_child_count() - 1)
#	current_scene = g.get_nodes_in_group("World")[0]


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene = root.get_child(root.get_child_count() - 1)
	var level = current_scene.get_child(current_scene.get_child_count() - 1)
	if level:
		level.free()
	var scene = ResourceLoader.load(path)
	var scene_inst = scene.instance()
	
	current_scene.add_child(scene_inst)
	
	if get_tree().get_nodes_in_group("Levels").size() > 1:
		get_tree().get_nodes_in_group("Levels")[0].free()
