extends Area2D
@export var teleport:Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().reload_current_scene()
		#get_tree().change_scene_to_file("res://GUI/main_menu.tscn")
		
