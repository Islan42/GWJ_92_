extends Area2D

@export var velocidade : float = 3.0

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var timer_atack : Timer = $TimerAtack

var alvo_localizado : bool = false
var ataque_1 : bool = true
var is_atacando : bool = false
var posicao_alvo : Vector2

func _ready():
	animacao.play("idle_frente")
	posicao_alvo = position

func _process(delta):
	if not is_atacando:
		is_atacando = true
		timer_atack.start(3)
		
		if ataque_1:
			animacao.play("ataque_1_frente")
			ataque_1 = false
		else:
			animacao.play("ataque_2_frente")
			ataque_1 = true


func _on_timer_atack_timeout():
	is_atacando = false
