extends KinematicBody2D

export var hp = 2
export (PackedScene) var enemy_bullet

onready var player = get_tree().current_scene.find_node("Player")
onready var canon = $Canon
onready var tire = $Tire

const MOVE_SPEED = 150

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if "Balle" in body.name:
		hp -= 1
	if hp == 0:
		queue_free()


func _on_Tire_timeout():
	var b1 = enemy_bullet.instance()
	var b2 = enemy_bullet.instance()
	var b3 = enemy_bullet.instance()
	b1.creer(canon.global_position, rotation_degrees)
	get_parent().add_child(b1)
	b2.creer(canon.global_position, rotation_degrees + 10)
	get_parent().add_child(b2)
	b3.creer(canon.global_position, rotation_degrees - 10)
	get_parent().add_child(b3)
	tire.start()
