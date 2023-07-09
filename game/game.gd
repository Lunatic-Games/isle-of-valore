class_name Game
extends Node2D


const RESPAWN_TIMER_SCENE = preload("res://game/respawn_timer/human_respawn_timer.tscn")
const HUMAN_SCENE = preload("res://data/units/human/human.tscn")

@onready var island: Island = $Island
@onready var humans = [$Human, $Human2, $Human3, $Human4]
@onready var respawn_marker: Node2D = $RespawnMarker


func _ready() -> void:
	randomize()
	
	GlobalGameState.game = self
	for human in humans:
		human.died.connect(_on_human_died)


func _on_human_died():
	var respawn_timer: Timer = RESPAWN_TIMER_SCENE.instantiate()
	add_child(respawn_timer)
	respawn_timer.timeout.connect(_on_respawn_timer_timeout.bind(respawn_timer))


func _on_respawn_timer_timeout(timer: Timer):
	var new_human: Human = HUMAN_SCENE.instantiate()
	add_child(new_human)
	new_human.global_position = respawn_marker.global_position
	new_human.dialogue.do_respawn_dialogue()
	humans.append(new_human)
	new_human.died.connect(_on_human_died)
	timer.queue_free()
