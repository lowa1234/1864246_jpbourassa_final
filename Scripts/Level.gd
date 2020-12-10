extends Node2D


var petit = preload("res://scenes/Petit.tscn")
var gros = preload("res://scenes/Gros.tscn")
var autre = preload("res://scenes/Autre.tscn")

export var saferadius = 200
export var nb_ennemis = 5

onready var player = get_tree().current_scene.find_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() == 0:
		var avoid = player.position
		for i in range(nb_ennemis):
			var child
			match randi() %3:
				0: child = petit.instance()
				1: child = gros.instance()
				2: child = autre.instance()
			var where = avoid
			while (where - avoid).length() <= saferadius:
				where.x = rand_range(0, get_viewport().size.x)
				where.y = rand_range(0, get_viewport().size.y)
			child.position = where
			add_child(child)
	pass
