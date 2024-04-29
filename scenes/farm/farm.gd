extends Node2D

class_name Farm

const GRID_SIZE: Vector2 = Vector2(32, 32)

@onready var main_scene: Node = get_tree().root.get_node("Main")

signal add_storage(product_name)
signal remove_storage(product_name)
signal add_money(quantity)

var stick_on_grid: bool = true
var node_on_cursor
var storage = {
	"potato": 3,
	"carrot": 2
}
var money: int = 0

func _ready():
	$CanvasLayer/GameHud.parent_scene = self

func _process(delta: float) -> void:
	_set_cursor_position()

func _set_cursor_position():
	if node_on_cursor:
		if stick_on_grid:
			var mouse_position = get_global_mouse_position()
			var global_to_grid = Vector2(
				int(mouse_position.x / GRID_SIZE.x),
				int(mouse_position.y / GRID_SIZE.y)
			)
			node_on_cursor.position = global_to_grid * GRID_SIZE
		else:
			node_on_cursor.position = get_global_mouse_position()


func _input(event):
	if node_on_cursor:
		if event is InputEventMouseButton and event.pressed:
			# TODO: Check if has something in this position
			if _check_deploy_position():
				if node_on_cursor is Crop:
					node_on_cursor.field = _get_field_by_position(node_on_cursor.position)
				node_on_cursor.deploy()
				node_on_cursor = null
		elif event.is_action_pressed("ui_cancel"):
			cancel_node_on_cursor()


func _check_deploy_position():
	var deploy_position = node_on_cursor.position
	if node_on_cursor is Field:
		return _get_field_by_position(deploy_position, [node_on_cursor]) == null
	elif node_on_cursor is Crop:
		if _get_field_by_position(deploy_position):
			return _get_crop_by_position(deploy_position, [node_on_cursor]) == null
	return false

func _get_field_by_position(target_position: Vector2, exceptions = []):
	for field in $Fields.get_children():
		if field not in exceptions and field.position == target_position:
			return field

func _get_crop_by_position(target_position: Vector2, exceptions = []):
	for crop in $Crops.get_children():
		if crop not in exceptions and crop.position == target_position:
			return crop

func cancel_node_on_cursor():
	if node_on_cursor:
		node_on_cursor.queue_free()
		node_on_cursor = null

func handle_node(target_node, _stick_on_grid: bool = true):
	cancel_node_on_cursor()
	stick_on_grid = _stick_on_grid
	node_on_cursor = target_node
	if node_on_cursor is Field:
		$Fields.add_child(node_on_cursor)
	elif node_on_cursor is Crop:
		$Crops.add_child(node_on_cursor)
	else:
		$Tools.add_child(node_on_cursor)


func _on_add_storage(product_name):
	if product_name in storage.keys():
		storage[product_name] += 1
	else:
		storage[product_name] = 1


func _on_remove_storage(product_name):
	storage[product_name] -= 1
	if storage[product_name] <= 0:
		storage.erase(product_name)

func _on_add_money(quantity: int):
	money += quantity
	print(money)


