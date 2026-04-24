extends Area2D
class_name Demoin

signal morreu(being : Area2D)

@export var velocidade : float = 3.0
@export var hp : int = 2

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var timer_atack : Timer = $TimerAtack
@onready var zona_de_atencao : Area2D = $ZonaDeAtencao
@onready var colisao_zdatk : CollisionShape2D = $ZonaDeAtaque/ColisaoZDAtk
@onready var zona_de_ataque : Area2D = $ZonaDeAtaque
@onready var raycast : RayCast2D = $RayCast2D

var direcoes : Array[Vector2] = [Vector2(-64,0), Vector2(0,-64), Vector2(64,0), Vector2(0,64)]

var alvo_localizado : bool = false
var alvo : Heroi
var ataque_1 : bool = true
var is_atacando : bool = false
var is_andando : bool = false
var posicao_alvo : Vector2
var direcao_olhar : Vector2

func _ready():
	animacao.play("idle_frente")
	posicao_alvo = position

func _process(delta):
	zona_de_ataque.position = direcao_olhar
	
	localizar_alvo()
	#atacar()
	andar(delta)

func localizar_alvo():
	if alvo_localizado and not is_andando:
		for direcao in direcoes:
			raycast.target_position = direcao
			raycast.force_raycast_update()
			
			if not raycast.is_colliding():
				var nova_posicao = global_position + direcao
				var nova_distancia = alvo.global_position.distance_squared_to(nova_posicao)
				var velha_distancia = alvo.global_position.distance_squared_to(global_position)
				
				if nova_distancia <= velha_distancia:
					#print(nova_distancia, ":", global_position, "=>", nova_posicao)
					is_andando = true
					posicao_alvo = nova_posicao
					direcao_olhar = direcao
					break

func andar(delta):
	if is_andando:
		position = position.move_toward(posicao_alvo, 64 * velocidade * delta)
		if position.is_equal_approx(posicao_alvo):
			is_andando = false
func atacar(area):
	if not is_atacando:
		is_atacando = true
		colisao_zdatk.disabled = true
		timer_atack.start(3)
		
		if area.has_method("tomar_dano"):
			area.tomar_dano()
		
		if ataque_1:
			animacao.play("ataque_1_frente")
			ataque_1 = false
		else:
			animacao.play("ataque_2_frente")
			ataque_1 = true

func tomar_dano():
	hp -= 1
	if hp <= 0:
		morreu.emit(self)
		call_deferred("queue_free")

func _on_timer_atack_timeout():
	is_atacando = false
	colisao_zdatk.disabled = false

func _on_zona_de_atencao_area_entered(area):
	if area is Heroi:
		alvo = area
		alvo_localizado = true
		#print("Vou pega-lo", alvo)

func _on_zona_de_atencao_area_exited(area):
	if area is Heroi:
		alvo = null
		alvo_localizado = false
		print("Dxa qto", alvo)

func _on_zona_de_ataque_area_entered(area):
	if area is Heroi:
		atacar(area)
