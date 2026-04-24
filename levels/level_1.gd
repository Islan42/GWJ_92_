extends Node2D

signal instanciar_fruta(nome_fruta, posicao)
signal instanciar_pocao(nome_pocao, posicao)
signal inimigo_morreu(being : Area2D)

@onready var plantas : Node2D = $Plantas
@onready var caldeiroes : Node2D = $Caldeiroes
@onready var inimigos : Node2D = $Inimigos

func _ready():
	var plantas_array = plantas.get_children()
	for planta in plantas_array:
		planta.instanciar_fruta.connect(on_planta_instanciar_fruta)
	
	var caldeiroes_array = caldeiroes.get_children()
	for caldeirao : Caldeirao in caldeiroes_array:
		caldeirao.instanciar_pocao.connect(on_caldeirao_instanciar_pocao)
	
	var inimigos_array = inimigos.get_children()
	for inimigo in inimigos_array:
		inimigo.morreu.connect(func(being : Area2D):
			inimigo_morreu.emit(being)
		)

func on_planta_instanciar_fruta(nome_fruta, posicao):
	instanciar_fruta.emit(nome_fruta, posicao)

func on_caldeirao_instanciar_pocao(pocao, posicao):
	instanciar_pocao.emit(pocao, posicao)
