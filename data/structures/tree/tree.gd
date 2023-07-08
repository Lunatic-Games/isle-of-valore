class_name TreeStructure
extends Structure


const INFUSE_TIMER: float = 3.0
const CURRENCY_GENERATED: int = 5

var remaining_wood: int = 20
var unit_reserving_harvest: Unit = null

@onready var animation_palyer: AnimationPlayer = $AnimationPlayer
@onready var infuse_animator: AnimationPlayer = $InfuseAnimator
@onready var interact_animator: AnimationPlayer = $InteractAnimator
@onready var infused_particles: GPUParticles2D = $InfusedParticles
@onready var harvest_location: Node2D = $HarvestLocation
@onready var interact_label: RichTextLabel = $InteractLabel/InteractLabel

func _ready():
	GlobalGameState.infuse_controller.connect("ready_to_infuse", update_interact_text)

func interact() -> void:
	pass


func infuse():
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	infuse_animator.play("infuse")
	infused_particles.emitting = true
	hide_interactive()


func infuse_trigger() -> void:
	GlobalGameState.HUD.update_currency(CURRENCY_GENERATED)
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	animation_palyer.play("generate_currency")


func show_interactive() -> void:
	update_interact_text()
	interact_animator.play("spawn_interact")


func hide_interactive() -> void:
	interact_animator.play("despawn_interact")


func update_interact_text() -> void:
	if GlobalGameState.infuse_controller.can_infuse:
		interact_label.text = "Press F to infuse"
	else:
		interact_label.text = "Infuse on cooldown"
