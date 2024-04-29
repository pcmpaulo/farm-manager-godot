extends HBoxContainer

@export var product_name: String
@export var product_price: float
@export var product_quantity: int

func _ready():
	$Name.text = product_name
	$Quantity.text = str(product_quantity)
	$Price.text = str(product_price)

func _update_row():
	if product_quantity <= 0:
		queue_free()
	$Name.text = product_name
	$Quantity.text = str(product_quantity)
	$Price.text = str(product_price)

func _on_sell_pressed():
	product_quantity -= 1
	_update_row()
	find_parent('Farm').emit_signal('remove_storage', product_name)
	find_parent('Farm').emit_signal('add_money', product_price)

