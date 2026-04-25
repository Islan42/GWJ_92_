extends Control

const MAIN = preload("res://main.tscn")

func _ready():
	$AnimationPlayer.play("idle")

func _on_new_game_button_pressed():
	get_tree().change_scene_to_packed(MAIN)
