class_name ArmorStructure
extends Structure

var current_tier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	await(get_tree().process_frame)
	GlobalGameState.game.island.hq.connect("armor_upgraded", update_texture)

func update_texture():
	if current_tier == 1:
		$CopperArmor.visible = true
	if current_tier == 2:
		$IronArmor.visible = true
