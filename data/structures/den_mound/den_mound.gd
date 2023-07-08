class_name DenMound
extends Structure

const SQUIRREL_DEN_SCENE: PackedScene = preload("res://data/structures/squirrel_den/squirrel_den.tscn")
const WOLF_DEN_SCENE: PackedScene = preload("res://data/structures/wolf_den/wolf_den.tscn")
const BEAR_DEN_SCENE: PackedScene = preload("res://data/structures/bear_den/bear_den.tscn")

@onready var interact_animator: AnimationPlayer = $InteractAnimator
@onready var den_container: HBoxContainer = $DenContainer
@onready var interact_label: RichTextLabel = $InteractLabel/InteractLabel

var is_purchasing_den: bool = false
var current_den: Den = null
var wolf_den_cost: int = 40
var bear_den_cost: int = 90
var squirrel_den_cost: int = 65

func interact() -> void:
	interact_label.text = "[center]Press the number to build the den"
	den_container.visible = true
	is_purchasing_den = true

func show_interactive() -> void:
	interact_label.text = "[center]Press F to select a den to build[/center]"
	interact_animator.play("spawn_interact")


func hide_interactive() -> void:
	interact_animator.play("despawn_interact")
	den_container.visible = false
	is_purchasing_den = false

func _process(delta: float) -> void:
	if is_purchasing_den:
		if Input.is_action_just_pressed("purchase_slot_1"):
			spawn_wolf_den()
		if Input.is_action_just_pressed("purchase_slot_2"):
			spawn_squirrel_den()
		if Input.is_action_just_pressed("purchase_slot_3"):
			spawn_bear_den()


func spawn_wolf_den() -> void:
	if GlobalGameState.HUD.currency < wolf_den_cost:
		return
	
	var den: Den = WOLF_DEN_SCENE.instantiate()
	den.global_position = Vector2(global_position.x, global_position.y)
	GlobalGameState.game.add_child(den)
	GlobalGameState.HUD.update_currency(-wolf_den_cost)
	current_den = den
	visible = false


func spawn_squirrel_den() -> void:
	if GlobalGameState.HUD.currency < squirrel_den_cost:
		return
	
	var squirrel_den: Den = SQUIRREL_DEN_SCENE.instantiate()
	squirrel_den.global_position = Vector2(global_position.x, global_position.y)
	GlobalGameState.game.add_child(squirrel_den)
	GlobalGameState.HUD.update_currency(-squirrel_den_cost)
	current_den = squirrel_den
	visible = false

func spawn_bear_den() -> void:
	if GlobalGameState.HUD.currency < bear_den_cost:
		return
		
	var bear_den: Den = BEAR_DEN_SCENE.instantiate()
	bear_den.global_position = Vector2(global_position.x, global_position.y)
	GlobalGameState.game.add_child(bear_den)
	GlobalGameState.HUD.update_currency(-bear_den_cost)
	current_den = bear_den
	visible = false
