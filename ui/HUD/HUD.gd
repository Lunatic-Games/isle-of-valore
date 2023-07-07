class_name HUD
extends CanvasLayer

var currency = 30

func _ready() -> void:
	GlobalGameState.HUD = self

func update_currency(amount):
	currency += amount
	$CurrencyContainer/CurrencyLeft.text = str(currency)
