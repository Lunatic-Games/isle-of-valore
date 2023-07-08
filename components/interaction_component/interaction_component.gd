class_name InteractComponent
extends Area2D


func interact() -> void:
	get_parent().interact()


func show_interactive() -> void:
	get_parent().show_interactive()


func hide_interactive() -> void:
	get_parent().hide_interactive()
