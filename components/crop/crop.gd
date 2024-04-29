extends Node2D

class_name Crop

@export var crop_name: String
@export var field: Field

var life_span = 100 

var crops = {
	'potato': {
		'grow_rate': 1.0,
		'texture': preload("res://assets/Crops/Potato.png")
	}
}

func _ready():
	var crop_data = crops[crop_name]
	$GrowthTimer.wait_time = crop_data['grow_rate']
	$Area2D/Sprite2D.texture = crop_data['texture']
	$Area2D/CollisionShape2D.disabled = true
	$Area2D/Sprite2D.frame = 1


func deploy():
	$Area2D/CollisionShape2D.disabled = false
	$Area2D/Sprite2D.frame = 2
	$GrowthTimer.start()


func _on_growth_timer_timeout():
	life_span -= 1
	if life_span == 0:
		$Area2D/Sprite2D.frame = 4
	else:
		if life_span <= 50:
			$Area2D/Sprite2D.frame = 3
		elif life_span > 50:
			$Area2D/Sprite2D.frame = 2
		$GrowthTimer.start()


func _on_area_2d_area_entered(area):
	if area is Scythe and life_span == 0:
		queue_free()
		_add_to_storage()
	
func _add_to_storage():
	get_parent().get_parent().add_storage.emit(crop_name)
