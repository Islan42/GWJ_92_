extends Area2D
class_name Demoin

signal morreu(being : Area2D)

@export var velocidade : float = 3.0
@export var hp : int = 3

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var timer_atack : Timer = $TimerAtack
@onready var zona_de_atencao : Area2D = $ZonaDeAtencao
@onready var raycast : RayCast2D = $RayCast2D
@onready var atack_raycast : RayCast2D = $AtackRaycast

var direcoes : Array[Vector2] = [Vector2(-64,0), Vector2(0,-64), Vector2(64,0), Vector2(0,64)]

var alvo_localizado : bool = false
var alvo : Heroi
var ataque_1 : bool = true
var is_atack_cd : bool = false
var is_atacando : bool = false
var is_andando : bool = false
var posicao_alvo : Vector2
var direcao_olhar : Vector2

func _ready():
	animacao.play("idle_frente")
	posicao_alvo = position

func _process(delta):
	localizar_alvo()
	atacar()
	andar(delta)
	animar()

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
					is_andando = true
					posicao_alvo = nova_posicao
					direcao_olhar = direcao
					atack_raycast.target_position = direcao
					break

func andar(delta):
	if is_andando:
		position = position.move_toward(posicao_alvo, 64 * velocidade * delta)
		if position.is_equal_approx(posicao_alvo):
			is_andando = false
func atacar():
	if not is_atack_cd and atack_raycast.is_colliding():
		is_atacando = true
		is_atack_cd = true
		timer_atack.start(3)
		
		var heroi : Heroi = atack_raycast.get_collider()
		heroi.tomar_dano(1)
		
		ataque_1 = not ataque_1

func animar():
	var animation_name = ""
	animacao.flip_h = false
	
	if is_atacando:
		if ataque_1:
			animation_name = "ataque_1"
		else:
			animation_name = "ataque_2"
	else:
		animation_name = "idle"
	
	match direcao_olhar:
		Vector2(-64,0):
			animation_name += "_lado"
			animacao.flip_h = true
		Vector2(0,-64):
			animation_name += "_costas"
		Vector2(64,0):
			animation_name += "_lado"
			animacao.flip_h = false
		Vector2(0,64):
			animation_name += "_frente"
	if animacao.sprite_frames.has_animation(animation_name):
		animacao.play(animation_name)

func tomar_dano(forca : int):
	hp -= forca
	if hp <= 0:
		morreu.emit(self)
		call_deferred("queue_free")

func _on_timer_atack_timeout():
	is_atack_cd = false

func _on_zona_de_atencao_area_entered(area):
	if area is Heroi:
		alvo = area
		alvo_localizado = true

func _on_zona_de_atencao_area_exited(area):
	if area is Heroi:
		alvo = null
		alvo_localizado = false
		print("Dxa qto", alvo)

func _on_animated_sprite_2d_animation_finished():
	if animacao.animation.contains("ataque"):
		is_atacando = false
