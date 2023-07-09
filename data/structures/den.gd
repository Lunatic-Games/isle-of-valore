class_name Den
extends Structure

const MAX_TIER: int = 3

var current_tier: int = 1
var can_interact: bool = false

@export var tier_cost: Array[int] = [0, 0]
@onready var interact_animator: AnimationPlayer = $InteractAnimator
@onready var interact_label: RichTextLabel = $InteractLabel/InteractLabel
@onready var tier_2_particles: GPUParticles2D = $Tier2Particles
@onready var tier_3_particles: GPUParticles2D = $Tier3Particles

func interact() -> void:
	if current_tier == MAX_TIER or GlobalGameState.HUD.currency < tier_cost[current_tier-1]:
		return
	
	GlobalGameState.player.do_casting_animation()
	GlobalGameState.HUD.update_currency(-tier_cost[current_tier-1])
	current_tier += 1
	interact_animator.play("despawn_interact")
	update_interact_text()
	
	if current_tier == 2:
		tier_2_particles.emitting = true
	if current_tier == 3:
		tier_3_particles.emitting = true


func show_interactive() -> void:
	update_interact_text()
	can_interact = true
	if current_tier != MAX_TIER:
		interact_animator.play("spawn_interact")


func hide_interactive() -> void:
	can_interact = false
	if current_tier != MAX_TIER:
		interact_animator.play("despawn_interact")

func update_interact_text() -> void:
	if current_tier != MAX_TIER:
		interact_label.text = "[center]Press F to upgrade: " + str(tier_cost[current_tier-1]) + " acorns"
