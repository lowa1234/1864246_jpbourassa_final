extends RigidBody2D

export var hp = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Petit_body_entered(body):
	if "Balle" in body.name:
		hp -= 1
	if hp == 0:
		queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	pass # Replace with function body.
