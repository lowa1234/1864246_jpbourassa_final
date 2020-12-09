extends KinematicBody2D

signal health_update(health)
signal killed()

var vitesse = 200
var vitesseLat = 100
var velocite = Vector2()

export (PackedScene) var balle
export (float) var max_health = 100

onready var canon = $Canon
onready var ui = get_tree().current_scene.get_node("UI")
onready var health = max_health setget _set_health
onready var invulnerability = $Invulnerability

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	get_input()
	var dir = get_global_mouse_position() - global_position
	var collisions = move_and_collide(velocite * delta) 
	if dir.length() > 5:
		rotation = dir.angle()
		velocite = move_and_slide(velocite)

func get_input():
	var avance = Input.is_action_pressed("ui_up")
	var recule = Input.is_action_pressed("ui_down")
	var droite = Input.is_action_pressed("ui_right")
	var gauche = Input.is_action_pressed("ui_left")
	var shoot = Input.is_action_just_pressed("ui_accept")
	
	if avance:
		velocite = Vector2(vitesse, 0).rotated(rotation)
	if recule:
		velocite = Vector2(-vitesse, 0).rotated(rotation)
	if droite:
		velocite = Vector2(0, vitesseLat).rotated(rotation)
	if gauche:
		velocite = Vector2(0, -vitesseLat).rotated(rotation)
	if shoot:
		var b = balle.instance()
		b.creer(canon.global_position, rotation)
		get_parent().add_child(b)
		$Shoot.play()


func damage(amount):
	if invulnerability.is_stopped():
		invulnerability.start()
		_set_health(health - amount)
		$AnimatedSprite.play("invulnerabilty")

func kill():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_update", health)
		if health == 0:
			kill()
			emit_signal("killed")

func _on_Invulnerability_timeout():
	$AnimatedSprite.play("default")


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
