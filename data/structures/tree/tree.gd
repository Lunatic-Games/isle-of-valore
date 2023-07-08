class_name TreeStructure
extends Structure


const INFUSE_TIMER: float = 3.0
const CURRENCY_GENERATED: int = 5

@onready var infused_label: RichTextLabel = $InfusedLabel
@onready var animation_palyer: AnimationPlayer = $AnimationPlayer


func interact() -> void:
	pass


func infuse():
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	infused_label.visible = true


func infuse_trigger() -> void:
	GlobalGameState.HUD.update_currency(CURRENCY_GENERATED)
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
	animation_palyer.play("generate_currency")
