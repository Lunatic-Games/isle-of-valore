extends ColorRect


@onready var human_1: Human = $"../../Human"
@onready var human_2: Human = $"../../Human2"
@onready var human_3: Human = $"../../Human3"
@onready var human_4: Human = $"../../Human4"

func _ready():
	if visible:
		get_tree().paused = true
	else:
		GlobalGameState.game_started.emit()


func _input(event):
	if visible and event.is_action_pressed("perform_ability"):
		hide()
		$AnimationPlayer.play("intro")


func play_dialogue_1():
	human_1.dialogue.display_dialogue("Y'all ready to play?", true)

func play_dialogue_2():
	human_2.dialogue.display_dialogue("Heck yeah, let's start cutting down some trees for wood.", true)

func play_dialogue_3():
	human_3.dialogue.display_dialogue("There should be animals around we can hunt for food.", true)

func play_dialogue_4():
	human_4.dialogue.display_dialogue("Hopefully we can reach the end-game before they destroy our base!", true)
	
func play_dialogue_5():
	human_1.dialogue.display_dialogue("I'll show those animals no mercy...", true)

func play_dialogue_6():
	human_2.dialogue.display_dialogue("That last one sounded intentionally evil for the sake of plot...", true)

func done_cutscene():
	get_tree().paused = false
	GlobalGameState.game_started.emit()
