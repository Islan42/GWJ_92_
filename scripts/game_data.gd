extends Resource
class_name GameData

signal atualizar_game_data

var score : int = 0

func adicionar_score(pontuacao : int):
	score += pontuacao
	atualizar_game_data.emit()

func reset_pontuacao():
	score = 0
	atualizar_game_data.emit()
