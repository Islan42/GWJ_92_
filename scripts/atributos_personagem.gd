extends Resource
class_name AtributosPersonagem

signal alterar_atributos

@export var vida : int
@export var vida_maxima : int
@export var forca : int
@export var mana : int
@export var mana_maxima : int
@export var velocidade_movimento : int

func curar(valor : int):
	vida = clamp(vida + valor, 0, vida_maxima)
	alterar_atributos.emit()

func recuperar_mana(valor : int):
	mana = clamp(mana + valor, 0, mana_maxima)
	alterar_atributos.emit()

func ganhar_velocidade(valor : int):
	velocidade_movimento = clamp(velocidade_movimento + valor, 0, 10)
	alterar_atributos.emit()

func ganhar_forca(valor : int):
	forca = clamp(forca + valor, 0, 10)
	alterar_atributos.emit()

func reset(atributos : AtributosPersonagem):
	vida = atributos.vida
	vida_maxima = atributos.vida_maxima
	forca = atributos.forca
	mana = atributos.mana
	mana_maxima = atributos.mana_maxima
	velocidade_movimento = atributos.velocidade_movimento
