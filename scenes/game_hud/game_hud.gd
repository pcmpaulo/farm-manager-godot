extends Control

@export var parent_scene: Node2D

var field_preload = preload("res://components/field/field.tscn")
var crop_preload = preload("res://components/crop/crop.tscn")
var scythe_preload = preload("res://components/scythe/scythe.tscn")

var market_preload = preload("res://scenes/market/market.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel") and has_node('Market'):
		get_node('Market').queue_free()

func _on_field_pressed():
	var field = field_preload.instantiate()
	parent_scene.handle_node(field)


func _on_potato_pressed():
	var crop = crop_preload.instantiate()
	crop.crop_name = 'potato'
	parent_scene.handle_node(crop)


func _on_scythe_pressed():
	var scythe = scythe_preload.instantiate()
	parent_scene.handle_node(scythe, false)


func _on_market_pressed():
	parent_scene.cancel_node_on_cursor()
	var market = market_preload.instantiate()
	market.farm = parent_scene
	add_child(market)
