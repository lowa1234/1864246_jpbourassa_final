extends Control


onready var health_bar = get_node("HealthBar")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_health_update(health, amount):
	health_bar.value = health
