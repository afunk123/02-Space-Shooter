extends Control


func _ready():
	$Label.text = "Give it another shot! Your score was: " + str(Global.score) + "."


func _on_Play_pressed():
	Global.reset()
	var _scene = get_tree().change_scene("res://Game.tscn")
