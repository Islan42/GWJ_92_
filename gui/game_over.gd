extends CanvasLayer

signal game_restart

@export var game_data : GameData

@onready var label : Label = %Score

func _ready():
	game_data.atualizar_game_data.connect(_on_gamedata_atualizar)

func _on_gamedata_atualizar():
	label.text = "Score: " + String.num(game_data.score)

func _on_button_pressed():
	game_restart.emit()
