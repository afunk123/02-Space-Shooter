extends KinematicBody2D

var velocity = Vector2(300,300)
var health = 1.0
var speed = 100

var score = 30

func _ready():
	velocity = Vector2(200, randf())

func _physics_process(delta):
	position += velocity*delta
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
		queue_free()
