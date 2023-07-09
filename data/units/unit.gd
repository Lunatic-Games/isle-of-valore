class_name Unit
extends CharacterBody2D


@export var max_health: int = 20
@export var time_to_attack: float = 1.0

var target: Node2D = null
var target_access_point: AccessPoint = null

@onready var health: int = max_health
@onready var access_points: AccessPointContainer = $AccessPointContainer
@onready var unit_sight_range: Area2D = $UnitSightRange
@onready var health_bar: ProgressBar = $HealthBar


func can_target_unit(unit: Unit, allow_reserved: bool = false):
	if allow_reserved:
		return unit.access_points.has_an_access_point()
	return unit.access_points.has_unreserved_access_point()


func can_target_structure(structure: Structure, allow_reserved: bool = false):
	if allow_reserved:
		return structure.access_points.has_an_access_point()
	return structure.access_points.has_unreserved_access_point()


func target_structure(structure: Structure):
	if is_instance_valid(target_access_point):
		target_access_point.reserved_by_unit = null
	target = structure
	target_access_point = structure.access_points.get_closest_access_point(global_position)
	if target_access_point.reserved_by_unit == null:
		target_access_point.reserved_by_unit = self


func target_unit(unit: Unit):
	if is_instance_valid(target_access_point):
		target_access_point.reserved_by_unit = null
	target = unit
	target_access_point = unit.access_points.get_closest_access_point(global_position)
	target_access_point.reserved_by_unit = self


func clear_target():
	if target_access_point != null:
		if is_instance_valid(target_access_point):
			target_access_point.reserved_by_unit = null
		target_access_point = null
	target = null


func damage(amount: int):
	health = max(health - amount, 0)
	health_bar.update(float(health) / float(max_health))
	if health <= 0:
		queue_free()


func heal(amount: int):
	health = min(health + amount, max_health)
	health_bar.update(float(health) / float(max_health))
