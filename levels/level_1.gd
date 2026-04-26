extends Node2D

signal instanciar_fruta(nome_fruta, posicao)
signal instanciar_pocao(nome_pocao, posicao)
signal instanciar_inimigo(parent : Node2D, posicao : Vector2)
signal inimigo_morreu(being : Area2D)

@onready var plantas : Node2D = $Plantas
@onready var caldeiroes : Node2D = $Caldeiroes
@onready var inimigos : Node2D = $Inimigos
@onready var timer : Timer = $SpawnTimer
@onready var enemy_spawn : Marker2D = $EnemySpawn

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
	
	timer.wait_time = randf_range(5, 15)

func on_planta_instanciar_fruta(nome_fruta, posicao):
	instanciar_fruta.emit(nome_fruta, posicao)

func on_caldeirao_instanciar_pocao(pocao, posicao):
	instanciar_pocao.emit(pocao, posicao)


func _on_spawn_timer_timeout():
	if %Inimigos.get_children().size() < 3:
		var direcoes = [Vector2(-1,0), Vector2(-1,-1), Vector2(0,-1), Vector2(1,-1), Vector2(1,0), Vector2(1,1), Vector2(0,1), Vector2(-1,1)]
		var direcao : Vector2 = direcoes.pick_random().normalized() * 64 
		print(direcao)
		var posicao : Vector2 = enemy_spawn.global_position + direcao
		print(posicao)
		instanciar_inimigo.emit(%Inimigos, posicao)
		timer.wait_time = randf_range(5,15)


func _on_inimigos_child_entered_tree(node):
	if node is Demoin:
		node.morreu.connect(func(being : Area2D):
			inimigo_morreu.emit(being)
		)
