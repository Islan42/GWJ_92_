extends Node2D

signal instanciar_fruta(nome_fruta, posicao)
signal instanciar_pocao(nome_pocao, posicao)

@onready var plantas : Node2D = $Plantas
@onready var caldeiroes : Node2D = $Caldeiroes

func _ready():
	var plantas_array = plantas.get_children()
	for planta in plantas_array:
		planta.instanciar_fruta.connect(on_planta_instanciar_fruta)
	
	var caldeiroes_array = caldeiroes.get_children()
	for caldeirao : Caldeirao in caldeiroes_array:
		caldeirao.instanciar_pocao.connect(on_caldeirao_instanciar_pocao)

func on_planta_instanciar_fruta(nome_fruta, posicao):
	instanciar_fruta.emit(nome_fruta, posicao)

func on_caldeirao_instanciar_pocao(pocao, posicao):
	instanciar_pocao.emit(pocao, posicao)
