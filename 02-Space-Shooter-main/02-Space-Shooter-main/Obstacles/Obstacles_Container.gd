extends Node2D

onready var Asteroid_1 = load("res://Obstacles/Asteroid_1.tscn")
onready var Asteroid_2 = load("res://Obstacles/Asteroid_2.tscn")
onready var Asteroid_3 = load("res://Obstacles/Asteroid_3.tscn")
onready var Green_Comet = load("res://Obstacles/Green_Comet.tscn")
onready var Magenta_Comet = load("res://Obstacles/Magenta_Comet.tscn")
onready var Planet = load("res://Obstacles/Planet.tscn")
var positions = [Vector2(100, 100), Vector2(200, 500), Vector2(70, 800), Vector2(800, 100), Vector2(-100,20), Vector2(500, 450), Vector2(randf(), -100)]

func _physics_process(_delta):
	if get_child_count() < 10:
		var asteroid_1 = Asteroid_1.instance()
		asteroid_1.position = positions[randi() % positions.size()]
		add_child(asteroid_1)
		var asteroid_2 = Asteroid_2.instance()
		asteroid_2.position = positions[randi() % positions.size()]
		add_child(asteroid_2)
		var asteroid_3 = Asteroid_3.instance()
		asteroid_3.position = positions[randi() % positions.size()]
		add_child(asteroid_3)
		var green_comet = Green_Comet.instance()
		green_comet.position = positions[randi() % positions.size()]
		add_child(green_comet)
		var magenta_comet = Magenta_Comet.instance()
		magenta_comet.position = positions[randi() % positions.size()]
		add_child(magenta_comet)
		var planet = Planet.instance()
		planet.position = positions[randi() % positions.size()]
		add_child(planet)
	
		
