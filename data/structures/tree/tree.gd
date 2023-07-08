class_name TreeStructure
extends Structure


const INFUSE_TIMER: float = 3.0
const CURRENCY_GENERATED: int = 5

var remaining_wood: int = 20
var unit_reserving_harvest: Unit = null
var infused: bool = false

@onready var animation_palyer: AnimationPlayer = $AnimationPlayer
@onready var infuse_animator: AnimationPlayer = $InfuseAnimator
@onready var interact_animator: AnimationPlayer = $InteractAnimator
@onready var infused_particles: GPUParticles2D = $InfusedParticles
@onready var harvest_location: Node2D = $HarvestLocation
@onready var interact_label: RichTextLabel = $InteractLabel/InteractLabel
@onready var tree_cut_animator: AnimationPlayer = $TreeCutAnimator

func _ready():
	GlobalGameState.infuse_controller.connect("ready_to_infuse", update_interact_text)

func interact() -> void:
	if GlobalGameState.HUD.currency >= GlobalGameState.infuse_controller.cost_to_infuse && !infused && GlobalGameState.infuse_controller.can_infuse:
		infuse()
		infused = true
		GlobalGameState.HUD.update_currency(-GlobalGameState.infuse_controller.cost_to_infuse)
		GlobalGameState.infuse_controller.start_cooldown()


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
	if !infused:
		interact_animator.play("spawn_interact")


func hide_interactive() -> void:
	if !infused:
		interact_animator.play("despawn_interact")


func update_interact_text() -> void:
	if GlobalGameState.infuse_controller.can_infuse:
		interact_label.text = "[center]Press F to infuse"
	else:
		interact_label.text = "[center]Infuse on cooldown[/center]"


func can_be_harvested() -> bool:
	return remaining_wood > 0


func harvest() -> int:
	remaining_wood -= 1
	
	if remaining_wood <= 0:
		if infused:
			tree_cut_animator.play("fell_tree_infused")
		else:
			tree_cut_animator.play("fell_tree")
	else:
		tree_cut_animator.play("harvest_wood")
	
	return 1
