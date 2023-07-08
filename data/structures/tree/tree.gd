class_name TreeStructure
extends Structure


const INFUSE_TIMER: float = 3.0
const CURRENCY_GENERATED: int = 5

var remaining_wood: int = 20

@onready var animation_palyer: AnimationPlayer = $AnimationPlayer
@onready var infuse_animator: AnimationPlayer = $InfuseAnimator
@onready var infused_particles: GPUParticles2D = $InfusedParticles
@onready var harvest_location: Node2D = $HarvestLocation


func interact() -> void:
	pass


func infuse():
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	infuse_animator.play("infuse")
	infused_particles.emitting = true


func infuse_trigger() -> void:
	GlobalGameState.HUD.update_currency(CURRENCY_GENERATED)
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	animation_palyer.play("generate_currency")
