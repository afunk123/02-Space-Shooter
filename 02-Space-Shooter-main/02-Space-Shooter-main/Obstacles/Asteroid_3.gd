extends KinematicBody2D

var velocity = Vector2(randf(), randf())
var health = 1.0

var score = 10

func _ready():
	velocity.rotated(randf()*7*PI)
	velocity *= (randf())

func _physics_process(delta):
	position += velocity*delta
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
		queue_free()
