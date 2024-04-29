extends Control


@onready var main_scene: Node = get_tree().root.get_node("Main")

func _on_start_pressed():
	main_scene.change_scene(load("res://scenes/farm/farm.tscn"))


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
