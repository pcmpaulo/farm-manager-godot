extends Node

var title_screen_preload = load("res://scenes/title_screen/title_screen.tscn")

var actual_scene: Node

func _ready():
	actual_scene = title_screen_preload.instantiate()
	add_child(actual_scene)

func change_scene(target_scene, transition = 'fade'):
	var animations = $SceneTransition/AnimationPlayer
	
	# Play transition
	animations.play(transition)
	await animations.animation_finished

	# Remove actual scene and instantiate the new one
	actual_scene.queue_free()
	actual_scene = target_scene.instantiate()
	add_child(actual_scene)
	
	# Play transition backwards
	animations.play_backwards("fade")
