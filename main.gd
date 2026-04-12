extends Node2D

const HEROI = preload("res://personagens/heroi.tscn")
const PLANTA = preload("res://objetos/planta.tscn")
const CALDEIRAO = preload("res://objetos/caldeirao.tscn")
const FRUTA = preload("res://objetos/ingredientes/fruta.tscn")
const POCAO = preload("res://objetos/pocoes/pocao.tscn")


func _on_level_1_instanciar_fruta(nome_fruta, posicao):
	var nova_fruta : Fruta = FRUTA.instantiate()
	get_tree().current_scene.add_child(nova_fruta)
	nova_fruta.global_position = posicao
	nova_fruta.setup(nome_fruta)


func _on_level_1_instanciar_pocao(pocao, posicao):
	var nova_pocao : Pocao = POCAO.instantiate()
	get_tree().current_scene.add_child(nova_pocao)
	nova_pocao.global_position = posicao
	nova_pocao.setup(pocao.nome)
