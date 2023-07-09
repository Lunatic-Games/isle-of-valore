class_name WeaponStructure
extends Structure

var current_tier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	await(get_tree().process_frame)
	GlobalGameState.game.island.hq.connect("spear_upgraded", update_texture)

func update_texture():
	if current_tier == 1:
		$CopperSpears.visible = true
	if current_tier == 2:
		$IronSpears.visible = true
