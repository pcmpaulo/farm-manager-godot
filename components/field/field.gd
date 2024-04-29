extends Node2D

class_name Field

func _ready():
	$Area2D/CollisionShape2D.disabled = true
	
func deploy():
	$Area2D/CollisionShape2D.disabled = false
