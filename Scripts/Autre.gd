extends RigidBody2D


export var hp = 2


func _ready():
	pass # Replace with function body.

func _on_Autre_body_entered(body):
	if "Balle" in body.name:
		hp -= 1
	if hp == 0:
		queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	pass # Replace with function body.
