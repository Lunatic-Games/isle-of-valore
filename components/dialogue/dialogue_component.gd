class_name DialogueComponent
extends Label


const COMBAT_AI_STATE_NAMES: Array[String] = [
	"attacking_unit",
	"going_to_attack_unit",
	"attacking_structure",
	"going_to_attack_structure"
]

@export var min_cooldown: int = 30
@export var max_cooldown: int = 60
@export var dialogue_display_time: int = 5

@export_multiline var combat_dialogues: Array[String]
@export_multiline var random_dialogues: Array[String]
@export_multiline var respawn_dialogues: Array[String]
@export_multiline var start_dialogues: Array[String]

@onready var timer = $Timer
@onready var display_timer = $DisplayTimer
@onready var human: Human = get_parent()


func _ready():
	display_timer.wait_time = dialogue_display_time
	do_start_dialogue(randi_range(0, 3))


func do_start_dialogue(index: int):
	display_dialogue(start_dialogues[index])


func do_respawn_dialogue():
	display_dialogue(respawn_dialogues.pick_random())


func display_dialogue(dialogue_text: String):
	text = dialogue_text
	show()
	
	var next_cooldown: int = randi_range(min_cooldown, max_cooldown)
	timer.wait_time = next_cooldown
	display_timer.start()
	timer.start()


func _on_timer_timeout():
	var current_state: String = human.ai.get_current_state_name()
	if COMBAT_AI_STATE_NAMES.has(current_state):
		display_dialogue(combat_dialogues.pick_random())
	else:
		display_dialogue(random_dialogues.pick_random())


func _on_display_timer_timeout():
	hide()
