extends Control

@export var game_data : GameData

func _ready():
	game_data.atualizar_game_data.connect(atualizar_hud)
	atualizar_hud()

func atualizar_hud():
	var label : Label = %Label
	label.text = String.num(game_data.score).lpad(2,"0")
