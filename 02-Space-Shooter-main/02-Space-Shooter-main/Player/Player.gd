extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 5.0
var max_speed = 200
var rot_speed = 5.0

var nose = Vector2(31.9, 2.9)

var health = 10.0

var heading_backwards = false
var spiraling = false

onready var Bullet = load("res://Player/Bullet.tscn")
var Effects = null

onready var Explosion = load("res://Effects/Explosion.tscn")

var Bullet_Sound = null

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized()*clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)
	if spiraling: 
		shoot()

func get_input():
	var dir = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		dir += Vector2(1, 0)
		$Exhaust.show()
	if Input.is_action_pressed("Up"):
		rotation_degrees -= rot_speed
	if Input.is_action_pressed("Down"):
		rotation_degrees += rot_speed
	if not spiraling and Input.is_action_just_pressed("Backwards"):
		rotation_degrees += 180
		if heading_backwards == false:
			heading_backwards = true 
		else:
			heading_backwards = false
		$AnimatedSprite.flip_v = heading_backwards
		$Exhaust.flip_v = heading_backwards
		if $Exhaust.flip_v == heading_backwards:
			$Exhaust.global_position += Vector2(0,10)
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	if not spiraling and Input.is_action_just_pressed("Spiral Shot"):
		$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + 360, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		spiraling = true
	return dir.rotated(rotation)
		

func shoot():
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		Bullet_Sound = get_node_or_null("/root/Game/Bullet_Sound")
		if Bullet_Sound != null:
			Bullet_Sound.play()
		var bullet = Bullet.instance()
		Effects.add_child(bullet)
		bullet.rotation = rotation
		bullet.global_position = global_position + nose.rotated(rotation)

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
		Global.update_lives(-1)
	queue_free()
	


func _on_Area2D_body_entered(body):
	if body.name == "Bullet":
		pass
	elif body.name == "Player":
		pass
	elif body.name != "Player":
		if body.has_method("damage"):
			body.damage(100)
		damage(100)


func _on_Tween_tween_all_completed():
	spiraling = false
