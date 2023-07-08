extends ColorRect

@export var sprite: Texture2D
@export var cost: int
@onready var currency_sprite = $TextureRect
@onready var currenct_text = $CurrencyContainer/CurrencyLeft

func _ready() -> void:
	currency_sprite.texture = sprite
	currenct_text.text = str(cost)
