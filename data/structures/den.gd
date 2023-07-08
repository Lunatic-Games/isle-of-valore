class_name Den
extends Structure

const MAX_TIER: int = 3

var current_tier: int = 1

@export var tier_cost: Array[int] = [0, 0]
@onready var interact_animator: AnimationPlayer = $InteractAnimator
@onready var interact_label: RichTextLabel = $InteractLabel/InteractLabel

func interact() -> void:
	if GlobalGameState.HUD.currency < tier_cost[current_tier-1]:
		return
	
	GlobalGameState.HUD.update_currency(-tier_cost[current_tier-1])
	current_tier += 1
	interact_animator.play("despawn_interact")
	update_interact_text()


func show_interactive() -> void:
	update_interact_text()
	if current_tier != MAX_TIER:
		interact_animator.play("spawn_interact")


func hide_interactive() -> void:
	if current_tier != MAX_TIER:
		interact_animator.play("despawn_interact")

func update_interact_text() -> void:
	if current_tier != MAX_TIER:
		interact_label.text = "[center]Press F to upgrade: " + str(tier_cost[current_tier-1]) + " presence"
