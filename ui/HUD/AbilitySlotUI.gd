extends ColorRect

@export var sprite: Texture2D
@export var cost: int
@export var index: int = 0
@onready var currency_sprite = $TextureRect
@onready var currenct_text = $CurrencyContainer/CurrencyLeft
@onready var number_label: RichTextLabel = $Number
@onready var cost_label: RichTextLabel = $Cost

func _ready() -> void:
	currency_sprite.texture = sprite
	currenct_text.text = str(cost)
	number_label.text = "[center]Press " + str(index)
	cost_label.text = "[center]Cost: " + str(cost)
