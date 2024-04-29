extends Control

@export var farm: Farm

@onready var rows = $MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/MarginContainer2/Rows

var table_row_preload = preload("res://components/row/row.tscn")

func _ready():
	_populate_table()


func _populate_table():
	for product in farm.storage.keys():
		var product_data = farm.storage[product]
		var product_row = table_row_preload.instantiate()
		product_row.product_name = product
		product_row.product_price = 1
		product_row.product_quantity = product_data
		rows.add_child(product_row)
