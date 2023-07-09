class_name HQStructure
extends Structure

const spear_upgrade_costs: Array[int] = [40, 60]
const axe_upgrade_costs: Array[int] = [40, 60]
const armor_upgrade_costs: Array[int] = [40, 60]

var held_wood: int = 0
var held_food: int = 0
var spear_tier: int = 0
var axe_tier: int = 0
var armor_tier: int = 0

@onready var wood_label:RichTextLabel = $Icons/WoodIcon/WoodLabel
@onready var food_label:RichTextLabel = $Icons/FoodIcon/FoodLabel
@onready var icons: BoxContainer = $Icons

signal spear_upgraded
signal armor_upgraded
signal axe_upgraded


func _ready():
	icons.hide()
	GlobalGameState.game_started.connect(
		func():
			icons.show()
	)


func store_wood(wood_stored) -> void:
	held_wood += wood_stored
	wood_label.text = "[center]" + str(held_wood)

func store_food(food_stored) -> void:
	held_food += food_stored
	food_label.text = "[center]" + str(held_food)

func attempt_upgrade() -> void:
	var potential_upgrades = []
	
	if spear_tier < 2 && spear_upgrade_costs[spear_tier] <= held_wood:
		potential_upgrades.append(upgrade_spears)
	if axe_tier < 2 && axe_upgrade_costs[axe_tier] <= held_wood:
		potential_upgrades.append(upgrade_axe)
	if armor_tier < 2 && armor_upgrade_costs[armor_tier] <= held_wood:
		potential_upgrades.append(upgrade_armor)
	
	if potential_upgrades.size() > 0:
		potential_upgrades[randi()%potential_upgrades.size()].call()

func upgrade_spears() -> void:
	held_wood -= spear_upgrade_costs[spear_tier]
	spear_tier += 1
	emit_signal("spear_upgraded")
	wood_label.text = "[center]" + str(held_wood)

func upgrade_axe() -> void:
	held_wood -= axe_upgrade_costs[axe_tier]
	axe_tier += 1
	emit_signal("axe_upgraded")
	wood_label.text = "[center]" + str(held_wood)

func upgrade_armor() -> void:
	held_wood -= armor_upgrade_costs[armor_tier]
	armor_tier += 1
	emit_signal("armor_upgraded")
	wood_label.text = "[center]" + str(held_wood)
