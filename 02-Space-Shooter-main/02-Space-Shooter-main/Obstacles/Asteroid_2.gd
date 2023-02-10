extends KinematicBody2D

var velocity = Vector2(100, -100)
var health = 1.0

var score = 10

func _ready():
	velocity.rotated(randf()*PI/2)
	velocity *= (randf() + 2/5)

func _physics_process(delta):
	position += velocity*delta
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
		queue_free()
