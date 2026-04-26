extends Node2D

const HEROI = preload("res://personagens/heroi.tscn")
const PLANTA = preload("res://objetos/planta.tscn")
const CALDEIRAO = preload("res://objetos/caldeirao.tscn")
const FRUTA = preload("res://objetos/ingredientes/fruta.tscn")
const INSETO = preload("res://objetos/ingredientes/insetoide.tscn")
const POCAO = preload("res://objetos/pocoes/pocao.tscn")
const LEVEL0 = preload("res://levels/level_0.tscn")
const LEVEL1 = preload("res://levels/level_1.tscn")
const DEMOIN = preload("res://personagens/demoin.tscn")

@export var game_data : GameData

@onready var heroi : Heroi = $Heroi
@onready var mapa_atual : Node2D = $MapaAtual

func _ready():
	pass


func _on_level_instanciar_fruta(drop : Ingrediente_Res, posicao):
	if drop.tipo == Ingrediente_Res.tipos.INSETO:
		var novo_inseto : Insetoide = INSETO.instantiate()
		get_tree().current_scene.add_child(novo_inseto)
		novo_inseto.global_position = posicao
		novo_inseto.setup(drop)
	elif drop.tipo == Ingrediente_Res.tipos.FRUTA:
		var nova_fruta : Fruta = FRUTA.instantiate()
		get_tree().current_scene.add_child(nova_fruta)
		nova_fruta.global_position = posicao
		nova_fruta.setup(drop)


func _on_level_instanciar_pocao(pocao : Pocao_Res, posicao):
	var nova_pocao : Pocao = POCAO.instantiate()
	get_tree().current_scene.add_child(nova_pocao)
	nova_pocao.global_position = posicao
	nova_pocao.setup(pocao)


func _on_level_inimigo_morreu(being : Area2D):
	game_data.adicionar_score(10)

func _on_level_chamar_mensageiro(new_buffer : Array[String]):
	var interface : InterfacePrincipal = %InterfacePrincipal
	interface.mensageiro.visible = true
	interface.mensageiro.reset_buffer()
	interface.mensageiro.add_buffer(new_buffer)

func _on_level_instanciar_inimigo(parent : Node2D, posicao : Vector2):
	var new_inimigo : Demoin = DEMOIN.instantiate()
	parent.add_child(new_inimigo)
	new_inimigo.global_position = posicao

func _on_level_chamar_proxima_fase():
	var next_level = LEVEL1.instantiate()
	mapa_atual.remove_child($MapaAtual/Level_0)
	mapa_atual.add_child(next_level)
	
	heroi.global_position = Vector2(32,32)
	heroi.posicao_alvo = Vector2(32,32)
	
	next_level.instanciar_fruta.connect(_on_level_instanciar_fruta)
	next_level.instanciar_pocao.connect(_on_level_instanciar_pocao)
	next_level.instanciar_inimigo.connect(_on_level_instanciar_inimigo)
	next_level.inimigo_morreu.connect(_on_level_inimigo_morreu)


func _on_heroi_morreu():
	#game_data.reset_pontuacao()
	get_tree().paused = true
	%GameOver.visible = true


func _on_game_over_game_restart():
	heroi.reset()
	game_data.reset_pontuacao()
	get_tree().paused = false
	get_tree().reload_current_scene()
