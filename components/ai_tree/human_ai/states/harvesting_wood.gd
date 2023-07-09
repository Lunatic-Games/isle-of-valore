extends AIState


var harvest_timer: Timer = null
var tree_harvesting: TreeStructure = null


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("harvesting_wood")
	
	tree_harvesting = human.target as TreeStructure
	human.sprite.flip_h = tree_harvesting.global_position.x > human.global_position.x
	
	if harvest_timer == null:
		harvest_timer = Timer.new()
		harvest_timer.wait_time = human.TIME_TO_HARVEST
		harvest_timer.timeout.connect(_on_harvest_timer_timeout)
		add_child(harvest_timer)
	
	harvest_timer.start()


func update():
	if tree_harvesting == null or tree_harvesting.is_queued_for_deletion() or !tree_harvesting.can_be_harvested():
		ai_tree.transition_to("idle")


func on_exit(_next_state: AIState = null):
	if harvest_timer:
		harvest_timer.stop()


func _on_harvest_timer_timeout():
	var human: Human = unit as Human
	human.amount_wood_held += tree_harvesting.harvest(human.wood_harvested)
	
	if human.amount_wood_held >= human.max_wood_held:
		ai_tree.transition_to("returning_to_hq")
