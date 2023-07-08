class_name HQStructure
extends Structure


var held_wood: int = 0
var held_food: int = 0

@onready var wood_label:RichTextLabel = $Icons/WoodIcon/WoodLabel


func store_wood(wood_stored) -> void:
	held_wood += wood_stored
	wood_label.text = "[center]" + str(held_wood)
