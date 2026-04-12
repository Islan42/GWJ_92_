extends Node2D

const HEROI = preload("res://personagens/heroi.tscn")
const PLANTA = preload("res://objetos/planta.tscn")
const CALDEIRAO = preload("res://objetos/caldeirao.tscn")
const FRUTA = preload("res://objetos/ingredientes/fruta.tscn")
const POCAO = preload("res://objetos/pocoes/pocao.tscn")

func instanciar_cena(nome_da_cena:String, posicao:Vector2 = Vector2.ZERO):
	pass

func planta_instancia_fruta(nome, posicao):
	var nova_fruta : Fruta = FRUTA.instantiate()
	get_tree().current_scene.add_child(nova_fruta)
	nova_fruta.global_position = posicao
	nova_fruta.setup(nome)

func _on_planta_instanciar_fruta(nome, posicao):
	planta_instancia_fruta(nome, posicao)

func _on_planta_2_instanciar_fruta(nome, posicao):
	planta_instancia_fruta(nome, posicao)

func _on_planta_3_instanciar_fruta(nome, posicao):
	planta_instancia_fruta(nome, posicao)

func _on_planta_4_instanciar_fruta(nome, posicao):
	planta_instancia_fruta(nome, posicao)

func _on_caldeirao_instanciar_pocao(pocao, posicao):
	var nova_pocao : Pocao = POCAO.instantiate()
	get_tree().current_scene.add_child(nova_pocao)
	nova_pocao.global_position = posicao
	nova_pocao.setup(pocao.nome)
