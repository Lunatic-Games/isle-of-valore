class_name HealthBar
extends ProgressBar


func _ready():
	hide()


func update(value_ratio: float):
	value = float(max_value) * value_ratio
	visible = value < max_value
