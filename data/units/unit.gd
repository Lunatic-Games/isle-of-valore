class_name Unit
extends CharacterBody2D


@export var max_health = 20

var target: Node2D = null
var target_access_point: AccessPoint = null

@onready var health = max_health


func can_target_unit(_unit: Unit):
	return true


func can_target_structure(structure: Structure):
	return structure.access_points.has_unreserved_account_point()


func target_structure(structure: Structure):
	if target_access_point:
		target_access_point.reserved_by_unit = null
	target = structure
	target_access_point = structure.access_points.get_closest_unreserved_access_point(global_position)
	target_access_point.reserved_by_unit = self


func target_unit(unit: Unit):
	if target_access_point:
		target_access_point.reserved_by_unit = null
	target = unit
	target_access_point = null


func clear_target():
	if target_access_point:
		target_access_point.reserved_by_unit = null
		target_access_point = null
	target = null


func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
