extends Ingrediente
class_name Inseto

@export var velocidade : float = 1

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var timer_decisao : Timer = $timer_decisao
@onready var raycast : RayCast2D = $RayCast2D

var direcoes : Array[Vector2] = [Vector2(-64,0), Vector2(0,-64), Vector2(64,0), Vector2(0,64)]
var acoes_disponiveis : Array[String] = ["Andar","Andar","Pular","Idle"]

var is_carregado : bool = false
var is_agindo : bool = false
var is_pensando : bool = true
var posicao_alvo : Vector2
var proxima_acao : String

func _ready():
	add_to_group("carregavel")
	animacao.play("idle")
	
	posicao_alvo = position
	reset_timer()

func setup(novo_ingrediente:Ingrediente_Res):
	ingrediente = novo_ingrediente

func _process(delta):
	if not is_agindo and not is_carregado and not is_pensando:
		proxima_acao = acoes_disponiveis.pick_random()
		#print(proxima_acao)
		match proxima_acao:
			"Andar":
				andar()
			"Pular":
				pular()
			"Idle":
				reset_timer()
	if position.is_equal_approx(posicao_alvo):
		is_agindo = false
		animacao.play("idle")
	elif not is_carregado:
		position = position.move_toward(posicao_alvo, 64 * velocidade * delta)
		animacao.play("andar")

func andar():
	var copia_direcoes = direcoes.duplicate()
	copia_direcoes.shuffle()
	for direcao in copia_direcoes:
		raycast.target_position = direcao
		raycast.force_raycast_update()
		if not raycast.is_colliding():
			posicao_alvo = position + direcao
			is_agindo = true
			reset_timer()
			if direcao == Vector2(64,0):
				animacao.flip_h = true
			elif direcao == Vector2(-64,0):
				animacao.flip_h = false
			break

func pular():
	pass
	
func levantar():
	colisao.disabled = true
	is_carregado = true
	animacao.play("carregado")
	
func largar():
	animacao.play("idle")
	colisao.disabled = false
	is_carregado = false
	posicao_alvo = position

func depositar():
	colisao.disabled = true
	is_carregado = true
	animacao.visible = false

func reset_timer():
	is_pensando = true
	timer_decisao.start(randf_range(0.5,3))

func _on_timer_decisao_timeout():
	is_pensando = false
