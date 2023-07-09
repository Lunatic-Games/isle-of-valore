class_name HealthBar
extends ProgressBar


func _ready():
	hide()


func update(ratio: float):
	value = float(max_value) * ratio
	visible = value < max_value
