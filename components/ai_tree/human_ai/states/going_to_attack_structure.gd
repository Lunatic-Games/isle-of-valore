extends AIState


var sight_area: Area2D = null


func _ready() -> void:
	sight_area = Area2D.new()
	add_child(sight_area)
	
	var human: Human = unit as Human
	var collider: CollisionShape2D = CollisionShape2D.new()
	collider.shape = CircleShape2D.new()
	collider.shape.radius = human.ENEMY_STRUCTURE_SIGHT_RANGE
	sight_area.add_child(collider)


func should_auto_transition() -> bool:
	return false
